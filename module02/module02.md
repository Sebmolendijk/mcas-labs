# Cloud App Security Discovery lab

[:arrow_left: Home](/README.md)

Continuous reports in Cloud Discovery analyze all logs that are forwarded from your network using Cloud App Security. They provide improved visibility over all data, and automatically identify anomalous use using either the Machine Learning anomaly detection engine or by using custom policies that you define.
To use this capability, you will perform in this lab the configuration and troubleshooting of the Cloud Discovery feature.

## Configure and test continuous reports

[:arrow_up: Top](#Cloud-App-Security-Discovery-lab)

> NOTE: The Docker engine has been pre-installed on LinuxVM in your lab environment, using the commands provided in the [deployment guide](https://docs.microsoft.com/en-us/cloud-app-security/discovery-docker-ubuntu).

Those commands download a script installing the Docker engine on your host computer (Ubuntu in this case) and pull the latest Cloud App Security collector image from the Docker library.

``` bash
    curl -o /tmp/MCASInstallDocker.sh https://adaprodconsole.blob.core.windows.net/public-files/MCASInstallDocker.sh && chmod +x /tmp/MCASInstallDocker.sh; /tmp/MCASInstallDocker.sh
```

### Create a data source and a log collector in the Cloud App Security portal

1. Switch to **Client01**.

2. Create a new tab in the InPrivate window and browse to [**https://portal.cloudappsecurity.com**](https://portal.cloudappsecurity.com).

   >INFO: If necessary, log in using the credentials below:
   >
   >**Global Admin Username**
   >
   >**Global Admin Password**

3. In the Cloud App Security dashboard, click on the **Settings** icon and click **Log collectors**.

   ![Settings](/media/dis-settings.png "Settings")

4. On the **Data sources tab**, click the **Add data source...** button.

    ![New data source](/media/dis-newsource.png "New data source")

5. In the Add data source window, use the settings below (do not close the window yet):

    >|||
    >|---------|---------|
    >|Name| **SquiDLogs**|
    >|Source| **SQUID (Common)**|
    >|Receiver type| **FTP**|
    >|Anonymize private information |**Check the box**|
    >
    ![Squid source](/media/dis-squidsource.png)

    >:memo: **NOTE:** In this lab we use FTP as the receiver type but usually companies will use Syslog.

6. While still in the Add data source dialog, click **View sample of expected log file**.

    >:memo: **NOTE:** Using this information, you can verify with your network team that the provided logs match the format expect by Cloud App Security. If it doesn't, you can should a custom parser.

    ![Verify log format](/media/dis-verifylog.png "Verify log format")

7. In the Verify your log format dialog, click **Download sample log** and save to your desktop. Those logs will be used to simulate an appliance sending traffic logs to the log collector.

    ![Download sample](/media/dis-downloadsample.png "Download sample log")

8. Close the *Verify your log format* window, then click **Add** in the **Add** data source dialog.

    ![Add source](/media/dis-addsource.png "Add source")

    >**INFO:** We just created a data source which is the logical representation of the network appliance data source type the log collector will receive.

9. Next, click on the **Log collectors tab** and click the **Add log collector...** button.

    ![Add log collector](/media/dis-addlogcollector.png "Add log collector")

10. In the Create log collector dialog, provide the settings below and click the **Update** button.

    |||
    |-----|-----|
    |Name|**LogCollector**
    |Host IP address|**192.168.141.125**
    |Data source(s)|**SquidLogs**

    ![Create log collector](/media/dis-addlogcollector.png "Create log collector")

11. After clicking on the **Update** button, you have now the required steps to create your log collector instance on **LinuxVM**.
    >:warning: Do not close this window!

    ![Create log collector command](/media/dis-addlogcollectortoken.png "Create log collector command")

    ``` bash
    (echo 1f5b5fb2a0d778e3d57f26ca5ab11574db0751166477940528ccf19a7c4) | docker run --name LogCollector -p 21:21 -p 20000-20099:20000-20099 -e "PUBLICIP='192.168.141.125'" -e "PROXY=" -e "SYSLOG=false" -e "CONSOLE=xyztenant.eu.portal.cloudappsecurity.com" -e "COLLECTOR=LogCollector" --security-opt apparmor:unconfined --cap-add=SYS_ADMIN --restart unless-stopped -a stdin -i microsoft/caslogcollector starter
    ```

    >**INFO:** This command line contains the different parameters to instanciate a new log collector on the Linux host:
    >* An API token to connect to Cloud App Security for uploading the logs: *1f5b5fb2a0d778e3d57f26ca5ab11574db0751166477940528ccf19a7c4*
    >* The docker parameters to configure the log collector container: *docker run ...*

12. Copy the command line provided at the end of the previous step and **minimize** the browser. Open **Putty (64-bit)**. You should have the icon on your desktop.

    ![Putty](/media/dis-putty.png "Putty")

13. In the PuTTY Configuration window, enter **192.168.141.125** and click **Open**.

    ![Putty config](/media/dis-puttyconfig.png "Putty config")

14. At the Putty warning message, click **Yes**.
    >**INFO:** This warning is due to the ssh certificate. You can safely ignore this warning in this lab.

    ![Putty warning](/media/dis-puttywarning.png "Putty warning")

15. Log in using the credentials below.
    >|Username|Password|
    >|---|---|
    >|user01|Passw0rd1|
    >
    >:warning:The password doesn't appear in the command prompt, you can safely press enter to validate the credentials.

    ![Putty prompt](/media/dis-puttylogin.png)

16. Type the command below and press **Enter**. Provide the user password when prompted.
    ``` bash
    sudo -i
    ```
    ![sudo](/media/dis-sudo.png)
    >**INFO**: The previous command elevates your permissions in the Linux environment like the UAC prompt would do on a Windows machine.

17. Return to the *Create log collector* dialog, copy the **collector configuration** command from step 2 and run it in the PuTTY window.

    ![Copy token](/media/dis-addlogcollectorcopy.png "Copy token")
    ![New container](/media/dis-newcontainer.png "New container")
    >**INFO:** The output of this command is the id of the newly created container/log collector.

18. Now, launch **WinSCP** from the start-menu.

    ![WinSCP](/media/dis-winscp.png "WinSCP")

19. Use the details below in the WinSCP window to connect to the log collector FTP service.

    |File Protocol|Host name|User name|Password|
    |-----|-----|-----|-----|
    |FTP|192.168.141.125|discovery|BP98Jw4Ns*zpTFrH|

    ![WinSCP connection](/media/dis-winscpconnection.png "WinSCP connection")

    >**INFO**: this information was provided during the log collector creation.
    >
    >:memo: **NOTE:** the password is common to every new log collector. To change it, follow [this guide](https://docs.microsoft.com/en-us/cloud-app-security/troubleshoot-docker#docker-deployment) in the documentation.

    You should then be able to see a folder with your data source name.

    ![WinSCP connection](/media/dis-winscpfolder.png "WinSCP connection")

    >:warning: If you are **not** able to connect to the log collector FTP service, verify that you successfully created the new log collector instance within Putty in previous steps.

20. On the left pane, move to the **Desktop** folder and drag your demo Squid log into the folder named for your data source (**SquidLogs**). After some minutes, the log collector will upload your logs.

    ![Log upload](/media/dis-winscplogupload.png "Log upload")
    ![Log upload](/media/dis-winscplogupload2.png "Log upload")
    ![Log upload](/media/dis-winscplogupload3.png "Log upload")

21. Return to the Cloud App Security portal and click on **Settings** > **Governance log**.

    ![Settings Governance log](/media/dis-governancelog.png "Settings Governance log")

22. Verify the status of the uploaded logs.

    >**INFO:** The status you see is the parsing status of the logs. Parsing status can be successful, pending or failed.

    ![Log uploaded](/media/dis-loguploaded.png "Log uploaded")

23. You can also verify the **last data received** status on the *Data sources* tab under **Automatic log upload** settings.

    ![Last data received](/media/dis-lastreceived.png "Last data received")

24. Go to the **Cloud Discovery dashboard** to verify the discovered apps.

    ![Discovery dashboard](/media/dis-discoverydashboard.png "Discovery dashboard")

    ![Discovery data](/media/dis-discoverydata.png "Discovery data")

    >:memo: **NOTE:**  After validating that your logs have been successfully uploaded and processed by MCAS, you will not usually see directly the analysis of your data. Why?
    >
    >**ANSWER:** Cloud Discovery logs are only parsed **twice a day**.