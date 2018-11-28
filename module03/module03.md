# Information protection

[:arrow_left: Home](/README.md)

In a perfect world, all your employees understand the importance of information protection and work within your policies. But in a real world, it's probable that a partner who works with accounting uploads a document to your Box repository with the wrong permissions, and a week later you realize that your enterprise's confidential information was leaked to your competition.
Microsoft Cloud App Security helps you prevent this kind of disaster before it happens.

## Labs

* [Apply AIP classification to SSN documents:](#Apply-AIP-classification-to-SSN-documents) :clock10: 10 min
* [Quarantine sensitive PDF for review:](#Quarantine-sensitive-PDF-for-review) :clock10: 10 min
* [Test our policies:](#Test-our-policies) :clock10: 10 min

---

## Apply AIP classification to SSN documents

In this task, you will protect a specific sensitive document library in SharePoint Online using the native integration with Azure Information Protection.
We will apply an Azure Information Protection template on documents containing social security numbers.

[:arrow_up: Top](#Information-protection)

1. In the Cloud App Security portal, go to **Policies**.

    ![Policies](/media/info-policies.png "Policies")

2. Create a new **File policy**.

    ![New policy](/media/info-newpolicy.png "New policy")

3. Provide the following settings to that policy:

    >|||
    >|---------|---------|
    >|Policy Name| **Protect SSN documents in sensitive site**|
    >|Files matching all of the following| **remove the filters** |
    >|Apply to| **selected folder**|
    >:memo: Here, select the **Shared Documents** folder from the default SharePoint site.

    ![Policy filter](/media/info-filter.png "Policy filter")

    ![Select folder](/media/info-folder.png "Select folder")

4. Verify that you have one selected folder and click on **Done**.

    ![Done](/media/info-done.png "Done")

    ![Folder](/media/info-folder.png "Folder")

5. In inspection method, select **Data Classification Service**.

    >:memo: [Microsoft Data Classification Service](https://docs.microsoft.com/en-us/cloud-app-security/dcs-inspection) provides a **unified** information protection experience across Office 365, Azure Information Protection, and Microsoft Cloud App Security.
    >The classification service allows you to extend your data classification efforts to the third-party cloud apps protected by Cloud App Security, using the decisions you already made across an even greater number of apps.

    ![DCS](/media/info-dcs.png "DCS")

6. Click on sensitive information type, search and select the **SSN related** ones and click on **Done**.

    ![SSN type](/media/info-ssn.png "SSN type")

7. Click on the **Unmask** checkbox.

    ![Unmask](/media/info-unmask.png "Unmask")

8. In the Governance actions, click on **Microsoft SharePoint Online** and select **Apply classification label**.

    ![Template](/media/info-template.png "Template")

    >:warning: If you are not able to select Azure Information Protection templates, verify that you configured the integration in the prerequisites section or that you waited the 1h for the classifications to sync.

9. Click **Create** to finish the policy creation.

---

## Quarantine sensitive PDF for review

[:arrow_up: Top](#Information-protection)

File policies are a great tool for finding threats to your information protection policies, for instance finding places where users stored sensitive information, credit card numbers and third-party ICAP files in your cloud. With Cloud App Security, not only can you detect these unwanted files stored in your cloud that leave you vulnerable, but you can take im/mediate action to stop them in their tracks and lock down the files that pose a threat. Using Admin quarantine, you can protect your files in the cloud and re/mediate problems, as well as prevent future leaks from occurring.
This is what we are going to configure in this lab.

1. In Cloud App Security, go to the **Settings**.

    ![Settings](/media/info-settings.png)

2. In the Information Protection section, go to **Admin quarantine**.

    ![Settings admin quarantine](/media/info-adminq1.png "Settings admin quarantine")

3. Configure **Admin quarantine**.

    * In the dropdown menu, select your root SharePoint site.

    ![Settings admin quarantine site](/media/info-adminq2.png "Settings admin quarantine site")

    >:memo: As best practice, you should create and use a **dedicated** site with restricted access as the admin quarantine location.

    * In user notification, type **Your content has been quarantined. Please contact your admin.** and click on the **Save** button.

    ![Settings admin quarantine message](/media/info-adminq3.png "Settings admin quarantine message")

    >:memo: This message will be provided in the placeholders when a file is put in quarantine.

4. Next, go to the policies menu and create a new **file policy**. The policy is the component that will decide which files should be put in quarantine.

    ![Policies](/media/info-policy1.png "Policies")

    ![New policy](/media/info-policy2.png "New policy")

5. Provide the following settings to that policy:

    >|Policy name|Files matching all of the following|
    >|---------|---------|
    >|Quarantine sensitive pdf| Extension equals pdf|

    ![New policy](/media/info-policy3.png "New policy")

6. Check the **Create an alert for each matching file** checkbox. In Governance actions of the policy, select **Put in admin quarantine** for OneDrive and SharePoint and click on the **Create** button.

    ![New policy](/media/info-policy4.png "New policy")

---

## Test our policies

[:arrow_up: Top](#Information-protection)

To test our files policies, perform the following tasks:

1. On Client01, unzip the content of the **Demo files.zip**.

2. Go to the **Contoso Team Site** documents library. You can use the **Search** to find the address to this site.

    ![Team site](/media/info-test1.png "Team site")

    ![Team site](/media/info-test2.png "Team site")

    ![Team site](/media/info-test3.png "Team site")

    ![Team site](/media/info-test4.png "Team site")

3. Upload the unzipped files to the site.

    ![Upload](/media/info-test5.png "Upload")

    ![Upload](/media/info-test6.png "Upload")

    ![Upload](/media/info-test7.png "Upload")

4. Cloud App Security will now scan those documents and search for matches to our created policies.

    >:memo: The scan can take **several minutes** before completion.

5. To monitor the evolution of the scan, go back to Cloud App Security and open the **Files** page of the investigations.

    ![Search files](/media/info-files1.png "Search files")

6. You can search for the files you uploaded using different criteria, like **file name**, **type**, ... or just look at all the files discovered by Cloud App Security.

    ![Search files](/media/info-files2.png "Search files")

    >:memo: The search page do not refresh automatically.

7. When a policy match is discovered, you will see it in this page.

    >:memo: Next to the file name, you have icons showing that an AIP label was applied and that we have a policy match.

    ![Policy match](/media/info-files3.png "Policy match")

8. To open the details of the file, click on its name. You can see there the matched policies and the scan status of the files.

    ![Policy match](/media/info-files4.png "Policy match")

    ![Scan status](/media/info-files5.png "Scan status")

9. You can also view the related governance actions, like applying the Azure Information classification or moving the file to the quarantine folder, at the file level or in the **Governance log**.

    ![File governance](/media/info-files6.png "File governance")

    ![Governance log](/media/info-governance.png "Governance log")

    ![Governance action](/media/info-files7.png "Governance action")

10. If you go back to the **Contoso Team Site**, you will also notice that the quarantined files will be replaced by placeholders containing your custom message. The original file will be moved to the "Quarantine" location we defined in the settings.

    ![Site](/media/as3niznc.jpg "Site")

    ![Placeholder](/media/juas1s58.jpg "Placeholder")

    ![Quarantine](/media/drm0yj0c.jpg "Quarantine")