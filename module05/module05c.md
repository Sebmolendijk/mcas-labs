# Cloud App Security Discovery lab

[:arrow_left: Home](/README.md)

## Labs

* [How to troubleshoot the Docker log collector:](#How-to-troubleshoot-the-Docker-log-collector) :clock10: 15 min

---

## How to troubleshoot the Docker log collector

[:arrow_up: Top](#Cloud-App-Security-Discovery-lab)

In this task, you will review possible troubleshooting steps to identify issues in automatic logs upload from the log collector.
There are several things to test at different locations: in the log collector, in MCAS, at the network level.

### Useful commands

* `cd` : *Used to navigate in the directories*
    >**Examples:**
    >
    >`cd /var/adallom` : *to go to the specified directory*
    >
    >`cd /` : *to go to the root directory*
    >
    >`cd ..` : *to go to the parent directory*

* `more` or `cat` : *Used to display the content of the logs*
    > **Examples:**
    >
    >`more trace.log` : *to display the content of the trace.log file*

* `tail` : *Used for outputting the last part of files*

* `ll` : *Used to display the content of the directory as a list*. This command is an alias for `ls -l`

* `clear` : *Used to clear the screen*

* `tab key` : Used to perform autocompletion

### Verify the log collector (container) status

1. On **Client01**, open a session on PuTTY to **192.168.141.125** and use the credentials below.
    In the PuTTY Configuration window, enter **192.168.141.125** and click **Open**.

    ![Putty config](/media/dis-puttyconfig.png "Putty config")

    Log in using the credentials below.
    >|Username|Password|
    >|---|---|
    >|user01|Passw0rd1|
    >
    >:warning:The password doesn't appear in the command prompt, you can safely press enter to validate the credentials.

2. Run the following commands:

    ``` bash
    sudo -i
    docker stats
    ```
    ![Docker stats](/media/dis-dockerstats.png "Docker stats")

     >**INFO:** This command will show you the status of the log collector instance.

3. Press `Ctrl-C` to end the command.

4. Next, run the command below:

    ``` bash
    docker logs --details LogCollector
    ```
    ![Docker log](/media/dis-dockerlog.png "Docker log")

     >**INFO:** This command will show you the container logs to verify if it encountered errors when initiating.

### Verify the log collector logs

1. Type the following command:

    ``` bash
    docker exec -it LogCollector bash
    ```
     >**INFO:** This command will execute the container's bash. You will then be able to execute commands *from inside* of the log collector.

2. You can now explore the container filesystem and inspect the **/var/adallom** directory. This directory is where you will investigate most of the issues with the syslog or ftp logs being sent to the log collector.

    ``` bash
    cd /var/adallom
    ll
    ```

    ![adallom folder](/media/dis-dockerll.png "adallom folder")

    Go to the following folders and review their log files using `more`:
    * **/adallom/ftp/discovery**: this folder contains the data source folders where you send the log files for automated upload. This is also the default folder when logging into the collector with FTP credentials.
    * **/adallom/syslog/discovery**: if you setup the log collector to receive syslog messages, this is where the flat file of aggregated messages will reside until it is uploaded.
    * **/adallom/discoverylogsbackup**: this folder contains the last file that was sent to MCAS. This is useful for looking at the raw log in case there are parsing issues.

3. To validate that logs are correctly received from the network appliance, you can also verify the **/var/log/pure-ftpd** directory and check the transfer log:

    ``` bash
    tail transfer.log
    ```

    ![FTP logs](/media/dis-pureftp.png "FTP logs")

4. Now, move to the **/var/log/adallom** directory.

    ![var log](/media/dis-varlog.png "var log")

    Go to the following folders and review their content and log files using `ll` and `more` or `tail`:
    * **/var/log/adallom/columbus**: this folder is where you will find log files useful for troubleshooting issues with the collector sending files to Cloud App Security. In the **log-archive** folder you can find previous logs compressed as *.tar.gz* files that could be used to send to support for example.
    * **/var/log/adallom/columbusInstaller**: this is where you will investigate issues with the log collector itself. You will find here logs related to the configuration and bootstrapping of the collector. For example, **trace.log** will show you the bootstrapping process:

    ![Bootstrapping log](/media/dis-bootstrapping.png "bootstrapping log")

### Verify the connectivity between the log collector and Cloud App Security

An easy way to test the connectivity after configuring the log collector is to download a sample of your appliance logs from and use WinSCP to connect to the log collector to upload it and see if it gets uploaded to Cloud App Security, as you did in the previous exercise

![Pending log](/media/dis-pending.png "Log pending")

>:memo: **NOTE:**  If the log stays in the source folder for too long, then you know you probably have a connection issue between the log collector and Cloud App Security and should go investigate the logs reviewed previously.