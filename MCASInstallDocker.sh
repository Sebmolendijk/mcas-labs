#!/bin/bash

RED="\033[31m"
BLUE="\033[1;34m"
WHITE="\033[0m"

exit_on_error() {
    echo "Error code: "$?
    echo -e ${RED}${1}${WHITE}
    exit 1
}

ubuntu_remove_older() {
    apt-get remove docker docker-engine docker.io > /dev/null 2>&1 || \
        echo -e ${RED}"Failed removing older versions, will try to continue..."
}

rhel_remove_older() {
    yum erase docker docker-engine docker.io > /dev/null 2>&1 || \
        echo -e ${RED}"Failed removing older versions, will try to continue..."
}

remove_older() {
    if [ "${OS,,}" == "ubuntu" ]; then
        ubuntu_remove_older
    elif [ "${OS,,}" == "red hat" ]; then
        rhel_remove_older
    elif [ "${OS,,}" == "suse" ]; then
        :
    else
        echo -e ${RED}"Unsupported OS"${WHITE}
        exit 1
    fi
}

install_image_extra() {
    echo "Installing linux-image-extra package..."
    apt-get update -y > /dev/null 2>&1

    sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual > /dev/null 2>&1
}

ubuntu_install_engine() {
    #install image-extra if dealing with 14.04
    if [[ `lsb_release -r` =~ "14" ]]; then
        install_image_extra || exit_on_error "Failed installing linux-image-extra"
    fi;

    echo "Preparing to install Docker engine..."
    apt-get update -y > /dev/null 2>&1
    
    ( apt-get install -y apt-transport-https ca-certificates curl software-properties-common > /dev/null 2>&1 && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -  > /dev/null 2>&1 ) || exit_on_error "Failed setting GPG key"
    
    if [[ ! `apt-key fingerprint 2>/dev/null | grep uid` =~ "docker@docker.com" ]]; then
        echo -e ${RED}"Wrong fingerprint"${WHITE}
        exit 1
    fi;
    
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /dev/null 2>&1 || \
    exit_on_error "Failed adding repo"
    
    apt-get update -y > /dev/null 2>&1
    
    echo "Installing Docker engine version..."
    apt-get install -y docker-ce > /dev/null 2>&1 || exit_on_error "Failed installing Docker engine"
}

rhel_install_engine() {
    echo "Prepering to install Docker engine..."
    yum install -y yum-utils > /dev/null 2>&1 || exit_on_error "Failed installing yum-utils"

    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1 || \
        exit_on_error "Failed adding repo"

    yum makecache fast > /dev/null 2>&1 || exit_on_error "Failed adding repo"

    echo "Installing latest Docker engine..."
    yum -y install docker-ce > /dev/null 2>&1 || exit_on_error "Failed installing Docker engine"

    systemctl start docker
    systemctl enable docker
}

suse_install_engine() {
    echo "Starting the Docker service..."
    systemctl start docker
    systemctl enable docker
}

install_engine() {
    if [ "${OS,,}" == "ubuntu" ]; then
        ubuntu_install_engine
    elif [ "${OS,,}" == "red hat" ]; then
        rhel_install_engine
    elif [ "${OS,,}" == "suse" ]; then
        suse_install_engine
    fi
}

#check sudo
if [[ ! $UID -eq 0 ]]; then
    echo "Run as root"
    exit 1
fi;

OS=`cat /etc/os-release | grep PRETTY_NAME | sed -n 's/.*\(SUSE\|Ubuntu\|Red Hat\).*/\1/p'`

#remove old versions
remove_older

#install docker engine
install_engine
echo -e ${BLUE}"Installed Docker engine successfully"${WHITE}

#test installation
echo "Testing Docker engine installation..."
docker run hello-world > /dev/null 2>&1 || exit_on_error "Installation verification failed"
echo -e ${BLUE}"Test passed"${WHITE}

#pull collector image
echo "Pulling Cloud App Security collector image..."
docker login -u caslogcollector -p C0llector3nthusiast > /dev/null 2>&1 || exit_on_error "Login to hub failed"
docker pull microsoft/caslogcollector 2>/dev/null || exit_on_error "Failed pulling latest collector image"
echo -e ${BLUE}"Installation completed successfully! You are now ready to set up a log collector in the Cloud App Security portal."${WHITE}