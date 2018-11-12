# Microsoft Cloud App Security

This lab will guide you through the Microsoft Cloud App Security (MCAS) capabilities.
We expect you to already have some basic experience with MCAS deployment and configuration.

Most MCAS treat detections capabilities rely on auditing being enabled in your environment. By default, auditing is not enabled in Office 365 and must be turned on using the **Security & Compliance** admin console or PowerShell. In addition, some applications like Exchange Online require extra configuration, like [enabling auditing for the mailboxes](https://docs.microsoft.com/en-us/office365/securitycompliance/enable-mailbox-auditing?redirectSourcePath=%252fen-us%252farticle%252fenable-mailbox-auditing-in-office-365-aaca8987-5b62-458b-9882-c28476a66918)).

>:memo: As this operation can take up to 24h, your instructor will provide you access to another environment to review the alerts for the threat detection lab.

Before going to the labs section, please complete the [environment preparation](mcas_lab_preparation.md).

---

## Labs

The different Cloud App Security capabilities covered in the labs are:

- [Cloud Discovery](mcas_discovery_lab.md)
- [Threat Detection](mcas_threat_detection_lab.md)
- [Information Protection](mcas_information_protection_lab.md)
- [Conditional Access App Control](mcas_app_control_lab.md)
- [Management](mcas_management_lab.md)

>:warning: All the las are independents from each others and can be taken in any order. Only the **environment preparation** must be complete before starting the other sections.

---