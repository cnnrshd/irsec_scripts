Import-Module BitsTransfer
$sysmonInstalled = Get-Service -Name Sysmon -ErrorAction SilentlyContinue
$sysmon64Installed = Get-Service -Name Sysmon64 -ErrorAction SilentlyContinue
$sysinternalsURL = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
$out = ([System.Environment]::GetFolderPath("Desktop") + "SysinternalsSuite.zip")
$sysintFolder = ([System.Environment]::GetFolderPath("Desktop") + "\SysinternalsSuite")
Start-BitsTransfer -Source $sysinternalsURL -Destination $out
Expand-Archive -LiteralPath $out -DestinationPath $sysintFolder
if ($sysmonInstalled.length -gt 0) {
    powershell.exe ($sysintFolder + "Sysmon.exe" + " -u")
}
if (-not ($sysmon64Installed.length -gt 0)) {
    powershell.exe ($sysintFolder + "Sysmon64.exe" + " -i")
}
# Download config
$configDest = ($sysintFolder + "\sysmon_config.xml")
# download config to correct directory
$configURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/configs/sysmonconfig.xml?token=AiUZH7fIhNSMPl7KfWZcrCAoqOMq2QVDks5a4S6-wA%3D%3D"
Start-BitsTransfer -Source $configURL -Destination $configDest
# Install config
powershell.exe ($sysintFolder + "\Sysmon64.exe" + " -c " + ".\sysmon_config.xml")
# restart service
Restart-Service Sysmon64