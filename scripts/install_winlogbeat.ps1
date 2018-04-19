$winlogbeatInstalled = Get-Service -Name winlogbeat -ErrorAction SilentlyContinue
$destPath = "C:\Program Files\Winlogbeat"
Import-Module BitsTransfer
if (-Not ($winlogbeatInstalled.length -gt 0)) {
    $url = "https://artifacts.elastic.co/downloads/beats/winlogbeat/winlogbeat-6.2.4-windows-x86_64.zip"
    $out = ([System.Environment]::GetFolderPath("Downloads") + "winlogbeat-6.2.4-windows-x86_64.zip")
    Start-BitsTransfer -Source $url -Destination $out
    Expand-Archive -LiteralPath $out -DestinationPath $destPath
    powershell.exe Set-ExecutionPolicy Unrestricted ($destPath + "\install-service-winlogbeat.ps1")
}
# delete current config
$configDest = ($destPath + "\winlogbeat.yml")
Remove-Item $configDest
# download config to correct directory
$configURL = "https://gist.githubusercontent.com/cnnrshd/17870aa8e25b3a834b8cd08e24c0ccd1/raw/fd809662fc0e35bbaa8798e7df409ecb895bd874/winlogbeat.yml"
Start-BitsTransfer -Source $configURL -Destination $configDest
# restart service
Restart-Service winlogbeat
