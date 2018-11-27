
## TO EDIT - old version

### Users

| User          | Username                      | Password       |
| ----          | --------                      | --------       |
| Administrator |admin@xyztenant.onmicrosoft.com  | xyz |
| Adele Vance   |adelev@xyztenant.onmicrosoft.com | xyz |
| Megan Bowens  |meganb@xyztenant.onmicrosoft.com | xyz |


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

![deg5ncg3.jpg](/media/deg5ncg3.jpg)

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

![ao3du4ms.jpg](/media/ao3du4ms.jpg)

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

![rilw99v2.jpg](/media/rilw99v2.jpg)

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

![6kcy2xki.jpg](/media/6kcy2xki.jpg)

### OneDrive -- Ownership granted to another user

This policy helps you to detect when someone is granted full access to
somebody OneDrive for Business site.

**Activities to monitor:**

  |App               |Activity category                   |Activity
  |----------------- |----------------------------------- |---------------------
  |OneDrive   		 |Add site collection administrator   |SiteCollectionAdminAdded

![rb4fqb83.jpg](/media/rb4fqb83.jpg)

### 3rd party apps delegations

This policy helps you to detect new external apps for which users are
granting access to the select app (Office 365, G Suite, ...).

Detecting those delegations will help in the case of cloud ransomware,
or possible data exfiltration.

**Activities to monitor:**

We will monitor when an uncommon app is granted medium or high
permission level:

![mszki5q9.jpg](/media/mszki5q9.jpg)

### Investigation in MCAS

Now that we have created those policies, we are going to investigate on the alerts.
As your environments auditing might not be configured yet and will take up to **24h** before being enabled, those investigations will be performed in the environment provided by your instructor.
Review the alerts in the environment and investigate to identify the users and the malicious activities performed.

|Portal               |Username                   |Password
|----------------- |----------------------------------- |---------------------
| https://portal.cloudappsecurity.com | viewer@emslab.tech |EventP@ssword