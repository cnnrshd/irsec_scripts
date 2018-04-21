# Change Password
$admin = (Read-Host -Prompt "New Admin Password" -AsSecureString)
Set-ADAccountPassword -Identity Administrator -NewPassword $admin -Reset
# Clear DNS/ARP/Scheduled tasks/replication
Clear-DnsClientCache
Clear-ARPCache
Stop-Service DFSR
Get-ScheduledTask | Disable-ScheduledTask
# Bypass current execution policy for this process
Set-ExecutionPolicy Bypass -Scope Process
# Check if BITS is installed
$bits = Get-WindowsFeature BITS
if ($bits.Installed) {
    # Install BITS
    Install-WindowsFeature -Name BITS -IncludeAllSubFeature
}
# Create a file to store downloaded scripts in
mkdir C:\scripts
mkdir C:\tempDL
# At this point, BITS is installed
Start-Service BITS
# download and run the firewall script, make sure to set ExecutionPolicy to Unrestricted (only for that line)
Import-Module BitsTransfer
Import-Module ActiveDirectory
$firewallURL = "https://gist.githubusercontent.com/cnnrshd/c0d435c0f14e523d9faa38e2702c2c53/raw/d066980f97cb185afa586c2c39fc737dddc7d2a4/firewallRules.ps1"
$firewallOUT = "C:\scripts\firewallRules.ps1"
Start-BitsTransfer -Source $firewallURL -Destination $firewallOUT
Start-Job $firewallOUT
# Start download of config scripts
# Grab/Run Packetbeat install script
$packetURL = "https://gist.githubusercontent.com/cnnrshd/02839b9403431567a1dc176caa63d2b8/raw/398d4b84ed7f48f0a1c25268c891be107caf0a59/install_packbeat.ps1"
$packetOUT = "C:\scripts\install_packetbeat.ps1"
Start-BitsTransfer -Source $packetURL -Destination $packetOUT
Start-Job $packetOUT
# Grab/Run Winlogbeat install script
$winbeatURL = "https://gist.githubusercontent.com/cnnrshd/6f48a8e002068fe3a1a335f2a473c72c/raw/58960043219a2393893aa6d14544445a82ce3e12/install_winlogbeat.ps1"
$winbeatOUT = "C:\scripts\install_winlogbeat.ps1"
Start-BitsTransfer -Source $winbeatURL -Destination $winbeatOUT
Start-Job $winbeatOUT
# Grab/Run Filebeat install script
#$filebeatURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/scripts/install_filebeat.ps1?token=AiUZH61XZugJNVG3GQcuRHhkJbHTvR1Vks5a4S4ZwA%3D%3D"
#$filebeatOUT = "C:\scripts\install_filebeat.ps1"
#Start-BitsTransfer -Source $filebeatURL -Destination $filebeatOUT
#Start-Job $filebeatOUT
# Grab/Run Sysinternals/sysmon install script
$sysintURL = "https://gist.githubusercontent.com/cnnrshd/e8a74f217bf9f0a775b96233bdecf8bc/raw/d0ddd37019619924a06c871e2bca5894cfb47d6b/install_sysinternals.ps1"
$sysintOUT = "C:\scripts\install_sysinternals.ps1"
Start-BitsTransfer -Source $sysintURL -Destination $sysintOUT
Start-Job $sysintOUT
# Download kerberos reset script
$krbURL = "https://gallery.technet.microsoft.com/Reset-the-krbtgt-account-581a9e51/file/142338/1/New-CtmADKrbtgtKeys.zip"
$krbOUT = "C:\tempDL\New-CtmADKrbtgtKeys.zip"
Start-BitsTransfer -Source $krbURL -Destination $krbOUT
Expand-Archive -LiteralPath "C:\tempDL\New-CtmADKrbtgtKeys.zip" -DestinationPath "C:\New-CtmADKrbtgtKeys"
ipconfig.exe /flushdns
schtasks.exe /delete /tn * -f