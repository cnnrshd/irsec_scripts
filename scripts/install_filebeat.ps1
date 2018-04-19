# Bypass execution policy for this process
Set-ExecutionPolicy Bypass -Scope Process
$filebeatInstalled = Get-Service -Name filebeat -ErrorAction SilentlyContinue
$destPath = "C:\Program Files\Filebeat"
Import-Module BitsTransfer
if (-Not ($filebeatInstalled.length -gt 0)) {
    $url = "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.2.4-windows-x86_64.zip"
    $out = "C:\tempDL\filebeat-6.2.4-windows-x86_64.zip"
    Start-BitsTransfer -Source $url -Destination $out
    Expand-Archive -LiteralPath $out -DestinationPath $destPath
    powershell.exe ($destPath + "\install-service-filebeat.ps1")
}
# delete current config
$configDest = ($destPath + "\filebeat.yml")
Remove-Item $configDest
# download config to correct directory
$configURL = ""
Start-BitsTransfer -Source $configURL -Destination $configDest
# restart service
Restart-Service filebeat
