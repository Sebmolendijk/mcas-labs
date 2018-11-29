# Manage admin access

[:arrow_left: Home](/README.md)

[Manage admin access:](#Manage-admin-access) :clock10: 15 min

For this task, you are asked to delegate admin access to monitor a dedicated group of users for a specific region, without adding them to the Global Admin management role.

> :memo: Cloud App Security Global admin role is not the same as the regular Office 365 Global admin role.
> Although the Office 365 Global admins are automatically granted the Cloud App Security Global admin role, you can grant users MCAS Global Admin role without adding them to the Office 365 Global admins

Documentation:
[https://docs.microsoft.com/en-us/cloud-app-security/manage-admins](https://docs.microsoft.com/en-us/cloud-app-security/manage-admins)

## Delegate user group administration

In this lab, we are going to delegate the management of US employees to a new administrator. This administrator will only see those users alerts and activities.

1. In the [Azure Active Directory portal](https://portal.azure.com), create a new user account named **mcasAdminUS**. Do not grant him any specific admin role.
   ![New user](/media/mgmt-newuser1.png "New user")

   ![New user](/media/mgmt-newuser2.png "New user")

2. Create a new Azure AD group **US employees** containing a couple of your test users (**not** your admin account).
   ![New group](/media/mgmt-newgroup1.png "New group")

   ![New group](/media/mgmt-newgroup2.png "New group")

3. In the [Cloud App Security portal](https://portal.cloudappsecurity.com), import the **US employees** group.
    > :warning: Cloud App Security has to synchronize the Azure AD groups before importing them. This operation can take up to 1h.

    ![Import group](/media/mgmt-import1.png "Import group")

    ![Import group](/media/mgmt-import2.png "Import group")

    ![Import group](/media/mgmt-import3.png "Import group")

    ![Import group](/media/mgmt-import4.png "Import group")

4. In the [Cloud App Security portal](https://portal.cloudappsecurity.com), add **mcasAdminUS** as **User group admin** for the **US employees** group.

    ![New admin](/media/mgmt-admin1.png "New admin")

    ![New admin](/media/mgmt-admin2.png "New admin")

    ![New admin](/media/mgmt-admin3.png "New admin")

    ![New admin](/media/mgmt-admin4.png "New admin")

    ![New admin](/media/mgmt-admin5.png "New admin")

5. Open a new **private** tab and connect to the [Cloud App Security portal](https://portal.cloudappsecurity.com) with **mcasAdminUS** and compare the activities, alerts and actions that this scoped admin can perform compared to your regular Global admin account.

---

## Delegate MCAS administration to an external admin

As a **Managed Security Service Providers** (MSSPs), you are asked by your customer how you could access their environment to manage their alerts in the Cloud App Security portal.
In this lab, we will see how to answer to that question.
As the MCAS admin for your company, work with the person next to you to configure an external access for the Managed Security Service Provider to another MCAS tenant.

1. In the [Cloud App Security portal](https://portal.cloudappsecurity.com), add the external MCAS admin as **Security reader** in your MCAS tenant.

    ![External admin](/media/mgmt-admin1.png "External admin")

    ![External admin](/media/mgmt-admin2.png "External admin")

    ![External admin](/media/mgmt-admin3.png "External admin")

    ![External admin](/media/mgmt-admin4.png "External admin")

    ![External admin](/media/mgmt-externaladmin1.png "External admin")

    > :memo: Note here that the icon next to the newly added admin shows that the user is external to the company.

    ![External admin](/media/mgmt-externaladmin2.png "External admin")

2. After adding the external admin, **log off** and log on again from Cloud App Security.

    ![Log off](/media/mgmt-switch1.png "Log off")

3. Switch to the external Cloud App Security tenant where you have been added as an external admin and look at the actions you can perform.

    ![Switch](/media/mgmt-switch2.png "Switch")