# Trouble Shooting

[Back to Overview](README.md)

## General | Something does not work

Use a browser in incognito mode. Sometimes caches on the browser side prevent a clean context switch between operators.

## Sync Agent | "Can not sync AD Passwords"

```shell
[ERROR] BaseUserAdapter.ActiveDirectory.ActiveDirectoryRepository   Unable to retrieve AD password hash for user or user's AD password was not set.BaseUserAdapter.Exceptions.UserSourceException: 5134// System.UnauthorizedAccessException: Replication access was denied ---> System.ComponentModel.Win32Exception: Replication access was denied
   --- End of inner exception stack trace ---
   at DSInternals.Common.Validator.AssertSuccess(Win32ErrorCode code)
   at DSInternals.Replication.Interop.DrsConnection.ReplicateSingleObject(String distinguishedName, UInt32[] partialAttributeSet)
   at DSInternals.Replication.DirectoryReplicationClient.GetAccount(String distinguishedName)
   at BaseUserAdapter.ActiveDirectory.ActiveDirectoryService.GetPasswordHash(String userDistinguishedName)
   at BaseUserAdapter.ActiveDirectory.ActiveDirectoryService.GetPasswordHash(String userDistinguishedName)
   at BaseUserAdapter.ActiveDirectory.ActiveDirectoryRepository.GetPasswordHash(IEnumerable`1 adUsers, Boolean ignoreFailedPasswordHash)
[WARN]  ClientAccess.SqliteAccess   Notifications are active but no recipients are configured. Skipping sending notification emails
[DEBUG] Debug   Exception:5134// Unable to retrieve AD password hash for user or user's AD.   at BaseUserAdapter.ActiveDirectory.ActiveDirectoryRepository.GetPasswordHash(IEnumerable`1 adUsers, Boolean ignoreFailedPasswordHash)
   at DataLayer.LDAPUserSource.a(String A_0, String A_1, UsersSyncOptions A_2, Boolean A_3)
   at DataLayer.LDAPUserSource.GetFullUsersFromGroup(String groupName, String organization, UsersSyncOptions usersSyncOptions)
   at ProxiedSource.ScanAndRecord.GetUniqueUsersFromRemoteUserSource(String currentOrganization, Int64 transactionNumber, List`1 requiredGroups, IUserSource remoteUserSource, IUserRepository localUserCache, ITransactionStatusRepository transactionStatusRepository, UserConfig uc)
   at ProxiedSource.ScanAndRecord.ScanUsers(ScannerInputContext scannerInputContext, ScannerOutputContext outputContext, Dictionary`2& uniqueUsersFromRemoteSource)
   at ProxiedSource.ScanAndRecord.ScanSource(QueuedBackgroundWorker bw)
```

It is not possible to sync users with their AD password hashes.

**Solution** = Follow the guide @ <https://docs.microsoft.com/en-us/troubleshoot/windows-server/windows-security/grant-replicating-directory-changes-permission-adma-service> on how to grant the domain joined machine the permissions "Replicating Directory Changes" and "Replicating Directory Changes All".

## STA Account Management | "Cannot update the account services information. Contact your administrator."

It is not possible to extend the Service Stop date of a STA Account.

**Solution** = First extend the same date of the parent account.
