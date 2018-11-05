# Microsoft 365 Cloud App Security 
[🔙](#introduction) 
 
This lab will guide you through some of the Microsoft Cloud App Security 
(MCAS) capabilities. 
 
We expect you to already have experience with MCAS deployment and 
configuration. In the different sections, you will be asked to fulfill 
some tasks for which you will receive the requirements but not a step by 
step guide to accomplish this task. A lab answer key document can be 
provided to those needing it. 
 
Most treat detections capabilities rely on auditing being enabled in your environment. 
By default, auditing is not enabled in Office 365 and must be turned on using the **Security & Compliance** admin console. In addition, some applications like Exchange Online require extra configuration, like enabling auditing per mailbox ([https://docs.microsoft.com/en-us/office365/securitycompliance/enable-mailbox-auditing?redirectSourcePath=%252fen-us%252farticle%252fenable-mailbox-auditing-in-office-365-aaca8987-5b62-458b-9882-c28476a66918](https://docs.microsoft.com/en-us/office365/securitycompliance/enable-mailbox-auditing?redirectSourcePath=%252fen-us%252farticle%252fenable-mailbox-auditing-in-office-365-aaca8987-5b62-458b-9882-c28476a66918)). 
 
As this operation can take up to 24h, your instructor will provide you access to another environment to review the alerts. 
 
^IMAGE[Security & Compliance Center](urzgmx9v.jpg) 
 
^IMAGE[Enable Auditing](uku8txme.jpg) 
 
The main sections covered in this Lab are: 
 
- [Cloud Discovery](#cloud-discovery) 
- [Threat Detection](#threat-detection) 
- [Conditional Access App Control](#conditional-access-app-control) 
- [Management](#management) 
- [Information Protection](#information-protection) 
=== 
# Connect MCAS to Office 365  
[🔙](#microsoft-365-cloud-app-security) 
 
1. [] On @lab.VirtualMachine(Client01).SelectLink, open a new tab and go to +++https://portal.cloudappsecurity.com+++ 
1. [] Go to the gear icon and select **App connectors**  
 
!IMAGE[GetImage.png](GetImage.png) 
  
1. [] Click on the **+** button and select Office 365  
  
!IMAGE[45gka6qw.jpg](45gka6qw.jpg) 
1. [] Click on **Connect Office 365** 
  
!IMAGE[x58w8p6v.jpg](x58w8p6v.jpg) 
1. [] Click on **Test now** to validate the configuration  
  
!IMAGE[a4c31yrk.jpg](a4c31yrk.jpg) 
  
=== 
# Cloud Discovery 
[🔙](#microsoft-365-cloud-app-security) 
 
### Estimated time to complete 
30 min 
 
Continuous reports in Cloud Discovery analyze all logs that are 
forwarded from your network using Cloud App Security. They provide 
improved visibility over all data, and automatically identify anomalous 
use using either the Machine Learning anomaly detection engine or by 
using custom policies that you define. 
To use this capability, you will perform in this lab the configuration 
and troubleshooting of the Cloud Discovery feature. 
 
> [!NOTE] The Docker engine has been pre-installed on LinuxVM using the commands at [https://docs.microsoft.com/en-us/cloud-app-security/discovery-docker-ubuntu](https://docs.microsoft.com/en-us/cloud-app-security/discovery-docker-ubuntu) 
=== 
## Configure and test continuous reports 
[🔙](#microsoft-365-cloud-app-security) 
 
1. [] Switch to @lab.VirtualMachine(Client01).SelectLink. 
 
1. [] Create a new tab in the InPrivate window and browse to +++https://portal.cloudappsecurity.com+++. 
 
> [!KNOWLEDGE] If necessary, log in using the credentials below: 
> 
>+++@lab.CloudCredential(134).Username+++ 
> 
>+++@lab.CloudCredential(134).Password+++ 
 
1. [] In the Cloud App Security dashboard, click on the **Settings** icon and click **Log collectors**. 
 
!IMAGE[t9beih5z.jpg](t9beih5z.jpg) 
1. [] On the **Data sources tab**, click the **Add data source...** button. 
 
!IMAGE[f1k3bw4e.jpg](f1k3bw4e.jpg) 
1. [] In the Add data source window, use the settings below: 
 
>||| 
>|---------|---------| 
>|Name| +++Logs+++| 
    >|Source| **SQUID (Common)**| 
>|Receiver type| **FTP**| 
>|Anonymize private information |**Check the box**| 
> 
>!IMAGE[zby8rfbk.jpg](zby8rfbk.jpg) 
 
1. [] While still in the Add data source dialog, click **View sample of expected log file**. 
 
!IMAGE[2ksenw0c.jpg](2ksenw0c.jpg) 
1. [] In the Verify your log format dialog, click **Download sample log** and save to your desktop. 
 
!IMAGE[qdkjwbbr.jpg](qdkjwbbr.jpg) 
1. [] Minimize the browser and extract the sample log to your desktop. 
1. [] Return to the browser and close the Verify your log format window, then click **Add** in the Add data source dialog. 
 
!IMAGE[380ig1wx.jpg](380ig1wx.jpg) 
1. [] Next, click on the **Log collectors tab** and click the **Add log collector...** button. 
 
!IMAGE[vq2ll67m.jpg](vq2ll67m.jpg) 
1. [] In the Create log collector dialog, provide the settings below and click the **Update** button. 
 
||| 
|-----|-----| 
|Name|+++LogCollector+++ 
|Host IP address|+++192.168.141.125+++ 
|Data source(s)|**Logs** 
 
!IMAGE[aw3yista.jpg](aw3yista.jpg) 
!IMAGE[v829uq5m.jpg](v829uq5m.jpg) 
 
> [!ALERT] Do not dismiss this window! 
1. [] **Minimize** the browser and double-click **Putty (64-bit)** on the desktop. 
 
1. [] In the PuTTY Configuration window, enter +++192.168.141.125+++ and click **Open**. 
 
!IMAGE[b0gca8dw.jpg](b0gca8dw.jpg) 
1. [] Log in using the credentials below. 
 
+++user01+++ 
 
+++Passw0rd1+++ 
 
1. [] Type the command below and press **Enter**. 
 
``` 
sudo -i 
``` 
1. [] Next, return to the Create log collector dialog and copy the **collector configuration** comannd from step 2 and run it in the PuTTY window. 
 
!IMAGE[1j76v7e0.jpg](1j76v7e0.jpg) 
1. [] Next, launch **WinSCP** from the start-menu. 
 
!IMAGE[i5bmeqmb.jpg](i5bmeqmb.jpg) 
1. [] Enter the details below in the WinSCP window: 
||| 
|-----|-----| 
|File Protocol|**FTP**| 
|Host name|+++192.168.141.125+++| 
|User name|+++discovery+++| 
|Password|+++BP98Jw4Ns*zpTFrH+++| 
 
1. [] Switch to the **Desktop** folder on the left side and double-click on the folder named for your data source (**Logs**). 
 
!IMAGE[31q5d1ul.jpg](31q5d1ul.jpg) 
1. [] Select the squid-common demo log and click **Upload**. 
 
!IMAGE[4hpamv4b.jpg](4hpamv4b.jpg) 
1. [] In the Upload dialog, click **OK**. 
 
!IMAGE[xeaix0r8.jpg](xeaix0r8.jpg) 
 
1. [] After uploading your logs, return to the MCAS protal and click on **Settings** > **Governance log**.  
 
!IMAGE[fruhkk70.jpg](fruhkk70.jpg) 
 
1. [] You may also verify the **last data received** status on the Data sources tab under **Automatic log upload**. 
 
!IMAGE[l347jas1.jpg](l347jas1.jpg) 
 
> [!NOTE]  After validating that your logs have been successfully uploaded and 
    processed by MCAS, you will not see directly the analysis of your 
    data. Why? (hint: verify the "Set up Cloud Discovery" documentation 
    page). 
 
=== 
## How to troubleshoot the Docker log collector 
[🔙](#microsoft-365-cloud-app-security) 
 
In this task, you will review possible troubleshooting steps to identify 
issues in automatic logs upload from the log collector. 
 
There are several things to test at different locations: in the log 
collector, in MCAS, at the network level. 
 
### Useful commands 
 
- To navigate in the directories, use the "cd" command. 
Examples:  
 
**cd /var/adallom** to go to the specified directory 
 
**cd /** to go to the root directory 
 
**cd ..** to go to the parent directory 
 
- To display the content of the logs, use the **more file_name** command 
- To display the content of the directory, use the **ll** command 
- To clear the screen, use the **clear** command 
 
- For saving typing, use the **Tab** key and perform autocompletion. 
 
### Verify the log collector (container) status 
 
1. [] On @lab.VirtualMachine(Client01).SelectLink, open a session on PuTTY to +++192.168.141.125+++ and use the credentials below. 
 
+++user01+++ 
 
+++Passw0rd1+++ 
 
1. [] Run the following commands: 
 
``` 
sudo -i 
``` 
``` 
docker stats 
``` 
This command will show you the status of the log collector instance: 
 
!IMAGE[CONTAINER ID 2d7cadgfS4a1 13.14\* CPU 1.22\* MEM USAGE / LIMIT 187 
.1MiB / 1.39GiB NET I/o 10.gMB / 3 .23MB](vl5158cy.jpg) 
1. [] Press **Ctrl-C** to end the command.  
1. [] Next, run the command below: 
 
``` 
docker logs --details LogCollector 
``` 
 
This command will show you the logs from the log collector to verify if 
it encountered errors when initiating: 
 
 
 
!IMAGE[rootaubuntu-srt: \'hame,\'seb 5 \--dzt.ei15 Setting ftp configuration 
Enter again: Setting syslog Reading configuration.. . Installing 
collector successfully! zenzitive Starting 2018-06-28 2018-06-28 
2018-06-28 2010-06-28 2018-06-28 08 2018-06-28 2018-06-28 seo 2018-06-28 
53B 2018-06-28 €67 2018-06-28 2018-06-28 667 08:28: is, CRIT WARN I NEO 
CR IT I NEO 1 NEO INFO I NEO INSO I NEO INFO I NEO INFO as uzez in file) 
during parsing RBC interface \' supervisor • initialized http without 
HTTP checking Started With pid 1059 spawned: spawned : success : • with 
1062 •rsyslog• with pid 1063 with pid 2064 • Columbus\' with 1065 
rsyslog RUNNING stace, ftpd entered RUNNING state, pza RUNNING scat\* , 
Stayed up for](4bfomeag.jpg) 
 
  
 
#### To go further in the troubleshooting, you can connect to the log collector container to investigates the different logs. 
 
1. [] Type the following command: 
 
``` 
docker exec -it LogCollector bash 
``` 
 
1. [] You can then explore the container filesystem and inspect the 
**/var/adallom** directory. This directory is where you will investigate 
issues with the syslog or ftp logs being sent to the collector 
 
!IMAGE[ovjlyn26.jpg](ovjlyn26.jpg) 
 
-   **/adallom/ftp/discovery**: this folder contains the data source 
    folders where you send the log files for automated upload. This is 
    also the default folder when logging into the collector with FTP 
    credentials. 
 
-   **/adallom/syslog/discovery**: if you setup the log collector to 
    receive syslog messages, this is where the flat file of aggregated 
    messages will reside until it is uploaded. 
 
-   **/adallom/discoverylogsbackup**: this folder contains the last file 
    that was sent to MCAS. This is useful for looking at the raw log in 
    case there are parsing issues. 
 
1. [] To validate that logs are correctly received from the network appliance, 
you can also verify the **/var/log/pure-ftpd** directory and check the 
transfer log: 
 
!IMAGE[erx39v7i.jpg](erx39v7i.jpg) 
 
1. [] Now, move to the **/var/log/adallom** directory. 
 
!IMAGE[0h029uih.jpg](0h029uih.jpg) 
 
-   **/var/log/adallom/columbus**: this folder is where you will find 
    log files useful for troubleshooting issues with the collector 
    sending files. In the log-archive folder you can copy previous logs 
    compressed as .tar.gz files off the collector to send to support. 
 
-   **/var/log/adallom/columbusInstaller**: this is where you will 
    investigate issues with the collector itself. You will find here 
    logs related to the configuration and bootstrapping of the 
    collector. For example, trace.log will show you the bootstrapping 
    process: 
 
    !IMAGE[ks4ttuuq.jpg](ks4ttuuq.jpg) 
 
  
 
 
### Verify the connectivity between the log collector and MCAS 
 
An easy way to test this is to download a sample of your appliance logs 
from MCAS and use WinSCP to connect to the log collector to upload that 
log and see if it gets uploaded to MCAS. 
 
  
 
1. [] Upload the logs in the folder named by your source: 
 
!IMAGE[bqhxmpns.jpg](bqhxmpns.jpg) 
 
  
 
1. [] Then, check in MCAS the status: 
 
!IMAGE[21pseval.jpg](21pseval.jpg) 
 
  
 
!IMAGE[mt0o095m.jpg](mt0o095m.jpg) 
 
  
 
> [!NOTE] If the log stays in the source folder, then you know you probably have a 
connection issue between the log collector and MCAS. 
 
Another way to validate the connection is to log into the container like 
in the previous task and then run *netstat -a* to check if we see 
connections to MCAS: 
 
1. [] In the PuTTY window, type the command below: 
 
``` 
netstat -a 
``` 
!IMAGE[rxvauw6e.jpg](rxvauw6e.jpg) 
=== 
# Threat Detection 
[🔙](#microsoft-365-cloud-app-security) 
 
### Estimated time to complete 
20 min 
 
Cloud App Security provides several [threats detection 
policies](https://docs.microsoft.com/en-us/cloud-app-security/anomaly-detection-policy) 
using machine learning and **user behavior analytics** to detect 
suspicious activities across your different applications. After an 
initial learning period, Cloud App Security will start alerting you when 
suspicious actions like activity from anonymous IP addresses, infrequent 
country, suspicious IP addresses, impossible travel, ransomware 
activity, suspicious inbox forwarding configuration or unusual file 
download are detected. 
 
In addition to those policies, you can create your own policies, like 
the ones on the next page, that you must create for this lab. 
=== 
## Policies 
[🔙](#microsoft-365-cloud-app-security) 
 
### Exchange Online -- monitor mail forwarding configuration 
 
This policy allows you to monitor admin and users mail forwarding 
configuration. This policy is covering extra scenarios than the built-in 
one. 
 
**Activities to monitor:** 
 
  |App               |Activity category              |Activity 
  |----------------- |------------------------------ |--------------- 
  |Exchange Online   |Create forwarding inbox rule   |New-InboxRule 
  |Exchange Online   |Edit mailbox forwarding        |Set-Mailbox 
  |Exchange Online   |Edit forwarding inbox rule     |Set-InboxRule 
 
As creating this kind of rules is part of the daily operations in a 
company, we could recommend scoping the monitoring to **sensitive 
groups** of users to monitor but this is not required for this lab. 
 
!IMAGE[deg5ncg3.jpg](deg5ncg3.jpg) 
 
### Exchange Online - add user to Exchange administrator role 
 
This policy monitors when a user is added to an Exchange management role 
group. 
 
Although this action is usually legit, providing visibility on it is 
usually required by security teams. 
 
**Activities to monitor:** 
  |App               |Activity category             |Activity 
  |----------------- |---- |--------------------- 
  |Exchange Online   |N/A   |Add-RoleGroupMember 
 
Optionally, you could add as a condition "if IP address category is not 
in Corporate". 
 
!IMAGE[ao3du4ms.jpg](ao3du4ms.jpg) 
 
### Exchange Online - Add management role assignment 
 
This rule monitors possible management role assignments to a management 
group. 
 
For example, when someone is adding impersonation capabilities to a 
group used to migrate mailboxes to Office 365. 
 
Details about Exchange permissions and roles can be found [at this 
address](https://docs.microsoft.com/en-us/exchange/permissions-exo/permissions-exo). 
 
**Activities to monitor:** 
  |App               |Activity category                   |Activity 
  |----------------- |----------------------------------- |--------------------- 
  |Exchange Online   |Add impersonation role assignment   |New-ManagementRoleAssignment 
 
!IMAGE[rilw99v2.jpg](rilw99v2.jpg) 
 
### Exchange Online - New delegated access to sensitive mailbox 
 
This policy monitors when a delegate is added to sensitive mailboxes, 
like your CEO or HR team mailboxes or sensitive shared mailboxes. 
 
We monitor two kinds of delegation: at the mailbox level, when an admin 
performs the action, and at the client level, when delegation for 
folders are added. 
 
**Note**: Exchange logs can take some time before being available, 
leading to some delay before the detection. 
 
**Activities to monitor:** 
 
We recommend scoping this policy to specific users only, to avoid too 
many alerts, but this is not required for this lab. 
 
  |App               |Activity category                   |Activity 
  |----------------- |----------------------------------- |--------------------- 
  |Exchange Online   |Add mailbox folder permission     |Add-MailboxFolderPermission 
  |Exchange Online   |Add permission to mailbox         |Add-MailboxPermission 
 
!IMAGE[6kcy2xki.jpg](6kcy2xki.jpg) 
 
### OneDrive -- Ownership granted to another user 
 
This policy helps you to detect when someone is granted full access to 
somebody OneDrive for Business site. 
 
**Activities to monitor:** 
 
  |App               |Activity category                   |Activity 
  |----------------- |----------------------------------- |--------------------- 
  |OneDrive   |Add site collection administrator   |SiteCollectionAdminAdded 
 
!IMAGE[rb4fqb83.jpg](rb4fqb83.jpg) 
 
### 3rd party apps delegations 
 
This policy helps you to detect new external apps for which users are 
granting access to the select app (Office 365, G Suite, ...). 
 
Detecting those delegations will help in the case of cloud ransomware, 
or possible data exfiltration. 
 
**Activities to monitor:** 
 
We will monitor when an uncommon app is granted medium or high 
permission level: 
 
!IMAGE[mszki5q9.jpg](mszki5q9.jpg) 
 
### Investigation in MCAS 
 
Now that we have created those policies, we are going to investigate on 
the alerts. 
 
As your environments auditing might not be configured yet and will take 
up to 24h before being enabled, those investigations will be performed 
in the environment provided by your instructor. 
 
Review the alerts in the environment and investigate to identify the 
users and the malicious activities performed. 
 
=== 
# Conditional Access App Control 
[🔙](#microsoft-365-cloud-app-security) 
 
### Estimated time to complete 
40 min 
 
Please go through all the steps exactly as described to avoid 
complications. 
 
### Configure Salesforce 
 
1. []  Create a Salesforce developer account 
 
    1. []  On @lab.VirtualMachine(Client01).SelectLink, launch a browser and go to the URL below.  
 
+++https://developer.salesforce.com/signup+++ 
 
    2. []  **Important:** Use your admin user as the Email 
        and Username 
 
        +++@lab.CloudCredential(134).Username+++ 
 
    3. []  Fill in the rest of details, click Sign me up, accept the 
        verification email, and choose a new password. 
 
2. []  Configure Salesforce in Azure AD 
 
    1. []  In Salesforce, go to **Setup**, search for **My Domain** and 
        register a new domain, e.g., ems123456-dev-ed.salesforce.com 
 
        !IMAGE[f7idpipy.jpg](f7idpipy.jpg) 
 
    5. []  Save **full Salesforce domain name**, including **https://** for the 
        next step, e.g., <https://ems123456-dev-ed.salesforce.com> 
 
    6. []  Go to +++https://portal.azure.com+++ logging in with the credentials below: 
 
+++@lab.CloudCredential(134).Username+++ 
 
+++@lab.CloudCredential(134).Password+++ 
 
7. []  Go to **Azure Active 
        Directory**, click on **Enterprise applications**, choose **+ 
        New application**, select All, choose **Salesforce**, call it 
        **SalesforceCAS**, and click on **Add** 
 
    7. []  Go back to **Enterprise applications**, choose **All 
        applications**, and click on **SalesforceCAS**, click on 
        **Single sign-on**, and choose **SAML-based Sign-on** under 
        **Single Sign-on Mode** 
 
    8. []  For both **Sign on URL** and **Identifier** set the full 
        Salesforce domain name, e.g., 
        <https://ems123456-dev-ed.salesforce.com> 
 
    9. []  Under SAML Signing Certificate, make sure that there is a 
        certificate present and that the **STATUS** is **Active** 
 
        1. [] If there is no certificate, click on the **Create new 
            certificate** link 
 
        1. [] If the **STATUS** is **New**, select the **Make new 
            certificate active** checkbox. When you click on **Save**, 
            you will get a **Rollover certificate** confirmation. Once 
            certificate rollover is approved, the certificate STATUS 
            will become **Active**. 
 
    10. [] Click on **Save** 
 
    11. [] Click on **Configure Salesforce** which will open a new blade 
 
    12. [] Scroll down to the **Quick Reference** section 
 
        1. [] **Download the Azure AD Signing Certificate** 
 
        1. []  Copy all the other fields in the Quick Reference section for 
            the next step in Salesforce 
 
    13. [] Go back to Salesforce, under **Setup** go to **Single Sign-On 
        Settings** 
        !IMAGE[ao0yrpx8.jpg](ao0yrpx8.jpg) 
 
    14. [] Click on **Edit**, Select **SAML Enabled**, and click on 
        **Save** 
 
    15. [] In the same **Single Sign-On Settings** page, click on **New** 
 
    16. [] Fill in the following fields: 
 
        1. [] **Name**: write "Azure AD" 
 
        1. [] **Issuer**: Copy and paste the **Azure AD SAML Entity ID** 
            from the Azure AD **Quick Reference** section 
 
        1. [] **Entity ID**: The full Salesforce domain, e.g., 
            <https://ems123456-dev-ed.salesforce.com> 
 
        1. [] **Identity Provider Certificate**: upload the certificate 
            you've downloaded from Azure AD (**Download Azure AD Signing 
            Certificate**) 
 
        1. []  **Identity Provider Login URL**: Copy and paste the **Azure 
            AD Single Sign-On Service URL** from the Azure AD **Quick 
            Reference** section 
 
        1. [] **Custom Logout URL**: Copy and paste the **Azure AD Sign 
            Out URL** from the Azure AD **Quick Reference** section 
 
    17. [] Click **Save** 
 
    18. [] Go back to **My Domain** in Salesforce 
 
    19. [] Under **Authentication Configuration** click Edit, (click 
        **Open** if needed), and: 
 
        1. [] Uncheck the **Login Page** checkbox 
 
        1. [] Check the **Azure AD** checkbox 
 
        1. [] Click on **Save** 
 
    20. [] Go back to the Azure AD portal, within the **SalesforceCAS** 
        app, choose **Users and groups** 
         
!IMAGE[kscnoob4.jpg](kscnoob4.jpg) 
 
    21. [] Click on **+ Add user**, choose the admin as the user (e.g., 
        <admin@ems123456.onmicrosoft.com>), choose **System 
        Administrator** as the Role, and click on **Assign** 
 
    22. [] Test the setup by going to <https://myapps.microsoft.com>, 
        logging in with the credentials below: 
 
+++@lab.CloudCredential(134).Username+++ 
 
+++@lab.CloudCredential(134).Password+++ 
 
Click on the 
        **SalesforceCAS**, verifying that this will result in a 
        successful login to Salesforce. 
 
3. []  Deploy the proxy for Salesforce 
 
    1. [] In Azure Active Directory, under **Security**, click 
        on **Conditional access**. 
        !IMAGE[b62lha77.jpg](b62lha77.jpg) 
 
    24. [] Click on **New policy** and create a new policy: 
 
        1. [] Name the policy: Test Cloud App Security proxy 
 
        1. [] Choose the admin as the user (e.g., 
            <admin@ems123456.onmicrosoft.com>) 
 
        1. [] Choose SalesforceCAS as the app 
 
        1. []  Under **Session** you select **Use proxy enforced 
            restrictions**. 
 
        1. [] Set **Enable policy** to be **On** 
 
        1. [] Click on **Create** 
 
        1. [] It should look like this: 
            !IMAGE[qti7w9u6.jpg](qti7w9u6.jpg) 
 
    25. [] After the policy was created successfully, open a new browser, 
        ***make sure you are logged out***, and log in to 
        SalesforceCAS with the admin user 
 
        1. You can go to +++https://myapps.microsoft.com+++ and click on 
            the SalesforceCAS tile 
 
        1.  Make sure you've successfully logged on to Salesforce 
 
    26. [] Go to the Cloud App Security portal, and under the settings cog 
        choose **Conditional Access App Control 
        !IMAGE[dfmwyegm.jpg](dfmwyegm.jpg) 
 
    27. [] You should see a message letting you know that new Azure AD apps 
        were discovered. Click on the **View new apps** link. 
        !IMAGE[qz9mx11x.jpg](qz9mx11x.jpg) 
 
        1. If the message does not appear, go back to step c. (After 
            the policy was created...) this time, close the browser and 
            open a new browser in Incognito mode. 
 
    28. [] In the dialog that opens, you should see Salesforce. Click on 
        the + sign, and then click **Add**. 
        !IMAGE[iy3f8gro.jpg](iy3f8gro.jpg) 
 
### Configure device authentication 
 
1. []  Go to the settings cog and choose **Device identification**. 
 
2. []  Upload the CASTestCA.crt certificate from the Client Certificate 
     folder within the **E:\Demofiles.zip** file you've received as the 
     certificate authority root certificate 
 
!IMAGE[rlkp1xvp.jpg](rlkp1xvp.jpg) 
### Create a session policy 
 
1. []  In the Cloud App Security portal, select **Control** followed 
     by **Policies**. 
 
2. []  In the **Policies** page, click **Create policy** and 
     select **Session policy**. 
     !IMAGE[6lh61nkl.jpg](6lh61nkl.jpg) 
 
3. []  In the **Session policy** window, assign a name for your policy, 
     such as *Block download of sensitive documents to unmanaged 
     devices.* 
     !IMAGE[a6i9js1x.jpg](a6i9js1x.jpg) 
 
4. []  In the **Session control type** field Select **Control file download 
     (with DLP)**  
 !IMAGE[j9pxy1lm.jpg](j9pxy1lm.jpg) 
 
5. []  Under **Activity source** in the **Activities matching all of the 
     following** section, select the following activity filters to 
     apply to the policy: 
 
    1. [] **Device tags** does not equal **Valid client certificate** 
 
    1. [] **App** equals **Salesforce** 
    !IMAGE[6wwuqlcz.jpg](6wwuqlcz.jpg) 
 
6. []  Check the **Enabled** checkbox near **Content inspection** 
 
7. []  Check the **Include files that match a preset expression** radio 
     button 
 
8. []  In the dropdown menu just below the radio button, scroll all the way 
     to the end to choose **US: PII: Social security number** 
 
9. []  Check the **Don't require relevant context** checkbox, just below 
     the dropdown 
     menu 
 !IMAGE[10uz9qp1.jpg](10uz9qp1.jpg) 
 
10. [] Under **Actions**, select **Block** 
 
11. [] Check the **Customize block message** checkbox, and add a custom 
     message in the textbox that has opened, e.g.: "This file is 
     sensitive" 
    !IMAGE[dzdsku3w.jpg](dzdsku3w.jpg) 
 
12. [] Click on **Create** 
 
13. [] Create a second **Session policy** called *Protect download to 
     unmanaged devices.* 
 
14. [] In the **Session control type** field Select **Control file download 
     (with DLP)**  
 
 !IMAGE[xsznq6n8.jpg](xsznq6n8.jpg) 
 
15. [] Under **Activity source** in the **Activities matching all of the 
     following** section, select the following activity filters to 
     apply to the policy: 
 
 	**Device tags** does not equal **Valid client certificate** 
 
 	**App** equals **Salesforce** 
 
 	!IMAGE[8s4bu84k.jpg](8s4bu84k.jpg) 
 
16. [] Clear the **Enabled** checkbox near **Content inspection** 
 
17. [] Under **Actions**, select **Protect** 
 
    !IMAGE[c5xhnr87.jpg](c5xhnr87.jpg) 
 
18. [] Click on **Create** 
 
19. [] Disable this policy 
 
### Test the user experience 
 
1. []  Extract the file **silvia.pfx** from the **Client Certificate** 
     folder in **Demo files.zip** file you've received 
 
2. []  Double click on the **silvia.pfx** file, click **Next**, **Next**, 
     enter the password **acme**, click **Next**, **Next**, **Finish**. 
 
3. []  Open a new browser in an Incognito mode 
 
4. []  Go to <https://myapps.microsoft.com> and login with the admin user 
 
5. []  Click on the **SalesforceCAS** tile 
 
6. []  You should now see a certificate prompt. Click on **Cancel**. 
 
     **In a real demo**, you can open two different browsers, 
     side by side, and show the user experience from a managed and 
     unmanaged device by clicking on **OK** in one browser and 
     **Cancel** in the other. 
 
   !IMAGE[2mj216sm.jpg](2mj216sm.jpg) 
 
7. []  You should then see a Monitored access message, click on **Continue 
     to Salesforce** to continue. 
 
    !IMAGE[h2oyt9fw.jpg](h2oyt9fw.jpg) 
 
8. []  Now you are logged in to Salesforce. Click on + and go to Files 
 
    !IMAGE[d0ik67yl.jpg](d0ik67yl.jpg) 
 
9. [] Upload the files **Personal employees information.docx** and 
     **Protect with Microsoft Cloud App Security proxy.pdf** from the 
     **Demo files.zip** file to the Files page in Salesforce 
 
10. [] Download the **Protect with Microsoft Cloud App Security proxy.pdf** 
     files and see that it is downloaded, and you can open it. 
 
11. [] Download the **Personal employees information.docx** file and see 
     that you get a blocking message and instead of the file, you get a 
     Blocked...txt file. 
 
   !IMAGE[wvk16zl2.jpg](wvk16zl2.jpg) 
 
### Test the admin experience 
 
1. []  Go back to the Cloud App Security portal, and under **Investigate** 
    choose **Activity log** 
 
2. []  See the login activity that was redirected to the session control, 
    the file download that was not blocked, and the file download that 
    was blocked because it matched the policy. 
 
    !IMAGE[j0vuo06k.jpg](j0vuo06k.jpg) 
=== 
# Management 
[🔙](#microsoft-365-cloud-app-security) 
 
### Estimated time to complete 
30 min 
 
### Manage admin access  
 
For this task, you are asked to delegate admin access to other users, 
without adding them to the Global Admin management role. 
 
Documentation: 
[https://docs.microsoft.com/en-us/cloud-app-security/manage-admins](https://docs.microsoft.com/en-us/cloud-app-security/manage-admins) 
 
#### Delegate user group administration 
 
You are asked to delegate the management of MCAS for US employees to a 
new administrator. 
 
By following the explanations in the documentation you have to: 
 
1. []  Create a new administrator account "mcasAdminUS" 
 
2. []  Create a new Azure AD group "US employees" containing a couple of 
    your test users (not your admin account) 
 
3. []  Delegate that group management in MCAS to "mcasAdminUS" 
 
4. []  Connect to MCAS with "mcasAdminUS" and compare the activities, 
    alerts and actions that this admin can perform 
 
#### Delegate MCAS administration to an external admin 
 
As a Managed Security Service Providers (MSSPs), you are asked by your 
customer how you could access their environment to manage their alerts 
in the Cloud App Security portal. 
 
As the MCAS admin for your company, work with the person next to you to 
configure an external access for the Managed Security Service Provider. 
 
### MCAS PowerShell module introduction 
 
To help administrators interact with MCAS in a programmatic way, two 
Microsoft employees created a non-official PowerShell module for Cloud 
App Security. For this lab, you will install this module and discover 
the available cmdlets. 
 
Note: the module relies on the Cloud App Security API. You can find its 
documentation in the MCAS portal. 
 
!IMAGE[f847xhzx.jpg](f847xhzx.jpg) 
 
The module is available in the PowerShell gallery and can be installed 
using the *Install-Module mcas* command. 
 
!IMAGE[6j16dgs2.jpg](6j16dgs2.jpg) 
 
More information on the module is available on GitHub: 
[https://github.com/powershellshock/MCAS-Powershell](https://github.com/powershellshock/MCAS-Powershell) 
 
After installing the module, read how to connect to MCAS in the 
PowerShell help and start exploring the cmdlets. 
 
Hint: you'll have to create an API token in Cloud App Security. 
 
!IMAGE[0x2tzeqd.jpg](0x2tzeqd.jpg) 
 
Using PowerShell: 
 
1. []  Review the list of MCAS administrators and when they were granted 
    those permissions 
 
2. []  Review your security alerts and close them in bulk 
 
3. []  Download a sample SQUID log and send it to MCAS as a snapshot 
    report. 
 
4. []  In the portal, in Discovery, tag some apps as unsanctioned and 
    generate a blocking script for your appliance to block access to 
    those apps. 
 
5. []  You are asked to define corporate IP's in MCAS. Subnets go from 
    10.50.50.0/24 to 10.50.80.0/24 
 
=== 
# Information protection 
[🔙](#microsoft-365-cloud-app-security) 
 
15 min 
 
In a perfect world, all your employees understand the importance of information protection and work within your policies. But in a real world, it's probable that a partner who works with accounting uploads a document to your Box repository with the wrong permissions, and a week later you realize that your enterprise's confidential information was leaked to your competition. 
Microsoft Cloud App Security helps you prevent this kind of disaster before it happens. 
 
In this task, you will protect a sensitive document library in SharePoint Online using the native integration with Azure Information Protection. 
 
## Integrate MCAS with Azure Information Protection 
 
As explained in the [documentation](https://docs.microsoft.com/en-us/cloud-app-security/azip-integration), configure the integration between the two solutions.  
 
1. [] Go to Cloud App Security settings and check the **Automatically scan new files** checkbox. 
 
!IMAGE[imku224m.jpg](imku224m.jpg) 
2. [] Click on the **Save** button. 
 
## Apply AIP classification to SSN documents 
 
3. [] Go to **Policies**. 
 
!IMAGE[i2nnuzsg.jpg](i2nnuzsg.jpg) 
4. [] Create a new **File policy**. 
 
!IMAGE[aoodi6ml.jpg](aoodi6ml.jpg) 
5. [] Provide the following settings to that policy: 
1. Policy name: +++Protect SSN documents in sensitive site+++. 
1. Files matching all of the following: **remove the filters**. 
1. Apply to: **selected folder**. 
 
> [!NOTE] Here, select the **Shared Documents** folder from the default SharePoint site. 
 
!IMAGE[mt3guvwp.jpg](mt3guvwp.jpg) 
 
!IMAGE[piparayd.jpg](piparayd.jpg) 
1. Verify that you have one selected folder and click on **Done**. 
 
!IMAGE[ovruaovh.jpg](ovruaovh.jpg) 
 
!IMAGE[q67v9yh6.jpg](q67v9yh6.jpg) 
1. In inspection method, select **Data Classification Service**. 
 
!IMAGE[7fw3fh7n.jpg](7fw3fh7n.jpg) 
1. Click on sensitive information type, select the **SSN related** ones and click on **Done**. 
 
!IMAGE[2plklsza.jpg](2plklsza.jpg) 
1. Click on the **Unmask** checkbox. 
 
!IMAGE[a89zd1k2.jpg](a89zd1k2.jpg) 
1. In the Governance actions, select **Apply classification label**. 
 
!IMAGE[6wfpj4to.jpg](6wfpj4to.jpg) 
1. Click **Create** to finish the policy creation. 
 
=== 
# Quarantine sensitive PDF for review 
[🔙](#microsoft-365-cloud-app-security) 
 
File policies are a great tool for finding threats to your information protection policies, for instance finding places where users stored sensitive information, credit card numbers and third-party ICAP files in your cloud. With Microsoft Cloud App Security, not only can you detect these unwanted files stored in your cloud that leave you vulnerable, but you can take immediate action to stop them in their tracks and lock down the files that pose a threat. Using Admin quarantine, you can protect your files in the cloud and remediate problems, as well as prevent future leaks from occurring. 
This is what we are going to configure in this lab. 
 
1. [] In Cloud App Security, go to the **Settings**. 
 
!IMAGE[oqfkh5cw.jpg](oqfkh5cw.jpg) 
2. [] In the Information Protection section, go to **Admin quarantine**. 
 
!IMAGE[pvjk90y0.jpg](pvjk90y0.jpg) 
3. [] In the dropdown menu, select your root SharePoint site. 
 
1. [] In user notification, type +++Your content has been quarantined. Please contact your admin.+++ 
1. [] Click on the Save button. 
 
    >[!NOTE] As best practice, you should define a dedicated site with restricted access as the admin quarantine location. 
 
!IMAGE[hl55gqvd.jpg](hl55gqvd.jpg) 
4. [] Next, go to the policies menu and create a new **file policy**. 
 
!IMAGE[3xpu3nw7.jpg](3xpu3nw7.jpg) 
5. [] Provide the following settings to that policy: 
1. Policy name: +++Quarantine sensitive pdf+++ 
1. Files matching all of the following: **Extension equals pdf** 
 
!IMAGE[2cmlwt55.jpg](2cmlwt55.jpg) 
1. In Governance actions, select **Put in admin quarantine** and click on the Create button. 
 
!IMAGE[1wlrz08d.jpg](1wlrz08d.jpg) 
  
## Test our policies 
 
To test our files policies, perform the following tasks: 
 
1. [] On @lab.VirtualMachine(Client01).SelectLink, unzip the content of the **Demo files.zip**. 
7. [] Go to the **Contoso Team Site** documents library. 
8. [] Upload the unzipped files to the site. 
 
 
!IMAGE[xf5ozmrf.jpg](xf5ozmrf.jpg) 
9. [] Cloud App Security will now scan those documents and search for matches to our created policies. The scan can take some minutes before completion. 
10. [] To monitor the evolution, go back to Cloud App Security and open the **Files** page of the investigations. 
 
!IMAGE[wb3gbn9w.jpg](wb3gbn9w.jpg) 
11. [] When a match is discovered, you will see it in this page. 
 
!IMAGE[6g2kg3vq.jpg](6g2kg3vq.jpg) 
12. [] Open the details of the file. You can see there the matched policies and the scan status of the files. 
 
!IMAGE[rqbu6yyq.jpg](rqbu6yyq.jpg) 
13. [] You can also view the related governance actions in the Governance log. 
 
!IMAGE[bg5romej.jpg](bg5romej.jpg) 
 
!IMAGE[fbsrlfsk.jpg](fbsrlfsk.jpg) 
 
14. [] You will also notice that the quarantined files will be replaced by placeholders containing your custom message and be moved to the "Quarantine" location we defined. 
 
 
!IMAGE[as3niznc.jpg](as3niznc.jpg) 
 
!IMAGE[juas1s58.jpg](juas1s58.jpg) 
 
!IMAGE[drm0yj0c.jpg](drm0yj0c.jpg) 
 
=== 