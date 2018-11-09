# Cloud App Security threat detection lab

[:arrow_left: Home](./README.md)

Cloud App Security provides several [threats detection policies](https://docs.microsoft.com/en-us/cloud-app-security/anomaly-detection-policy) using machine learning and **user behavior analytics** to detect suspicious activities across your different applications.
Those policies are enabled by default and after an initial learning period, Cloud App Security will start alerting you when suspicious actions like activity from anonymous IP addresses, infrequent country, suspicious IP addresses, impossible travel, ransomware activity, suspicious inbox forwarding configuration or unusual file download are detected.
In this lab, we will perform some malicious actions that Cloud App Security will detect. As some detections require learning about your users’ behavior, we will focus on the ones you can simulate during this lab.

## Prerequisites

### Tools

To simulate user access from anonymous IPs, we will use TOR browser.
Go to the [TOR project website](https://www.torproject.org/projects/torbrowser.html.en#downloads) to download the Windows version and install it.
You should find the shortcut on your desktop:

![TOR browser icon](media/td-toricon.png "TOR browser")

> **WARNING:**
> This tools is for research purposes only. Microsoft does **not** own this tool
> nor can it guarantee its behavior. This tools should only be run in a test lab environment.

## Environment

### URLs

* Office 365: https://portal.office.com
* Cloud App Security: https://portal.cloudappsecurity.com
* Windows Defender ATP: https://securitycenter.windows.com

<!-- variables regarding the environment-->

[library]: https://xyztenant.sharepoint.com/sites/Demo

### Users

| User          | Username                      | Password       |
| ----          | --------                      | --------       |
| Administrator |admin@xyztenant.onmicrosoft.com  | ParisPassword1 |
| Adele Vance   |adelev@xyztenant.onmicrosoft.com | ParisPassword1 |
| Megan Bowens  |meganb@xyztenant.onmicrosoft.com | ParisPassword1 |

---

# Anonymous access

This detection identifies that users were active from an IP address that has been identified as an anonymous proxy IP address. These proxies are used by people who want to hide their device’s IP address, and may be used for malicious intent. This detection uses a machine learning algorithm that reduces "false positives", such as mis-tagged IP addresses that are widely used by users in the organization.

## Simulate the malicious activity

1. On your Windows 10 lab VM, open TOR browser:

   ![Connect to TOR](media/td-torlaunch.png "Connect to TOR")

2. Open Office 365 web mail by going to https://outlook.office.com and enter Megan Bowens credentials.

3. Go to [this SharePoint library][library] and download some documents.

## Investigate

As your authentication during the previous steps came from an anonymous IP address, it will be detected as suspicious by Cloud App Security.

1. Go back to the Cloud App Security portal and review the alerts.

   ![MCAS alerts menu](media/td-alerts.png "Security Alerts")

   You will see an alert similar  to this one:

   ![TOR alert](media/td-toralert.png "TOR alert")

2. Click on the alert to open it.
   You see in this page more information on the alert and the related activities:

   ![TOR alert](media/td-toralert-details.png "TOR alert details")

3. Click on the activities to get more information on the specific activity, the user and the IP address:

   ![TOR alert](media/td-toralert-details-user.png "TOR alert user")
   ![TOR alert](media/td-toralert-details-ip.png "TOR alert IP address")

4. You can go further in your investigation by looking at the related actions performed during that session by clicking on the “investigate in activity log" button:

   ![TOR alert](media/td-toralert-details-activities.png "TOR alert activities")

5. You will then be redirected to the activity log where you will be able to investigate on the actions performed during that session, like configuration changes or data exfiltration.

---

# Impossible travel

This detection identifies two user activities (is a single or multiple sessions) originating from geographically distant locations within a time period shorter than the time it would have taken the user to travel from the first location to the second, indicating that a different user is using the same credentials. This detection uses a machine learning algorithm that ignores obvious "false positives" contributing to the impossible travel condition, such as VPNs and locations regularly used by other users in the organization. The detection has an initial learning period of seven days during which it learns a new user’s activity pattern.

## Simulate the malicious activity

1. In your Windows 10 lab VM, open Office 365 web mail by going to https://outlook.office.com and enter Adele Vance credentials. This authentication will come from an Azure IP address, where your client is hosted.

2. On your host PC, go to https://outlook.office.com and authenticate again as Adele Vance.

## Investigate

As the first and the second authentication came from distinct locations, Cloud App Security will detect that those time to travel between those two locations was to short and will then alert you.

1. Go back to the Cloud App Security portal and review the alerts.

   ![MCAS alerts menu](media/td-alerts.png "Security Alerts")

   You will see an alert similar  to this one:

   ![Impossible travel alert](media/td-impossibletravelalert.png "Impossible travel alert")

2. The investigation steps are similar to the anonymous access but by looking at the IP address details and the **ISP**, you will be able to determine the possible risk:

   ![Impossible travel alert](media/td-impossibletravelalert-details.png "Impossible travel alert details")

---

# Activity from infrequent country 

This detection considers past activity locations to determine new and infrequent locations. The anomaly detection engine stores information about previous locations used by users in the organization. An alert is triggered when an activity occurs from a location that wasn't recently or never visited by any user in the organization.

## Investigate

After an initial learning period, Cloud App Security will detect that this location was not used before by your user or other people within the organization and will then alert you.

1. Go back to the Cloud App Security portal and review the alerts.

   ![MCAS alerts menu](media/td-alerts.png "Security Alerts")

   You will see an alert similar  to this one:

   ![Infrequent country alert](media/td-infrequentcountryalert.png "Infrequent country alert")

2. The investigation steps are similar to the anonymous access but by looking at the IP address details and the ISP, you will be able to determine the possible risk. In this specific example, we see it’s coming from a TOR IP, so this authentication is suspicious:

   ![Infrequent country alert](media/td-infrequentcountryalert-details.png "Infrequent country alert details")

---

# Malware detection

This detection identifies malicious files in your cloud storage, whether they're from your Microsoft apps or third-party apps. Microsoft Cloud App Security uses Microsoft's threat intelligence to recognize whether certain files are associated with known malware attacks and are potentially malicious. This built-in policy is disabled by default. Not every file is scanned, but heuristics are used to look for files that are potentially risky. After files are detected, you can then see a list of **Infected files**. Click on the malware file name in the file drawer to open a malware report that provides you with information about that type of malware the file is infected with.

## Simulate the malicious activity

1. In your Windows 10 lab VM, create a new text file __*test-malware.txt*__ with the following content:

   ```
   X5O!P%@AP[4\PZX54(P^)7CC)7}$EICAR-STANDARD-ANTIVIRUS-TEST-FILE!$H+H*
   ```

   > **INFO:** The file we just created is an [EICAR test file](http://www.eicar.org/86-0-Intended-use.html) usually used to test anti-viruses.

2. This file will normally trigger an antivirus alert and quarantine the file. If this is the case, go to the Windows Security Center and restore it:

   ![Security Center](media/td-winsecuritycenter.png "Windows Security Center")

3. Go to https://portal.office.com and enter Adele Vance credentials. Go to OneDrive for Business:

   ![App launcher](media/td-officeapplauncher.png "Office apps launcher")

   ![Office apps](media/td-officeapps.png "Office apps")

4. Upload the __*test-malware.txt*__ file you created in OneDrive:

   ![OneDrive upload](media/td-onedriveupload.png "OneDrive upload")

   ![OneDrive malware](media/td-testmalwarefile.png "OneDrive malware")

5. After a few minutes, the file will be detected as a malware and an alert will be triggered in Cloud App Security:

   ![Malware detected](media/td-malwaredetected.png "Malware detected")

## Investigate

1. Go back to the Cloud App Security portal and review the alerts.

   ![MCAS alerts menu](media/td-alerts.png "Security Alerts")

   You will see an alert similar  to this one:

   ![Malware detected alert](media/td-malwarealert.png "Malware detected alert")

2. Click on the alert to open it. You see in this page more information on the alert and the related activities:

   ![Malware detected alert](media/td-malwarealert-details.png "Malware detected alert")

3. In the alert, you have more information on the file and its location, but also the malware that we identified:

   ![Malware family](media/td-malwarefamily.png "Malware family")

4. Click on the malware type link to have access to the Microsoft Threat Intelligence report regarding this file:

   ![Malware family](media/td-malwarefamilymti.png "Malware family")

5. Back in the alert, you can scroll down to the related activities. There, you will have more information on how the file was uploaded to OneDrive and possibly who downloaded it:

   ![Malware family](media/td-malwarealert-activities.png "Malware family")

---

# Email exfiltration using suspicious inbox forwarding

This detection looks for suspicious email forwarding rules, for example, if a user created an inbox rule that forwards a copy of all emails to an external address.

## Simulate the malicious activity

1. On your Windows 10 lab VM, open TOR browser.

2. Open Office 365 web mail by going to https://outlook.office.com and enter Megan Bowens credentials.

3. Click on the “People” icon:

   ![Exchange menu](media/td-exomenu.png "Exchange menu")

4. Create a new contact and save it:

   |First name |  Last Name | Email          | Display as|
   |:----------|:-----------|:---------------|:----------|
   | .         | .          | badguy@xyz.com | .         |
   ![Create contact](media/td-createcontact.png "Create contact")

5. Now go to the __*Mail*__ settings:

   ![Exchange settings](media/td-exosettings.png "Exchange settings")

6. Go to __*Inbox and sweep rules*__ and create a new forwarding rule:

   ![Inbox rules](media/td-inboxrules.png "Inbox rules")

7. Create this rule and select the contact you created before as the recipient:

   | Apply to all messages | Select the contact you created | Click **OK** to save          |
   |:----------|:-----------|:---------------|
   | ![Inbox rules](media/td-newinboxrules01.png "Inbox rules") | ![Inbox rules](media/td-newinboxrules02.png "Inbox rules") | ![Inbox rules](media/td-newinboxrules03.png "Inbox rules") |

## Investigate

As the rules redirects your user’s emails to a suspicious external address, Cloud App Security will detect this rule creation and will then alert you.

1. Go back to the Cloud App Security portal and review the alerts.

   ![MCAS alerts menu](media/td-alerts.png "Security Alerts")

   You will see an alert similar  to this one:

   ![Suspicious forwarding alert](media/td-suspiciousforwardingalert.png "Suspicious forwarding alert")

2. Click on the alert to open it. You see in this page more information on the alert, like the **destination address** and the related activities:

   ![Suspicious forwarding alert](media/td-suspiciousforwardingalert-details.png "Suspicious forwarding alert")

3. With this information, you can now go back to the user to remove this rule but also investigate in Exchange trace logs which emails were sent to that destination address.

---

# Ransomware activity

Cloud App Security extended its ransomware detection capabilities with anomaly detection to ensure a more comprehensive coverage against sophisticated Ransomware attacks. Using our security research expertise to identify behavioral patterns that reflect ransomware activity, Cloud App Security ensures holistic and robust protection. If Cloud App Security identifies, for example, a high rate of file uploads or file deletion activities it may represent an adverse encryption process. This data is collected in the logs received from connected APIs and is then combined with learned behavioral patterns and threat intelligence, for example, known ransomware extensions. For more information about how Cloud App Security detects ransomware, see Protecting your organization against ransomware.

> **NOTE:** For security reasons, we will note detail in this lab how to simulate ransomware attacks

## Investigate

As the rules redirects your user’s emails to a suspicious external address, Cloud App Security will detect this rule creation and will then alert you.

1. Go back to the Cloud App Security portal and review the alerts.

   ![MCAS alerts menu](media/td-alerts.png "Security Alerts")

   You will see an alert similar  to this one:

   ![Ransomware alert](media/td-ransomwarealert.png "Ransomware alert")

2. Click on the alert to open it. You see in this page more information on the impacted user, the number of encrypted files, the location of the files and the related activities:

   ![Ransomware alert](media/td-ransomwarealert-details.png "Ransomware alert")

3. Now that we’ve seen the alert, let’s go back to the policies:

   ![Policies](media/td-policies.png "Policies")

4. Search for the “Ransomware activity” policy and open it:

   ![Ransomware policy](media/td-policiesransomware.png "Ransomware policies")

5. At the bottom of the policy, review the possible alerts and governance actions:

   ![Ransomware policy](media/td-policiesransomware-governance.png "Ransomware policies")

---

# Suspicious application consent

Many third-party productivity apps that might be installed by business users in your organization request permission to access user information and data and sign in on behalf of the user in other cloud apps, such as Office 365, G Suite and Salesforce. 
When users install these apps, they often click accept without closely reviewing the details in the prompt, including granting permissions to the app. This problem is compounded by the fact that IT may not have enough insight to weigh the security risk of an application against the productivity benefit that it provides.
Because accepting third-party app permissions is a potential security risk to your organization, monitoring the app permissions your users grant gives you the necessary visibility and control to protect your users and your applications. The Microsoft Cloud App Security app permissions enable you to see which user-installed applications have access to Office 365 data, G Suite data and Salesforce data, what permissions the apps have, and which users granted these apps access to their Office 365, G Suite and Salesforce accounts. 

Here is an example of such user consent:

![App consent](media/td-appconsent.png "App consent")

## Investigate

1. Without even creating policies, Cloud App Security shows you the applications that received permissions from your users:

   ![App permissions](media/td-apppermissions.png "App permissions")

2. From this page, you can easily see who granted permissions to those apps, if they are commonly used or their permissions level:

   ![App commodity](media/td-appcommodity.png "App commodity")

3. If you detect that an application should not be granted access to your environment, you can revoke the app access.
   > **IMPORTANT:** This operation will apply to the **entire** organization:

   ![App revoke](media/td-apprevoke.png "App revoke")

4. When investigating, you can search for apps rarely used in Office 365 which were granted high privileges and create a **policy** to be automatically alerted when such action is performed:

   ![App filter](media/td-appfilter.png "App filter")

5. After clicking on the “New policy from search” button, you can see that your filter will be used to create a new policy:

   ![App policy](media/td-apppolicy.png "App policy")

6. Go down on that page and review the possible alerts and governance automatic actions that you can configure:

   ![App policy](media/td-apppolicy-governance.png "App policy")

7. To go further in your investigation, let’s now pivot to the “Activity log”:

   ![Activity log](media/td-activitylog.png "Activity log")

8. In the activity log, search for "**Consent to application**" activities:

   ![Activity log](media/td-activitylog-consent01.png "Activity log")

9. You will then be able to investigate on who, when and from where your users granted access to applications:

   ![Activity log](media/td-activitylog-consent02.png "Activity log")

---

# Create your own policies

Now that we reviewed some of the default detection capabilities of Cloud App Security, you should start creating your [own policies](https://docs.microsoft.com/en-us/cloud-app-security/control-cloud-apps-with-policies).
Cloud App Security provides by default many [policies templates](https://docs.microsoft.com/en-us/cloud-app-security/policy-template-reference) to start creating your custom policies.

1. To create your policies, go to “Policies”:

   ![Policies](media/td-policies.png "Policies")

2. Click on “Create policy” and select the type of policy you want to create:

   ![Policies types](media/td-policiestypes.png "Policies types")

3. In the policy screen, choose the policy template you want to use:

   ![Policies templates](media/td-policiestemplates.png "Policies templates")

4. Apply the template:

   ![Apply template](media/td-applytemplate.png "Apply template")

5. Cloud App Security will then populate the different properties of the policy:

   ![Policy template filter](media/td-policytemplatefilter.png "Policy template filter")

6. Review those properties and customize them if needed.

7. Explore other types of policies and review the proposed templates.

> ## To go further in your Cloud App Security journey, join our [tech community]
> (https://techcommunity.microsoft.com/t5/Microsoft-Cloud-App-Security/bd-p/MicrosoftCloudAppSecurity) !

---

# TO EDIT - old version

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
---
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

![deg5ncg3.jpg](media/deg5ncg3.jpg)

### Exchange Online - add user to Exchange administrator role

This policy monitors when a user is added to an Exchange management role
group.

Although this action is usually legit, providing visibility on it is
usually required by security teams.

**Activities to monitor:**
  |App               |Activity category             |Activity
  |----------------- |---- 							|---------------------
  |Exchange Online   |N/A   						|Add-RoleGroupMember

Optionally, you could add as a condition "if IP address category is not
in Corporate".

![ao3du4ms.jpg](media/ao3du4ms.jpg)

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

![rilw99v2.jpg](media/rilw99v2.jpg)

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
  |Exchange Online   |Add mailbox folder permission   	  |Add-MailboxFolderPermission
  |Exchange Online   |Add permission to mailbox       	  |Add-MailboxPermission

![6kcy2xki.jpg](media/6kcy2xki.jpg)

### OneDrive -- Ownership granted to another user

This policy helps you to detect when someone is granted full access to
somebody OneDrive for Business site.

**Activities to monitor:**

  |App               |Activity category                   |Activity
  |----------------- |----------------------------------- |---------------------
  |OneDrive   		 |Add site collection administrator   |SiteCollectionAdminAdded

![rb4fqb83.jpg](media/rb4fqb83.jpg)

### 3rd party apps delegations

This policy helps you to detect new external apps for which users are
granting access to the select app (Office 365, G Suite, ...).

Detecting those delegations will help in the case of cloud ransomware,
or possible data exfiltration.

**Activities to monitor:**

We will monitor when an uncommon app is granted medium or high
permission level:

![mszki5q9.jpg](media/mszki5q9.jpg)

### Investigation in MCAS

Now that we have created those policies, we are going to investigate on
the alerts.

As your environments auditing might not be configured yet and will take
up to 24h before being enabled, those investigations will be performed
in the environment provided by your instructor.

Review the alerts in the environment and investigate to identify the
users and the malicious activities performed.
