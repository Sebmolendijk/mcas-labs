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

    * Fill in the rest of details, click **Sign me up**, accept the **verification email** in your mailbox, and choose a new password. Use the admin password provided in the lab environment if possible.

        ![Dev sign-up](/media/appc-signup2.png "Salesforce sign-up")

        ![Dev sign-up](/media/appc-signup3.png "Salesforce sign-up")

2. Configure Salesforce in Azure AD for single sign-on.

    * In Salesforce, go to **Setup**, search for **My Domain** and register a new domain matching your Office 365 lab domain, e.g., **ems123456-dev-ed.salesforce.com**

        ![My domain](/media/sf-mydomain.png "My domain")

        ![My domain](/media/sf-registerdomain.png "My domain")

        ![My domain](/media/sf-registerdomain2.png "My domain")

    * Save **full Salesforce domain name**, including **https://** for the next step, e.g., **https://ems123456-dev-ed.salesforce.com**

        >:warning: Do not close this page !

        ![My domain](/media/sf-registerdomain3.png "My domain")

    * Go to **https://portal.azure.com** were we will add Salesforce as an Enterprise application and configure **single sign-on**, which is a requirement for using App Control.

3. Go to **Azure Active Directory**, click on **Enterprise applications**, and add the **Salesforce** application. Call it **SalesforceCAS**, and click on **Add**.

    ![Add SF](/media/appc-app1.png "Add SF")

    ![Add SF](/media/appc-app2.png "Add SF")

    ![Add SF](/media/appc-app3.png "Add SF")

    ![Add SF](/media/appc-app4.png "Add SF")

4. Now that Salesforce has been added as an Enterprise application, we have to configure **single sign-on**.

    ![Add SF](/media/appc-app5.png "Add SF")

5. Select **SAML** as the SSO method.

    ![Add SF](/media/appc-app6.png "Add SF")

6. We will now configure the SAML single sign-on using the information provided by Salesforce when we added our domain.

    >:warning: Do not forget to add **https://** in front of the domain name provided by Salesforce.

    ![Add SF](/media/appc-app7.png "Add SF")

    ![Add SF](/media/appc-app8.png "Add SF")

7. Close the pane and go to the **Step 4** of the SSO wizard and click on **View step-by-step instructions**. This page will give you all the required information for configuring Salesforce SSO.

    ![Add SF](/media/appc-app9.png "Add SF")

    ![Add SF](/media/appc-app10.png "Add SF")

8. Go back to the **Salesforce admin page** and go to the **Signle sign-on** settings. There, click on the **Edit** button.

    ![Add SF](/media/appc-app11.png "Add SF")

9. Enable single sign-on using SAML and click on the **Save** button.

    ![Add SF](/media/appc-app12.png "Add SF")

10. Back on the configuration page, under **SAML Single Sign-On Settings**, click on **New**.

    ![Add SF](/media/appc-app13.png "Add SF")

    We will now configure those settings using the information provided in the **Azure AD portal**.

    ![Add SF](/media/appc-app14.png "Add SF")

11. For the configuration, you will have to use the information provided at the bottom of the Azure AD **Configure sign-on** pane. Scroll down until you reach the **Quick reference** section.

    ![Add SF](/media/appc-app15.png "Add SF")

12. Copy/paste the information from the **Quick reference** to the Salesforce **single sign-on settings** page.

    a.In the Name textbox, type the name of the configuration: **AzureAD**.

    b. Paste **Azure AD SAML Entity ID** value into the **Issuer** textbox.

    c. In the **Entity Id** textbox, type in the **Sign On URL** that you entered in **Step 1**, which should be in this format: **http://company.my.salesforce.com**

    d. Download the **Azure AD Signing Certificate** in the Azure portal and then click **Browse** to upload the downloaded certificate Azure AD Signing Certificate in the **Salesforce setting page**.

    e. As **SAML Identity Type**, select **Assertion contains the Federation ID** from the User object.

    f. As **SAML Identity Location**, select **Identity is in the NameIdentifier element of the Subject statement**.

    g. Paste **Azure AD Single Sign-On Service URL** into the **Identity Provider Login URL** textbox.

    h. Salesforce does not support SAML logout. As a workaround, paste **Azure AD Sign Out URL** into the **Identity Provider Logout URL** textbox.

    i. As **Service Provider Initiated Request Binding**, select **HTTP POST**.

    j. Click Save.

    ![Add SF](/media/appc-app16.png "Add SF")

    ![Add SF](/media/appc-app17.png "Add SF")

13. Go back to **My Domain** in Salesforce and in **Authentication Configuration**, click on **Edit**. You will be redirected to another page.

    ![Add SF](/media/appc-app18.png "Add SF")

14. In **Authentication Configuration**, un-check the **Login Page** checkbox and check the **Azure AD** checkbox. Click on Save. When back on the configuration page, click on the **login** button to complete the configuration.

    ![Add SF](/media/appc-app19.png "Add SF")

    ![Add SF](/media/appc-app20.png "Add SF")

    ![Add SF](/media/appc-app20a.png "Add SF")

    ![Add SF](/media/appc-app20b.png "Add SF")

---

## Deploy Salesforce to your users

We will now provide access to our users and validate the SSO experience.

1. Go back to the Azure AD portal, within the **SalesforceCAS** app and choose **Users and groups**

    ![Assign users](/media/appc-app21.png "Assign users")

2. Click on **+ Add user**. Choose your admin account as the user (e.g.,admin@ems123456.onmicrosoft.com) and select **System Administrator** as the Role. Click on **Assign**

    ![Assign users](/media/appc-app22.png "Assign users")

    ![Assign users](/media/appc-app23.png "Assign users")

    ![Assign users](/media/appc-app24.png "Assign users")

    ![Assign users](/media/appc-app24.png "Assign users")

    >:warning: If you want to assign Salesforce to more users, you must create a user for them in Salesforce as we didn't configured **provisionning**. Our admin account already has an an account matching his UPN, created during the Salesforce configuration.

3. Test the setup by going to [https://myapps.microsoft.com](https://myapps.microsoft.com) with your admin account and click on the **SalesforceCAS** app. You should then experience SSO to Salesforce.

    ![Test SSO](/media/appc-app25.png "Test SSO")

    ![Test SSO](/media/appc-app26.png "Test SSO")

    :warning: If you receive an error message, verify that you validated the SSO configuration by clicking on the **Log in** button in **step 14**.

---

## Deploy the reverse proxy capability for Salesforce

The next step of the configuration is to create a Conditional access policy in Azure AD and then complete the configuration in Cloud App Security.

>:memo: Soon, you will be able to perform the full configuration from the Azure AD conditional access policy configuration pane.

1. In Azure Active Directory, under **Security**, click on **Conditional access**.

    ![Configure policy](/media/appc-policy1.png "Configure policy")

2. Click on **New policy** and create a new policy.

![Configure policy](/media/appc-policy2.png "Configure policy")

3. Use the following settings in your policy.

    **Name**: Test Cloud App Security proxy
    **Assignment**: choose your admin
    **Cloud apps**: SalesforceCAS
    **Access control / Session**: Use Conditional Access App Control **checkbox**

    ![Configure policy](/media/appc-policy3.png "Configure policy")

    ![Configure policy](/media/appc-policy4.png "Configure policy")

    ![Configure policy](/media/appc-policy5.png "Configure policy")

4. Enable your policy and click on **Create**

    ![Configure policy](/media/appc-policy6.png "Configure policy")

    ![Configure policy](/media/appc-policy7.png "Configure policy")

5. After the policy was created successfully, open a new browser, ***make sure you are logged out***, go to [https://myapps.microsoft.com](https://myapps.microsoft.com), connect with the admin user and click on the SalesforceCAS tile.

6. Go back to the Cloud App Security portal, and under the settings cog choose **Conditional Access App Control**.

    ![Configure policy](/media/appc-policy8.png "Configure policy")

    You should see a message letting you know that new Azure AD apps were discovered. Click on the **View new apps** link.
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