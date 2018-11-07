# Information protection

[🔙](#microsoft-365-cloud-app-security)

15 min

In a perfect world, all your employees understand the importance of information protection and work within your policies. But in a real world, it's probable that a partner who works with accounting uploads a document to your Box repository with the wrong permissions, and a week later you realize that your enterprise's confidential information was leaked to your competition.
Microsoft Cloud App Security helps you prevent this kind of disaster before it happens.

In this task, you will protect a sensitive document library in SharePoint Online using the native integration with Azure Information Protection.

## Integrate MCAS with Azure Information Protection

As explained in the [documentation](https://docs.microsoft.com/en-us/cloud-app-security/azip-integration), configure the integration between the two solutions. 

1. Go to Cloud App Security settings and check the **Automatically scan new files** checkbox.

	![imku224m.jpg](media/imku224m.jpg)
2.  Click on the **Save** button.

## Apply AIP classification to SSN documents

3.  Go to **Policies**.

	![i2nnuzsg.jpg](media/i2nnuzsg.jpg)
4.  Create a new **File policy**.

	![aoodi6ml.jpg](media/aoodi6ml.jpg)
5.  Provide the following settings to that policy:
	1. Policy name: **Protect SSN documents in sensitive site**.
	1. Files matching all of the following: **remove the filters**.
	1. Apply to: **selected folder**.

	> NOTE: Here, select the **Shared Documents** folder from the default SharePoint site.
	
		![mt3guvwp.jpg](media/mt3guvwp.jpg)

		![piparayd.jpg](media/piparayd.jpg)
	1. Verify that you have one selected folder and click on **Done**.
	
		![ovruaovh.jpg](media/ovruaovh.jpg)

		![q67v9yh6.jpg](media/q67v9yh6.jpg)
	1. In inspection method, select **Data Classification Service**.
	
		![7fw3fh7n.jpg](media/7fw3fh7n.jpg)
	1. Click on sensitive information type, select the **SSN related** ones and click on **Done**.
	
		![2plklsza.jpg](media/2plklsza.jpg)
	1. Click on the **Unmask** checkbox.
	
		![a89zd1k2.jpg](media/a89zd1k2.jpg)
	1. In the Governance actions, select **Apply classification label**.
	
		![6wfpj4to.jpg](media/6wfpj4to.jpg)
	1. Click **Create** to finish the policy creation.

---
# Quarantine sensitive PDF for review
[🔙](#microsoft-365-cloud-app-security)

File policies are a great tool for finding threats to your information protection policies, for instance finding places where users stored sensitive information, credit card numbers and third-party ICAP files in your cloud. With Microsoft Cloud App Security, not only can you detect these unwanted files stored in your cloud that leave you vulnerable, but you can take immediate action to stop them in their tracks and lock down the files that pose a threat. Using Admin quarantine, you can protect your files in the cloud and remediate problems, as well as prevent future leaks from occurring.
This is what we are going to configure in this lab.

1. In Cloud App Security, go to the **Settings**.

	![oqfkh5cw.jpg](media/oqfkh5cw.jpg)
2.  In the Information Protection section, go to **Admin quarantine**.

	![pvjk90y0.jpg](media/pvjk90y0.jpg)
3.  In the dropdown menu, select your root SharePoint site.

	1. In user notification, type **Your content has been quarantined. Please contact your admin.**
	1. Click on the Save button.

    >NOTE: As best practice, you should define a dedicated site with restricted access as the admin quarantine location.

	![hl55gqvd.jpg](media/hl55gqvd.jpg)
4.  Next, go to the policies menu and create a new **file policy**.

	![3xpu3nw7.jpg](media/3xpu3nw7.jpg)
5.  Provide the following settings to that policy:
	1. Policy name: **Quarantine sensitive pdf**
	1. Files matching all of the following: **Extension equals pdf**
	
	![2cmlwt55.jpg](media/2cmlwt55.jpg)
	1. In Governance actions, select **Put in admin quarantine** and click on the Create button.
	
	![1wlrz08d.jpg](media/1wlrz08d.jpg)
 
## Test our policies

To test our files policies, perform the following tasks:

1. On Client01, unzip the content of the **Demo files.zip**.
7.  Go to the **Contoso Team Site** documents library.
8.  Upload the unzipped files to the site.


	![xf5ozmrf.jpg](media/xf5ozmrf.jpg)
9.  Cloud App Security will now scan those documents and search for matches to our created policies. The scan can take some minutes before completion.
10.  To monitor the evolution, go back to Cloud App Security and open the **Files** page of the investigations.

	![wb3gbn9w.jpg](media/wb3gbn9w.jpg)
11. When a match is discovered, you will see it in this page.

	![6g2kg3vq.jpg](media/6g2kg3vq.jpg)
12.  Open the details of the file. You can see there the matched policies and the scan status of the files.

	![rqbu6yyq.jpg](media/rqbu6yyq.jpg)
13.  You can also view the related governance actions in the Governance log.

	![bg5romej.jpg](media/bg5romej.jpg)
	
	![fbsrlfsk.jpg](media/fbsrlfsk.jpg)

14.  You will also notice that the quarantined files will be replaced by placeholders containing your custom message and be moved to the "Quarantine" location we defined.

	![as3niznc.jpg](media/as3niznc.jpg)

	![juas1s58.jpg](media/juas1s58.jpg)

	![drm0yj0c.jpg](media/drm0yj0c.jpg)
