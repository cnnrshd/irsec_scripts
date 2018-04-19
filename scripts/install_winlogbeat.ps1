$winlogbeatInstalled = Get-Service -Name winlogbeat -ErrorAction SilentlyContinue
$destPath = "C:\Program Files\Winlogbeat"
Import-Module BitsTransfer
if (-Not ($winlogbeatInstalled.length -gt 0)) {
    $url = "https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.4-windows-x86_64.zip"
    $out = "C:tempDL\winlogbeat-6.2.4-windows-x86_64.zip"
    Start-BitsTransfer -Source $url -Destination $out
    Expand-Archive -LiteralPath $out -DestinationPath $destPath
    powershell.exe Set-ExecutionPolicy Unrestricted ($destPath + "\install-service-winlogbeat.ps1")
}
# delete current config
$configDest = ($destPath + "\winlogbeat.yml")
Remove-Item $configDest
# download config to correct directory
$configURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/configs/winlogbeat.yml?token=AiUZH97oSRUw3lK9a49YtTIbfQ3fUxi7ks5a4S6MwA%3D%3D"
Start-BitsTransfer -Source $configURL -Destination $configDest
# restart service
Restart-Service winlogbeat
