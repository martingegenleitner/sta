# FAQs

[Back to Overview](README.md)

## GrIDsure URL

What are the correct URLs to download a GrIDsure-Pattern / -Image from the different STA instances?

* Classic-Cloud = <https://grid.safenet-inc.com/blackshieldss/O/**SELF_SERVICE_IDENTIFIER**/index.aspx?getChallengeImage=true&userName=**USERNAME**>
* EU-Cloud = <https://cloud.eu.safenetid.com/blackshieldss/O/**SELF_SERVICE_IDENTIFIER**/index.aspx?getChallengeImage=true&username=**USERNAME**>
* US-Cloud = <https://cloud.us.safenetid.com/blackshieldss/O/**SELF_SERVICE_IDENTIFIER**/index.aspx?getChallengeImage=true&username=**USERNAME**>

## DisplayName for custom Mailer

Is it possible to set the DisplayName for a custom E-Mail-Configuration?
Yes. Use the following format: **DISPLAY_NAME (SENDER_EMAIL_ADDRESS)**
Valid Examples:

* SysAdmin (sysadmin@company.com)
* sysadmin@company.com

## SOAP-API documentation and endpoints

The official documentation can be found by searching "WSDL BSIDCA API Developer's Guide" in the SupportPortal at <https://supportportal.gemalto.com> or by downloading the SAS PCE package. In the later the most current guide will be included.

### WSDL-Endpoints

* Classic-Cloud = <https://cloud.safenet-inc.com/bsidca/BSIDCA.asmx?WSDL>
* EU-Cloud = <https://cloud.eu.safenetid.com/bsidca/BSIDCA.asmx?WSDL>
* US-Cloud = <https://cloud.us.safenetid.com/bsidca/BSIDCA.asmx?WSDL>

## STA Status Page

@ <https://supportportal.gemalto.com/csm?id=sta_dashboards>

## How to delete LDAP-Synced users?

Either use the REST-API like shown in [Remove-UsersByGroup.ps1](api-samples/Remove-UsersByGroup.ps1) or by using a LDAP-Sync-Agent and sync an empty group.

```text
NOTE Synchronization occurs only if the Sync Groups list contains at least one group.
Keep in mind that groups will be synchronized even if they contain no users.
In the rare event that you wish to remove all users from SAS and, in essence, start from
scratch, you can change your SAS Synchronization Agent configuration to include one
new empty group, remove the other groups, and then synchronize. SAS will be updated
with just the one empty group. You can now reconfigure SAS Synchronization Agent to
include the groups you would like and, on the next sync, SAS will be updated with those
groups.
```

## Where can I download Software for STA?

All downloads (agents + docs) can be found publicly on the [THALES Support Portal](https://supportportal.thalesgroup.com/csm) even without any login. Enter `STA` into the search bar, WAIT and then click on the product `SafeNet Trusted Access` in the pre-found search results. This will lead to STA's main page where there is a tile that leads to the Agent downloads.

The direct link to that downloads page is [here](https://supportportal.thalesgroup.com/csm/?id=kb_article_view&sys_kb_id=c1b2e9d54fa262001efc69d18110c71a&sysparm_article=KB0010219).
