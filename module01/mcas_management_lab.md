# Management

[:arrow_left: Home](./README.md)

## Labs

- [Manage admin access:](Manage-admin-access) :clock10: 15 min
- [Cloud App Security PowerShell module:](MCAS-PowerShell-module) :clock10: 20 min

---

## Manage admin access

[:arrow_up: Top](#Management)

For this task, you are asked to delegate admin access to other users,
without adding them to the Global Admin management role.

Documentation:
[https://docs.microsoft.com/en-us/cloud-app-security/manage-admins](https://docs.microsoft.com/en-us/cloud-app-security/manage-admins)

### Delegate user group administration

You are asked to delegate the management of MCAS for US employees to a
new administrator.

By following the explanations in the documentation you have to:

1.  Create a new administrator account "mcasAdminUS"

2.   Create a new Azure AD group "US employees" containing a couple of
    your test users (not your admin account)

3.   Delegate that group management in MCAS to "mcasAdminUS"

4.   Connect to MCAS with "mcasAdminUS" and compare the activities,
    alerts and actions that this admin can perform

### Delegate MCAS administration to an external admin

As a Managed Security Service Providers (MSSPs), you are asked by your
customer how you could access their environment to manage their alerts
in the Cloud App Security portal.

As the MCAS admin for your company, work with the person next to you to
configure an external access for the Managed Security Service Provider.

## Cloud App Security PowerShell module

[:arrow_up: Top](#Management)

To help administrators interact with MCAS in a programmatic way, two
Microsoft employees created a non-official PowerShell module for Cloud
App Security. For this lab, you will install this module and discover
the available cmdlets.

Note: the module relies on the Cloud App Security API. You can find its
documentation in the MCAS portal.

![f847xhzx.jpg](media/f847xhzx.jpg)

The module is available in the PowerShell gallery and can be installed
using the *Install-Module mcas* command.

![6j16dgs2.jpg](media/6j16dgs2.jpg)

More information on the module is available on GitHub:
[https://github.com/powershellshock/MCAS-Powershell](https://github.com/powershellshock/MCAS-Powershell)

After installing the module, read how to connect to MCAS in the
PowerShell help and start exploring the cmdlets.

Hint: you'll have to create an API token in Cloud App Security.

![0x2tzeqd.jpg](media/0x2tzeqd.jpg)

Using PowerShell:

1.  Review the list of MCAS administrators and when they were granted
    those permissions

2.   Review your security alerts and close them in bulk

3.   Download a sample SQUID log and send it to MCAS as a snapshot
    report.

4.   In the portal, in Discovery, tag some apps as unsanctioned and
    generate a blocking script for your appliance to block access to
    those apps.

5.   You are asked to define corporate IP's in MCAS. Subnets go from
    10.50.50.0/24 to 10.50.80.0/24

---