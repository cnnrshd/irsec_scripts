# Bypass execution policy for this process
Set-ExecutionPolicy Bypass -Scope Process
$winlogbeatInstalled = Get-Service -Name winlogbeat -ErrorAction SilentlyContinue
$destPath = "C:\Program Files\Winlogbeat"
Import-Module BitsTransfer
if (-Not ($winlogbeatInstalled.length -gt 0)) {
    $url = "https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.4-windows-x86_64.zip"
    $out = "C:tempDL\winlogbeat-6.2.4-windows-x86_64.zip"
    Start-BitsTransfer -Source $url -Destination $out
    Expand-Archive -LiteralPath $out -DestinationPath $destPath
    powershell.exe ($destPath + "\install-service-winlogbeat.ps1")
}
# delete current config
$configDest = ($destPath + "\winlogbeat.yml")
Remove-Item $configDest
# download config to correct directory
$configURL = "http://termbin.com/6wy1"
Start-BitsTransfer -Source $configURL -Destination $configDest
# restart service
Restart-Service winlogbeat
