# Environment preparation

[:arrow_left: Home](./README.md)

To be able to complete the different parts of the Cloud App Security labs, the following configuration steps are required.

* [Enabling Office 365 auditing](#Enabling-Office-365-auditing)
* [Connect Office 365 to Cloud App Security](#Connect-Office-365-to-Cloud-App-Security)
* [Enabling Azure Information Protection integration](#Enabling-Azure-Information-Protection-integration)

---

## Enabling Office 365 auditing

[:arrow_up: Top](#Environment-preparation)

Most Cloud App Security treat detections capabilities rely on auditing being enabled in your environment. By default, auditing is not enabled in Office 365 and must then be turned on using the **Security & Compliance** admin console or PowerShell.

1. On Client01, go to the [Office 365 admin portal](https://admin.office.com "Office 365 admin portal")
    ![Admin portal](/media/conf-adminportal.png "Admin portal")

2. Go down on this page and open the **Security & Compliance Center**
    ![Admin portals](/media/conf-scc.png "Admin portals")

3. In the **Security & Compliance Center**, go to the **Audit log search** menu.
    [Audit log](/media/conf-auditlog.png "Audit log")

4. You can see here that auditing is not enabled. Click on the **Turn on auditing** button to enable it and click **yes** at the prompt.
    [Turn on auditing](/media/conf-auditlog.png "Turn on on auditing")
    [Auditing enabled](/media/conf-auditenabled.png "Auditing enabled")

    >:warning: As this operation can take up to 24h, your instructor will provide you access to another environment to review the alerts for the threat detection lab.

:warning: In addition to enabling auditing in Office 365, some applications like Exchange Online require extra configuration. After enabling auditing at the Office 365 level, we have to enable auditing at the mailbox level. We will perform this configuration before going to the labs.

1. On Client01, open PowerShell.
    [Open PowerShell](/media/conf-powershell.png "Open PowerShell")

2. Enter the following commands to connect to Exchange Online using PowerShell. When prompted for credentials, enter your Office 365 administrative credentials.
    ``` PowerShell
        $UserCredential = Get-Credential
        $Session = New-PSSession –ConfigurationName Microsoft.Exchange –ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential –Authentication Basic -AllowRedirection
        Import-PSSession $Session
    ```

    ![Exchange PowerShell](/media/conf-psonline.png "Exchange PowerShell")

3. Enter the following commands to enable auditing for your mailboxes. The second command let you verify that auditing is correctly enabled.
    ```PowerShell
        Get-Mailbox -ResultSize Unlimited -Filter {RecipientTypeDetails -eq "UserMailbox"} | Set-Mailbox -AuditEnabled $true
        Get-Mailbox admin | fl audit*
    ```
    >:warning: When you create new mailboxes, auditing is not enabled by default. You will have to use the same commands again to enable auditing for those newly created mailboxes.

    ![Mailbox auditing](/media/conf-mbxauditing.png "Mailbox Auditing")

>:memo: **Reference:** [Enabling auditing for Exchange Online mailboxes](https://docs.microsoft.com/en-us/office365/securitycompliance/enable-mailbox-auditing?redirectSourcePath=%252fen-us%252farticle%252fenable-mailbox-auditing-in-office-365-aaca8987-5b62-458b-9882-c28476a66918)).

---

## Connect Office 365 to Cloud App Security

[:arrow_up: Top](#Environment-preparation)

To connect Cloud App Security to Office 365, you will have to use the Office 365 app connector. App connectors use the APIs of app providers to enable greater visibility and control by Microsoft Cloud App Security over the apps you connect to.

1. On Client01, open a new tab and go to the [Cloud App Security portal](https://portal.cloudappsecurity.com "Cloud App Security portal")

2. Go to the gear icon and select **App connectors**.

    ![App connector](/media/conf-appconnector.png "App connector")

3. Click on the **+** button and select Office 365.

    ![Add Office](/media/conf-addoffice.png "Add Office")

4. Click on **Connect Office 365**. Cloud App Security will then have access to Office 365 activities and files.

    ![Connect Office"](/media/conf-connectoffice.png "Connect Office")

5. Click on **Test now** to validate the configuration.

    ![Test connectivity](/media/conf-testoffice.png "Test connectivity")

---

## Enabling Azure Information Protection integration

[:arrow_up: Top](#Environment-preparation)

To prepare the **Information Protection** lab, we have to enable the integration between Cloud App Security and Azure Information Protection as explained in the [Cloud App Security documentation](https://docs.microsoft.com/en-us/cloud-app-security/azip-integration). Enabling the integration between the two solutions is as easy as selecting one single checkbox.

1. Go to Cloud App Security settings.
    ![Settings](/media/conf-settings.png "Settings")

2. Go down in the settings to the **Azure Information Protection** section and check the **Automatically scan new files** checkbox and click on the "**Save** button.
    ![Enable AIP](/media/conf-aip.png "Enable AIP")

>:memo: It takes up to **1h** for Cloud App Security to sync the Azure Information classifications.