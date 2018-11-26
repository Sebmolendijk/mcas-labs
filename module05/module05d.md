# Conditional Access App Control

[:arrow_left: Home](/README.md)

## Introduction

Conditional Access App Control utilizes a reverse proxy architecture and is uniquely integrated with Azure AD conditional access. Azure AD conditional access allows you to enforce access controls on your organization’s apps based on certain conditions. The conditions define who (for example a user, or group of users) and what (which cloud apps) and where (which locations and networks) a conditional access policy is applied to. After you’ve determined the conditions, you can route users to the Microsoft Cloud App Security where you can protect data with Conditional Access App Control by applying access and session controls.

Conditional Access App Control enables user app access and sessions to be monitored and controlled in real time based on access and session policies. Access and session policies are utilized within the Cloud App Security portal to further refine filters and set actions to be taken on a user.

With the access and session policies, you can:

* **Block on download**: You can block the download of sensitive documents. For example, on unmanaged devices.
* **Protect on download**: Instead of blocking the download of sensitive documents, you can require documents to be protected via encryption on download. This ensures that the document is protected, and user access is authenticated, if the data is downloaded to an untrusted device.
* **Monitor low-trust user sessions**: Risky users are monitored when they sign into apps and their actions are logged from within the session. You can investigate and analyze user behavior to understand where, and under what conditions, session policies should be applied in the future.
* **Block access**: You can completely block access to specific apps for users coming from unmanaged devices or from non-corporate networks.
* **Create read-only mode**: By monitoring and blocking custom in-app activities you can create a read-only mode to specific apps for specific users.
* **Restrict user sessions from non-corporate networks**: Users accessing a protected app from a location that is not part of your corporate network, are allowed restricted access and the download of sensitive materials is blocked or protected.

>:memo: In this lab, we will cover only some scenarios.

---

## Federate Salesforce with Azure AD

>:warning: As Conditional Access App Control requires the protected app to be federated with your IdP (Azure AD in our case), we will first federate Saleforce with our tenant before moving to the controls configuration. Please go through all the steps exactly as described to avoid any complications further in the lab.

1. Create a Salesforce developer account.

    * On Client01, launch a browser and create a Salesforce developer org at this address: [https://developer.salesforce.com/signup](https://developer.salesforce.com/signup).
      This org (or tenant) will allow you to create a test environment to federate with our Azure AD tenant.

      >:memo: Dev Salesforce orgs are available for free but are deleted after extended periods of inactivity.
      >
      > :warning: Use your lab tenant admin user as the Email and Username

      ![Dev sign-up](/media/appc-signup.png "Salesforce sign-up")

    * Fill in the rest of details, click Sign me up, accept the verification email, and choose a new password.

2. Configure Salesforce in Azure AD for single sign-on.

    * In Salesforce, go to **Setup**, search for **My Domain** and register a new domain matching your Office 365 domain, e.g., **ems123456-dev-ed.salesforce.com**

        ![My domain](/media/sf-mydomain.png "My domain")

        ![My domain](/media/sf-registerdomain.png "My domain")

        ![My domain](/media/sf-registerdomain2.png "My domain")

    * Save **full Salesforce domain name**, including **https://** for the next step, e.g., **https://ems123456-dev-ed.salesforce.com**
        ![My domain](/media/sf-registerdomain3.png "My domain")

    * Go to **https://portal.azure.com** with the credentials below:

        **Global Admin Username**
        **Global Admin Password**
	
	1.   Go to **Azure Active
        Directory**, click on **Enterprise applications**, choose **+
        New application**, select All, choose **Salesforce**, call it
        **SalesforceCAS**, and click on **Add**

    1.   Go back to **Enterprise applications**, choose **All
        applications**, and click on **SalesforceCAS**, click on
        **Single sign-on**, and choose **SAML-based Sign-on** under
        **Single Sign-on Mode**

    1.   For both **Sign on URL** and **Identifier** set the full
        Salesforce domain name, e.g.,
        <https://ems123456-dev-ed.salesforce.com>

    1.   Under SAML Signing Certificate, make sure that there is a
        certificate present and that the **STATUS** is **Active**

        1. If there is no certificate, click on the **Create new
            certificate** link

        1. If the **STATUS** is **New**, select the **Make new
            certificate active** checkbox. When you click on **Save**,
            you will get a **Rollover certificate** confirmation. Once
            certificate rollover is approved, the certificate STATUS
            will become **Active**.

    1.   Click on **Save**

    1.  Click on **Configure Salesforce** which will open a new blade

    1.   Scroll down to the **Quick Reference** section

        1. **Download the Azure AD Signing Certificate**

        1.  Copy all the other fields in the Quick Reference section for
            the next step in Salesforce

    1.   Go back to Salesforce, under **Setup** go to **Single Sign-On
        Settings**
        ![ao0yrpx8.jpg](/media/ao0yrpx8.jpg)

    1.   Click on **Edit**, Select **SAML Enabled**, and click on
        **Save**

    1.   In the same **Single Sign-On Settings** page, click on **New**

    1.  Fill in the following fields:

        1. **Name**: write "Azure AD"

        1. **Issuer**: Copy and paste the **Azure AD SAML Entity ID**
            from the Azure AD **Quick Reference** section

        1. **Entity ID**: The full Salesforce domain, e.g.,
            <https://ems123456-dev-ed.salesforce.com>

        1. **Identity Provider Certificate**: upload the certificate
            you've downloaded from Azure AD (**Download Azure AD Signing
            Certificate**)

        1.  **Identity Provider Login URL**: Copy and paste the **Azure
            AD Single Sign-On Service URL** from the Azure AD **Quick
            Reference** section

        1. **Custom Logout URL**: Copy and paste the **Azure AD Sign
            Out URL** from the Azure AD **Quick Reference** section

    1.  Click **Save**

    1.  Go back to **My Domain** in Salesforce

    1.  Under **Authentication Configuration** click Edit, (click
        **Open** if needed), and:

        1. Uncheck the **Login Page** checkbox

        1. Check the **Azure AD** checkbox

        1. Click on **Save**

    1.  Go back to the Azure AD portal, within the **SalesforceCAS**
        app, choose **Users and groups**
        
		![kscnoob4.jpg](/media/kscnoob4.jpg)

    1.  Click on **+ Add user**, choose the admin as the user (e.g.,
        <admin@ems123456.onmicrosoft.com>), choose **System
        Administrator** as the Role, and click on **Assign**

    1.   Test the setup by going to <https://myapps.microsoft.com>,
        logging in with the credentials below:

		**Global Admin Username**

		**Global Admin Password**
	
		Click on the
        **SalesforceCAS**, verifying that this will result in a
        successful login to Salesforce.

1.   Deploy the proxy for Salesforce

    1. In Azure Active Directory, under **Security**, click
        on **Conditional access**.
        ![b62lha77.jpg](/media/b62lha77.jpg)

    1.   Click on **New policy** and create a new policy:

        1. Name the policy: Test Cloud App Security proxy

        1. Choose the admin as the user (e.g.,
            <admin@ems123456.onmicrosoft.com>)

        1. Choose SalesforceCAS as the app

        1.  Under **Session** you select **Use proxy enforced
            restrictions**.

        1. Set **Enable policy** to be **On**

        1. Click on **Create**

        1. It should look like this:
            ![qti7w9u6.jpg](/media/qti7w9u6.jpg)

    1.   After the policy was created successfully, open a new browser,
        ***make sure you are logged out***, and log in to
        SalesforceCAS with the admin user

        1. You can go to **https://myapps.microsoft.com** and click on
            the SalesforceCAS tile

        1.  Make sure you've successfully logged on to Salesforce

    1.   Go to the Cloud App Security portal, and under the settings cog
        choose **Conditional Access App Control
        ![dfmwyegm.jpg](/media/dfmwyegm.jpg)

    1.   You should see a message letting you know that new Azure AD apps
        were discovered. Click on the **View new apps** link.
        ![qz9mx11x.jpg](/media/qz9mx11x.jpg)

        1. If the message does not appear, go back to step c. (After
            the policy was created...) this time, close the browser and
            open a new browser in Incognito mode.

    1.   In the dialog that opens, you should see Salesforce. Click on
        the + sign, and then click **Add**.
        ![iy3f8gro.jpg](/media/iy3f8gro.jpg)

### Configure device authentication

1.  Go to the settings cog and choose **Device identification**.

2.   Upload the CASTestCA.crt certificate from the Client Certificate folder within the **E:\Demofiles.zip** file you've received as the certificate authority root certificate

	![rlkp1xvp.jpg](/media/rlkp1xvp.jpg)

---

### Create a session policy

1.  In the Cloud App Security portal, select **Control** followed
     by **Policies**.

2.   In the **Policies** page, click **Create policy** and
     select **Session policy**.

     ![6lh61nkl.jpg](/media/6lh61nkl.jpg)

3.   In the **Session policy** window, assign a name for your policy,
     such as *Block download of sensitive documents to unmanaged
     devices.*
     ![a6i9js1x.jpg](/media/a6i9js1x.jpg)

4.   In the **Session control type** field Select **Control file download
     (with DLP)** 
	 ![j9pxy1lm.jpg](/media/j9pxy1lm.jpg)

5.   Under **Activity source** in the **Activities matching all of the
     following** section, select the following activity filters to
     apply to the policy:

    1. **Device tags** does not equal **Valid client certificate**

    2. **App** equals **Salesforce**
    ![6wwuqlcz.jpg](/media/6wwuqlcz.jpg)

6.   Check the **Enabled** checkbox near **Content inspection**

7.   Check the **Include files that match a preset expression** radio
     button

8.   In the dropdown menu just below the radio button, scroll all the way
     to the end to choose **US: PII: Social security number**

9.   Check the **Don't require relevant context** checkbox, just below
     the dropdown
     menu
	 ![10uz9qp1.jpg](/media/10uz9qp1.jpg)

10.  Under **Actions**, select **Block**

11. Check the **Customize block message** checkbox, and add a custom
     message in the textbox that has opened, e.g.: "This file is
     sensitive"
    ![dzdsku3w.jpg](/media/dzdsku3w.jpg)

12.  Click on **Create**

13.  Create a second **Session policy** called *Protect download to
     unmanaged devices.*

14.  In the **Session control type** field Select **Control file download
     (with DLP)** 

	 ![xsznq6n8.jpg](/media/xsznq6n8.jpg)

15.  Under **Activity source** in the **Activities matching all of the
     following** section, select the following activity filters to
     apply to the policy:

 	**Device tags** does not equal **Valid client certificate**

 	**App** equals **Salesforce**

 	![8s4bu84k.jpg](/media/8s4bu84k.jpg)

16.  Clear the **Enabled** checkbox near **Content inspection**

17.  Under **Actions**, select **Protect**

    ![c5xhnr87.jpg](/media/c5xhnr87.jpg)

18.  Click on **Create**

19.  Disable this policy

 ---

### Test the user experience

1.  Extract the file **silvia.pfx** from the **Client Certificate**
     folder in **Demo files.zip** file you've received

2.   Double click on the **silvia.pfx** file, click **Next**, **Next**,
     enter the password **acme**, click **Next**, **Next**, **Finish**.

3.   Open a new browser in an Incognito mode

4.   Go to <https://myapps.microsoft.com> and login with the admin user

5.   Click on the **SalesforceCAS** tile

6.   You should now see a certificate prompt. Click on **Cancel**.

     **In a real demo**, you can open two different browsers,
     side by side, and show the user experience from a managed and
     unmanaged device by clicking on **OK** in one browser and
     **Cancel** in the other.

   ![2mj216sm.jpg](/media/2mj216sm.jpg)

7.   You should then see a Monitored access message, click on **Continue
     to Salesforce** to continue.

    ![h2oyt9fw.jpg](/media/h2oyt9fw.jpg)

8.   Now you are logged in to Salesforce. Click on + and go to Files

    ![d0ik67yl.jpg](/media/d0ik67yl.jpg)

9.  Upload the files **Personal employees information.docx** and
     **Protect with Microsoft Cloud App Security proxy.pdf** from the
     **Demo files.zip** file to the Files page in Salesforce

10.  Download the **Protect with Microsoft Cloud App Security proxy.pdf**
     files and see that it is downloaded, and you can open it.

11. Download the **Personal employees information.docx** file and see
     that you get a blocking message and instead of the file, you get a
     Blocked...txt file.

   ![wvk16zl2.jpg](/media/wvk16zl2.jpg)

---

### Test the admin experience

1.  Go back to the Cloud App Security portal, and under **Investigate**
    choose **Activity log**

2.   See the login activity that was redirected to the session control,
    the file download that was not blocked, and the file download that
    was blocked because it matched the policy.

    ![j0vuo06k.jpg](/media/j0vuo06k.jpg)
---