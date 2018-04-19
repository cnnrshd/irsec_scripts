$packetbeatInstalled = Get-Service -Name packetbeat -ErrorAction SilentlyContinue
$destPath = "C:\Program Files\Packbeat"
Import-Module BitsTransfer
if (-Not ($packetbeatInstalled.length -gt 0)) {
    $url = "https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-6.2.4-windows-x86_64.zip"
    $out = ([System.Environment]::GetFolderPath("Downloads") + "packetbeat-6.2.4-windows-x86_64.zip")
    Start-BitsTransfer -Source $url -Destination $out
    Expand-Archive -LiteralPath $out -DestinationPath $destPath
    powershell.exe Set-ExecutionPolicy Unrestricted ($destPath + "\install-service-packetbeat.ps1")
}
# delete current config 
$configDest = ($destPath + "\packetbeat.yml")
Remove-Item $configDest
# download config to correct directory
$configURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/configs/packetbeat.yml?token=AiUZH-jsHHewKod_BHDMRPZSLUI8k8_9ks5a4S7UwA%3D%3D"
Start-BitsTransfer -Source $configURL -Destination $configDest
# restart service
Restart-Service packetbeat
