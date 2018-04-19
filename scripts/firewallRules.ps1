# Allow BITS in/out on HTTP
New-NetFirewallRule -DisplayName ALLOWINBOUND80TCPBITS -Protocol TCP -LocalPort 80 -Service BITS -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWOUTBOUND80TCPBITS -Protocol TCP -LocalPort 80 -Service BITS -Action Allow -Enabled True -Direction Outbound 
New-NetFirewallRule -DisplayName ALLOWINBOUNDTCPBITS -Protocol TCP -RemotePort 80 -Service BITS -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWOUTBOUNDTCPBITS -Protocol TCP -RemotePort 80 -Service BITS -Action Allow -Enabled True -Direction Outbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND88UDPlsass.exeKdc -Program C:\Windows\System32\lsass.exe  -Protocol UDP -LocalPort 88 -Service Kdc -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND135UDPlsass.exeNTDS -Program C:\Windows\System32\lsass.exe  -Protocol UDP -LocalPort 135 -Service NTDS -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND135TCPlsass.exeNTDS -Program C:\Windows\System32\lsass.exe  -Protocol TCP -LocalPort 135 -Service NTDS -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND139TCPntfrs.exeNtFrs -Program C:\Windows\system32\ntfrs.exe  -Protocol TCP -LocalPort 139 -Service NtFrs -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND138UDPntfrs.exeNtFrs -Program C:\Windows\system32\ntfrs.exe  -Protocol UDP -LocalPort 138 -Service NtFrs -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND389UDPlsass.exeLDAP -Program C:\Windows\System32\lsass.exe  -Protocol UDP -LocalPort 389 -Service LDAP -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND445UDPntfrs.exeNtFrs -Program C:\Windows\System32\ntfrs.exe  -Protocol UDP -LocalPort 445 -Service NtFrs -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND445TCPntfrs.exeNtFrs  -Program C:\Windows\System32\ntfrs.exe  -Protocol TCP -LocalPort 445 -Service NtFrs  -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND464TCPlsass.exe -Program C:\Windows\System32\lsass.exe  -Protocol TCP -LocalPort 464 -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND464UDPlsass.exe -Program C:\Windows\System32\lsass.exe  -Protocol UDP -LocalPort 464 -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUNDTCP -Protocol TCP -LocalPort 3268,3269 -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND53TCPdns.exe -Program C:\Windows\System32\dns.exe  -Protocol TCP -LocalPort 53 -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWOUTBOUND53TCPdns.exe -Program C:\Windows\System32\dns.exe  -Protocol TCP -LocalPort 53 -Action Allow -Enabled True -Direction Outbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND53UDPdns.exe -Program C:\Windows\System32\dns.exe  -Protocol UDP -LocalPort 53 -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWOUTBOUND53UDPdns.exe -Program C:\Windows\System32\dns.exe  -Protocol UDP -LocalPort 53 -Action Allow -Enabled True -Direction Outbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND53UDPsvchost.exeDnscache  -Program C:\Windows\system32\svchost.exe  -Protocol UDP -LocalPort 53 -Service Dnscache  -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND53TCPsvchost.exeDnscache  -Program C:\Windows\system32\svchost.exe  -Protocol TCP -LocalPort 53 -Service Dnscache  -Action Allow -Enabled True -Direction Inbound 
# Allow beats in/out on 5044 
New-NetFirewallRule -DisplayName ALLOWOUTBOUNDTCPpacketbeat  -Protocol TCP -RemotePort 5044 -Service packetbeat  -Action Allow -Enabled True -Direction Outbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND5044TCPpacketbeat  -Protocol TCP -LocalPort 5044 -Service packetbeat  -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWOUTBOUNDTCPwinlogbeat  -Protocol TCP -RemotePort 5044 -Service winlogbeat  -Action Allow -Enabled True -Direction Outbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND5044TCPwinlogbeat  -Protocol TCP -LocalPort 5044 -Service winlogbeat  -Action Allow -Enabled True -Direction Inbound 
New-NetFirewallRule -DisplayName ALLOWOUTBOUNDTCPfilebeat  -Protocol TCP -RemotePort 5044 -Service filebeat  -Action Allow -Enabled True -Direction Outbound 
New-NetFirewallRule -DisplayName ALLOWINBOUND5044TCPfilebeat  -Protocol TCP -LocalPort 5044 -Service filebeat  -Action Allow -Enabled True -Direction Inbound 