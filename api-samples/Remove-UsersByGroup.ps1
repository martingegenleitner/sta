$operatorEmail = 'OPERATOR_EMAIL'
$operatorStaticPW = 'OPERATOR_STATIC_PW'
$organization = 'ORGANIZATION_NAME'
$syncGroupName = 'GROUP_NAME'
$restApiKey = 'REST_API_KEY'
$organizationHash = 'ORGANIZATION_HASh'

# Set the service Uri where the WebServiceProxy object loads its definitions from
$client = New-WebServiceProxy -Uri https://cloud.eu.safenetid.com/bsidca/BSIDCA.asmx?WSDL
# Instaniate a cookiecontainer object where the proxy stores cookies from responses.
# This must be done in order to store the ASP.NET_Session cookie sent after the Connect()-Call
$client.CookieContainer = New-Object System.Net.CookieContainer
# User the Connect()-Call to authenticate as an operator to SAS/STA by supplying its mail address and
# static password or other otp. For automation purpuses we use static passwords.
$client.Connect($operatorEmail, $operatorStaticPW, $null, [ref]$null)
# Fetch users from the given account within the given group. The account name can be found in the STA/SAS console.
# The organisation name is not the cryptic hash, but the full written name like "Thales DIS CPL" with spaces also supported.
# Parameters:
# * Groupname
# * Search for Members (true) or users that are not members of this group (false)
# * kind: Read Only, Writable or Both
# * username filter: use $null for all users (= no filter)
# * lastname filter: use $null for all users (= no filter)
# * Organization
$users = $client.GetUsersForGroup($syncGroupName, $true, 'Both', $null, $null, $organization)
# Fetch all tokens for each user
foreach($user in $users) {
    # Gets the serial ids of the tokens assigned to the given username
    $tokens = $client.GetTokensByOwner($user.username, $organization)
    # Summary: Revoke a token from a user.
    # * Param: serial: Serial number of the token. (Serial of "0" for static passwords)
    # * Param: userName: User to revoke the token from.
    # * Param: comment: Message to attach to the token.
    # * Param: revokeMode: One of: ReturntoInventory_Initialized, ReturntoInventory_NotInitialized, Faulty, Lost
    # * Param: revokeStaticPassword: True to also revoke the user's static password.
    # * Param: organization: Account
    # * Returns:
    # successRevokeTemp = Successfully revoked a static password
    # failRevokeTemp = Failed to revoke a static password
    # BothSuccess = Revoked the token and removed the static password
    # SuccessFail = Revoked the token but failed to revoke the static password
    # Success = Revoked the token
    # Fail
    # LastAuth = User is an operator or account manager. Their last authentication method cannot be removed.
    $tokens | ForEach-Object {
        $client.RevokeToken($_, $user.username, 'Revoke-Comment', 'ReturntoInventory_NotInitialized', $true, $organization)
    }

    # Gets a table of information on provisioning tasks
    # * user: The user to get provisioning tasks for
    # * organization: Account
    # * startRecord: First record
    # * numberOfRecords: Number of records
    # * Returns:
    # A table with the columns:
    #  - taskid
    #  - operator
    #  - startdate
    #  - count
    #  - tokenoption
    #  - stopdate
    $provisioningTasks = $client.GetProvisioningTasksForUser($user.username, $organization, 0, 10)
    
    # Removes an existing provisioning task, optionally sending a notification e-mail to all the users that this affects.
    # * Param: taskID: Task ID to remove
    # * Param: sendNotificationEmail:
    $provisioningTasks | ForEach-Object {
        $client.RemoveProvisioningTask($_.taskid, $false, $organization)
    }

    # For documentation @see https://api.eu.safenetid.com/swagger/index.html
    $headers = @{
        'accept' = 'application/json'
        'apikey' = $restApiKey
    }
    Invoke-RestMethod -Method Delete -Uri "https://api.eu.safenetid.com/api/v1/tenants/$organizationHash/users/$($user.username)" -Headers $headers

}