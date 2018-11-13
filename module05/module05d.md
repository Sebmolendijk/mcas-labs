# Conditional Access App Control
[🔙](#microsoft-365-cloud-app-security)

### Estimated time to complete
40 min

Please go through all the steps exactly as described to avoid
complications.

### Configure Salesforce

1.  Create a Salesforce developer account

    1.  On Client01, launch a browser and go to the URL below. 
	
		**https://developer.salesforce.com/signup**

    2.   **Important:** Use your admin user as the Email
        and Username

        **Global Admin Username**

    3.   Fill in the rest of details, click Sign me up, accept the
        verification email, and choose a new password.

1.   Configure Salesforce in Azure AD
    
    1.  In Salesforce, go to **Setup**, search for **My Domain** and
        register a new domain, e.g., ems123456-dev-ed.salesforce.com

        ![f7idpipy.jpg](media/f7idpipy.jpg)

    1.  Save **full Salesforce domain name**, including **https://** for the
        next step, e.g., <https://ems123456-dev-ed.salesforce.com>

    1.   Go to **https://portal.azure.com** logging in with the credentials below:

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
        ![ao0yrpx8.jpg](media/ao0yrpx8.jpg)

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
        
		![kscnoob4.jpg](media/kscnoob4.jpg)

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
        ![b62lha77.jpg](media/b62lha77.jpg)

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
            ![qti7w9u6.jpg](media/qti7w9u6.jpg)

    1.   After the policy was created successfully, open a new browser,
        ***make sure you are logged out***, and log in to
        SalesforceCAS with the admin user

        1. You can go to **https://myapps.microsoft.com** and click on
            the SalesforceCAS tile

        1.  Make sure you've successfully logged on to Salesforce

    1.   Go to the Cloud App Security portal, and under the settings cog
        choose **Conditional Access App Control
        ![dfmwyegm.jpg](media/dfmwyegm.jpg)

    1.   You should see a message letting you know that new Azure AD apps
        were discovered. Click on the **View new apps** link.
        ![qz9mx11x.jpg](media/qz9mx11x.jpg)

        1. If the message does not appear, go back to step c. (After
            the policy was created...) this time, close the browser and
            open a new browser in Incognito mode.

    1.   In the dialog that opens, you should see Salesforce. Click on
        the + sign, and then click **Add**.
        ![iy3f8gro.jpg](media/iy3f8gro.jpg)

### Configure device authentication

1.  Go to the settings cog and choose **Device identification**.

2.   Upload the CASTestCA.crt certificate from the Client Certificate
     folder within the **E:\Demofiles.zip** file you've received as the
     certificate authority root certificate

	![rlkp1xvp.jpg](media/rlkp1xvp.jpg)
### Create a session policy

1.  In the Cloud App Security portal, select **Control** followed
     by **Policies**.

2.   In the **Policies** page, click **Create policy** and
     select **Session policy**.

     ![6lh61nkl.jpg](media/6lh61nkl.jpg)

3.   In the **Session policy** window, assign a name for your policy,
     such as *Block download of sensitive documents to unmanaged
     devices.*
     ![a6i9js1x.jpg](media/a6i9js1x.jpg)

4.   In the **Session control type** field Select **Control file download
     (with DLP)** 
	 ![j9pxy1lm.jpg](media/j9pxy1lm.jpg)

5.   Under **Activity source** in the **Activities matching all of the
     following** section, select the following activity filters to
     apply to the policy:

    1. **Device tags** does not equal **Valid client certificate**

    2. **App** equals **Salesforce**
    ![6wwuqlcz.jpg](media/6wwuqlcz.jpg)

6.   Check the **Enabled** checkbox near **Content inspection**

7.   Check the **Include files that match a preset expression** radio
     button

8.   In the dropdown menu just below the radio button, scroll all the way
     to the end to choose **US: PII: Social security number**

9.   Check the **Don't require relevant context** checkbox, just below
     the dropdown
     menu
	 ![10uz9qp1.jpg](media/10uz9qp1.jpg)

10.  Under **Actions**, select **Block**

11. Check the **Customize block message** checkbox, and add a custom
     message in the textbox that has opened, e.g.: "This file is
     sensitive"
    ![dzdsku3w.jpg](media/dzdsku3w.jpg)

12.  Click on **Create**

13.  Create a second **Session policy** called *Protect download to
     unmanaged devices.*

14.  In the **Session control type** field Select **Control file download
     (with DLP)** 

	 ![xsznq6n8.jpg](media/xsznq6n8.jpg)

15.  Under **Activity source** in the **Activities matching all of the
     following** section, select the following activity filters to
     apply to the policy:

 	**Device tags** does not equal **Valid client certificate**

 	**App** equals **Salesforce**

 	![8s4bu84k.jpg](media/8s4bu84k.jpg)

16.  Clear the **Enabled** checkbox near **Content inspection**

17.  Under **Actions**, select **Protect**

    ![c5xhnr87.jpg](media/c5xhnr87.jpg)

18.  Click on **Create**

19.  Disable this policy

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

   ![2mj216sm.jpg](media/2mj216sm.jpg)

7.   You should then see a Monitored access message, click on **Continue
     to Salesforce** to continue.

    ![h2oyt9fw.jpg](media/h2oyt9fw.jpg)

8.   Now you are logged in to Salesforce. Click on + and go to Files

    ![d0ik67yl.jpg](media/d0ik67yl.jpg)

9.  Upload the files **Personal employees information.docx** and
     **Protect with Microsoft Cloud App Security proxy.pdf** from the
     **Demo files.zip** file to the Files page in Salesforce

10.  Download the **Protect with Microsoft Cloud App Security proxy.pdf**
     files and see that it is downloaded, and you can open it.

11. Download the **Personal employees information.docx** file and see
     that you get a blocking message and instead of the file, you get a
     Blocked...txt file.

   ![wvk16zl2.jpg](media/wvk16zl2.jpg)

### Test the admin experience

1.  Go back to the Cloud App Security portal, and under **Investigate**
    choose **Activity log**

2.   See the login activity that was redirected to the session control,
    the file download that was not blocked, and the file download that
    was blocked because it matched the policy.

    ![j0vuo06k.jpg](media/j0vuo06k.jpg)
---