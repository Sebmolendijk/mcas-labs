# Microsoft Cloud App Security

This lab will guide you through the different Microsoft Cloud App Security (MCAS) capabilities.
Although some labs are pretty straight forward ,we expect you to already have some basic experience with Cloud App Security or Office 365 management.

>:warning::warning::warning: Before going to the different labs section, please complete the **[environment preparation](mcas_lab_preparation.md)**. :warning::warning::warning:

## Lab environment

![Lab environment](media/mcaslabenvironment.png "Lab environment")

* Client01 is a Windows 10 VM that will be used to access Office 365 and Cloud app Security management consoles and configure the log collector running on LinuxVM, using Putty.
* LinuxVM is an Ubuntu 18.04 computer on which we install Docker to run the Cloud App Security Discovery log collector.
* Office 365 and Cloud App Security are test tenants for the labs.

>:memo: We recommend using the [Cloud App Security documentation](https://docs.microsoft.com/en-us/cloud-app-security/what-is-cloud-app-security "Cloud App Security documentation") to have details on the different use cases, capabilities and configuration steps.

---

## Labs

The different Cloud App Security capabilities covered in the labs are:

- [Cloud Discovery](mcas_discovery_lab.md)
- [Threat Detection](mcas_threat_detection_lab.md)
- [Information Protection](mcas_information_protection_lab.md)
- [Conditional Access App Control](mcas_app_control_lab.md)
- [Management](mcas_management_lab.md)

>:memo: All the labs are independents from each others and can be taken in any order. Only the **[environment preparation](mcas_lab_preparation.md)** must be complete before starting any lab.

---