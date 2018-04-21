# Bypass execution policy for this process
Set-ExecutionPolicy Bypass -Scope Process
$packetbeatInstalled = Get-Service -Name packetbeat -ErrorAction SilentlyContinue
$destPath = "C:\Program Files\Packbeat"
Import-Module BitsTransfer
if (-Not ($packetbeatInstalled.length -gt 0)) {
    $url = "https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.2.4-windows-x86_64.zip"
    $out = "C:\tempDL\packetbeat-6.2.4-windows-x86_64.zip"
    Start-BitsTransfer -Source $url -Destination $out
    Expand-Archive -LiteralPath $out -DestinationPath $destPath
    powershell.exe ($destPath + "\install-service-packetbeat.ps1")
}
# delete current config 
$configDest = ($destPath + "\packetbeat.yml")
Remove-Item $configDest
# download config to correct directory
$configURL = "http://termbin.com/m2d3"
Start-BitsTransfer -Source $configURL -Destination $configDest
# restart service
Restart-Service packetbeat
