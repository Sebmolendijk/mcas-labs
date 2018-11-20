# Management

[:arrow_left: Home](/README.md)

## Labs

- [Manage admin access:](#Manage-admin-accesst) :clock10: 15 min

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

1. Create a new administrator account "mcasAdminUS"

2. Create a new Azure AD group "US employees" containing a couple of
    your test users (not your admin account)

3. Delegate that group management in MCAS to "mcasAdminUS"

4. Connect to MCAS with "mcasAdminUS" and compare the activities,
    alerts and actions that this admin can perform

### Delegate MCAS administration to an external admin

As a Managed Security Service Providers (MSSPs), you are asked by your
customer how you could access their environment to manage their alerts
in the Cloud App Security portal.

As the MCAS admin for your company, work with the person next to you to
configure an external access for the Managed Security Service Provider.