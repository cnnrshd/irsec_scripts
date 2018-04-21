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
$firewallURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/scripts/firewallRules.ps1?token=AiUZH4U175nUYsPanhLvY6qu722KXJpKks5a4Sx_wA%3D%3D"
$firewallOUT = "C:\scripts\firewallRules.ps1"
Start-BitsTransfer -Source $firewallURL -Destination $firewallOUT
Start-Job $firewallOUT
# Start download of config scripts
# Grab/Run Packetbeat install script
$packetURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/scripts/install_packetbeat.ps1?token=AiUZH0wDQUGO9lYUyDFAm4QHulgRndDBks5a4S4zwA%3D%3D"
$packetOUT = "C:\scripts\install_packetbeat.ps1"
Start-BitsTransfer -Source $packetURL -Destination $packetOUT
Start-Job $packetOUT
# Grab/Run Winlogbeat install script
$winbeatURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/scripts/install_winlogbeat.ps1?token=AiUZHxk66PKkustrb1GsZRAGcXIjqufKks5a4S46wA%3D%3D"
$winbeatOUT = "C:\scripts\install_winlogbeat.ps1"
Start-BitsTransfer -Source $winbeatURL -Destination $winbeatOUT
Start-Job $winbeatOUT
# Grab/Run Filebeat install script
#$filebeatURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/scripts/install_filebeat.ps1?token=AiUZH61XZugJNVG3GQcuRHhkJbHTvR1Vks5a4S4ZwA%3D%3D"
#$filebeatOUT = "C:\scripts\install_filebeat.ps1"
#Start-BitsTransfer -Source $filebeatURL -Destination $filebeatOUT
#Start-Job $filebeatOUT
# Grab/Run Sysinternals/sysmon install script
$sysintURL = "https://raw.githubusercontent.com/cnnrshd/irsec_scripts/master/scripts/install_sysinternals.ps1?token=AiUZHwTTdqOVOZmn-IoxYz1scyQzH3qEks5a4S42wA%3D%3D"
$sysintOUT = "C:\scripts\install_sysinternals.ps1"
Start-BitsTransfer -Source $sysintURL -Destination $sysintOUT
Start-Job $sysintOUT
# Download kerberos reset script
$krbURL = "https://gallery.technet.microsoft.com/Reset-the-krbtgt-account-581a9e51/file/142338/1/New-CtmADKrbtgtKeys.zip"
$krbOUT = "C:\tempDL\New-CtmADKrbtgtKeys.zip"
Expand-Archive -LiteralPath "C:\tempDL\New-CtmADKrbtgtKeys.zip" -DestinationPath "C:\New-CtmADKrbtgtKeys"