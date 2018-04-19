# Check if BITS is installed
$bits = Get-WindowsFeature BITS
if ($bits.Installed) {
    # Install BITS
    Install-WindowsFeature -Name BITS -IncludeAllSubFeature
}
# At this point, BITS is installed
Start-Service BITS
# download and run the firewall script, make sure to set ExecutionPolicy to Unrestricted (only for that line)
Import-Module BitsTransfer
$firewallURL = ""
$firewallOUT = ""
Start-BitsTransfer -Source $firewallURL -Destination $firewallOUT
powershell.exe Set-ExecutionPolicy Unrestricted $firewallOUT
# Start download of config scripts
# Grab/Run Packetbeat install script
$packetURL = ""
$packetOUT = ""
Start-BitsTransfer -Source $packetURL -Destination $packetOUT
powershell.exe Set-ExecutionPolicy Unrestricted $packetOUT
# Grab/Run Winlogbeat install script
$winbeatURL = ""
$winbeatOUT = ""
Start-BitsTransfer -Source $winbeatURL -Destination $winbeatOUT
powershell.exe Set-ExecutionPolicy Unrestricted $winbeatOUT
# Grab/Run Filebeat install script
$filebeatURL = ""
$filebeatOUT = ""
Start-BitsTransfer -Source $filebeatURL -Destination $filebeatOUT
powershell.exe Set-ExecutionPolicy Unrestricted $filebeatOUT
# Grab/Run Sysinternals/sysmon install script
$sysintURL = ""
$sysintOUT = ""
Start-BitsTransfer -Source $sysintURL -Destination $sysintOUT
powershell.exe Set-ExecutionPolicy Unrestricted $sysintOUT
