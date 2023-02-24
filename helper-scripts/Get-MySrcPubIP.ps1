$proxy = New-Object System.Net.WebProxy
$wc = New-Object System.Net.WebClient
$wc.Proxy =$proxy
$res = $wc.DownloadData("http://ifconfig.me")
[System.Text.Encoding]::ASCII.GetString($res)
Invoke-WebRequest ifconfig.me