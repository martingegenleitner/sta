$operatorEmail = 'OPERATOR_EMAIL'
$operatorStaticPW = 'OPERATOR_STATIC_PW'
$organization = 'ORGANIZATION_NAME'
$reportLevel = 'Subscriber' # You can also use 'ServiceProvider'. Depends on the report
$reportOutputFormat = 'CSV' # You can also use 'CSV' or 'TAB'

# Set the service Uri where the WebServiceProxy object loads its definitions from
$client = New-WebServiceProxy -Uri https://cloud.eu.safenetid.com/bsidca/BSIDCA.asmx?WSDL
# Instaniate a cookiecontainer object where the proxy stores cookies from responses.
# This must be done in order to store the ASP.NET_Session cookie sent after the Connect()-Call
$client.CookieContainer = New-Object System.Net.CookieContainer
# User the Connect()-Call to authenticate as an operator to SAS/STA by supplying its mail address and
# static password or other otp. For automation purpuses we use static passwords.
$client.Connect($operatorEmail, $operatorStaticPW, $null, [ref]$null)

# Fetch a list of reports that are ready for download
$reports = $client.GetFinishedReports($reportLevel, '1', '999', $organization)
# Select the last report from the received list
$report = $reports | Select-Object -Last 1
# Transform the date of the selected report into the required format
$reportdate = Get-Date $report.scheduledTime -Format "yyyy-MM-ddTHH:mm:ss.fffffffzzzz"

# Receive the report in various supported formats (HTML, CSV, TAB) and print them to the console
$data = $client.GetReportOutput($reportLevel, $report.reportname, $reportdate, $organization, $reportOutputFormat)
[System.Text.Encoding]::ASCII.GetString($data)