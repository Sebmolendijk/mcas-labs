# Cloud App Security Discovery lab

[:arrow_left: Home](/README.md)


## Labs

* [Create and review a snapshot reports:](Configure-and-test-continuous-reports) :clock10: 10 min

---

## Create and review a snapshot reports

[:arrow_up: Top](#Cloud-App-Security-Discovery-lab)

Snapshot Reports are the manual method of uploading files into Cloud App Security. You can upload batches of 20 logs of 1 GB max at a time and they will parse into their own separate report. Any discovery policies you create **will not** apply to these types of reports. Creating Snapshot reports is a great and easy way to validate your logs format of have a quick look at the Cloud App Security Discovery capability.

To create snapshot reports:

1. Go to the **Discover** section and click on **Create snapshot report**.

    ![Create snapshot](/media/dis-newsnaphsot.png "Create snapshot")

2. In the Add data source window, use the settings below (do not close the window yet) and click on **View and verify...**:

    >|||
    >|---------|---------|
    >|Report Name| **Demo report**|
    >|Description| |
    >|Data Source| **Barracuda - F-Series Firewall**|
    >|Anonymize private information |**Check the box**|
    >
    ![New snapshot](/media/dis-createsnapshot.png "New snapshot")

3. In the **Verify your log format** window, click on the **Download sample log** button and save it to your desktop.

    ![Download log](/media/dis-downloadlog.png "Download log")

4. Close that window.

5. Click on the **Browse** button and in the new window, select the log you downloaded and click **Open**.

    ![Browse logs](/media/dis-browse.png "Browse logs")

    ![Select logs](/media/dis-downloadlog.png "Select logs")

6. Now that the log has been selected, click on the **Create** button to create your report.

    ![Create snapshot](/media/dis-snapshotcreate.png "Create snapshot")

7. Your report will then be processed.

    ![Report processing](/media/dis-processing.png "Report processing")

8. When your report is ready, you can click on it and start exploring the discovered apps, users, IPs.

    ![Report dashboard](/media/dis-dashboard.png "Report dashboard")

    ![Report dashboard -risk](/media/dis-risk.png "Report dashboard - risk")

---