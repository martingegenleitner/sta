# Set the service Uri where the WebServiceProxy object loads its definitions from
$client = New-WebServiceProxy -Uri https://cloud.eu.safenetid.com/bsidca/BSIDCA.asmx?WSDL
# Instaniate a cookiecontainer object where the proxy stores cookies from responses.
# This must be done in order to store the ASP.NET_Session cookie sent after the Connect()-Call
$client.CookieContainer = New-Object System.Net.CookieContainer
# User the Connect()-Call to authenticate as an operator to SAS/STA by supplying its mail address and
# static password or other otp. For automation purpuses we use static passwords.
$client.Connect('OPERATOR_EMAIL', 'OPERATOR_STATIC_PW', $null, [ref]$null)
# Fetch the first 20 users from the given account. The account name can be found in the STA/SAS console.
# The organisation name is not the cryptic hash, but the full written name like "Thales DIS CPL" with spaces also supported.
$client.GetUsers($null, $null, 'Any', $null, 0, 20, 'ORGANISATION')