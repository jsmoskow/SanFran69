$allowedInboundRules = @(
    @{ Name = "AllowVaultDNS"; Hostname = "Vault"; Port = 53; Protocol = "UDP"; Service = "DNS" }
    @{ Name = "AllowVaultLDAP"; Hostname = "Vault"; Port = 389; Protocol = "TCP"; Service = "LDAP" }
    @{ Name = "AllowOfficeHTTPS"; Hostname = "Office"; Port = 443; Protocol = "TCP"; Service = "HTTPS" }
    @{ Name = "AllowTellerWinRM"; Hostname = "Teller"; Port = 5985; Protocol = "TCP"; Service = "WinRM" }
    @{ Name = "AllowATMSSH"; Hostname = "ATM"; Port = 22; Protocol = "TCP"; Service = "SSH" }
    @{ Name = "AllowLobbyService"; Hostname = "Lobby"; Port = 8006; Protocol = "TCP"; Service = "Proxmox Service" }
    @{ Name = "AllowCashroomICMP"; Hostname = "Cashroom"; Protocol = "ICMP"; Service = "ICMP" }
    @{ Name = "AllowLockboxFTP"; Hostname = "Lockbox"; Port = 21; Protocol = "TCP"; Service = "FTP" }
    @{ Name = "AllowSafeTelnet"; Hostname = "Safe"; Port = 23; Protocol = "TCP"; Service = "Telnet" }
)

# DataDog IPs
$ipAddresses = @(
    "107.21.25.247", "108.137.133.223", "108.137.188.57", "13.114.211.96", "13.115.46.213",
    "13.126.169.175", "13.208.126.217", "13.208.133.55", "13.208.142.17", "13.208.255.200",
    "13.209.118.42", "13.209.230.111", "13.234.54.8", "13.236.246.161", "13.238.14.57",
    "13.244.188.203", "13.244.85.86", "13.245.194.43", "13.245.200.254", "13.246.172.210",
    "13.247.164.9", "13.48.150.244", "13.48.239.118", "13.48.254.37", "13.54.169.48",
    "15.152.238.192", "15.161.86.71", "15.165.240.116", "15.168.188.85", "15.184.139.182",
    "15.185.189.82", "15.188.202.64", "15.188.240.172", "15.188.243.248", "157.241.36.106",
    "157.241.93.102", "16.162.136.62", "16.163.153.45", "16.24.38.13", "16.24.60.114",
    "18.102.80.189", "18.130.113.168", "18.139.52.173", "18.163.21.55"
)


Get-NetFirewallRule -Direction Outbound | Remove-NetFirewallRule -ErrorAction SilentlyContinue
New-NetFirewallRule -DisplayName "BlockAllOutbound" -Direction Outbound -Action Block -Enabled True


Get-NetFirewallRule -Direction Inbound | Remove-NetFirewallRule -ErrorAction SilentlyContinue
New-NetFirewallRule -DisplayName "BlockAllInbound" -Direction Inbound -Action Block -Enabled True


foreach ($rule in $allowedInboundRules) {
    $hostname = $rule.Hostname
    $protocol = $rule.Protocol
    $ruleName = $rule.Name
    $service = $rule.Service

    # Resolve hostname to IP (skipping for ICMP)
    if ($protocol -ne "ICMP") {
        $hostEntry = Resolve-DnsName -Name $hostname -ErrorAction SilentlyContinue
        if ($hostEntry) {
            $ipAddress = $hostEntry.IPAddress
        } else {
            Write-Output "WARNING: Could not resolve hostname: $hostname. Skipping..."
            continue
        }
    } else {
        $ipAddress = "Any"  # ICMP does not need a specific IP
    }

    Write-Output "Adding inbound rule for $hostname ($ipAddress) - $service..."

    # Remove existing rule if exists
    Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue | Remove-NetFirewallRule

    # Create new inbound rule
    if ($protocol -eq "ICMP") {
        New-NetFirewallRule -DisplayName $ruleName `
                            -Direction Inbound `
                            -Protocol ICMPv4 `
                            -Action Allow `
                            -Enabled True
    } else {
        New-NetFirewallRule -DisplayName $ruleName `
                            -Direction Inbound `
                            -LocalPort $rule.Port `
                            -Protocol $protocol `
                            -RemoteAddress $ipAddress `
                            -Action Allow `
                            -Enabled True
    }

    Write-Output "Rule added: $ruleName - Allow $hostname ($service) on port $($rule.Port)/$protocol"
}


foreach ($ip in $ipAddresses) {
    # Allow TCP Traffic
    New-NetFirewallRule -DisplayName "Allow TCP to $ip" -Direction Outbound -Protocol TCP -RemoteAddress $ip -Action Allow -Enabled True

    # Allow UDP Traffic
    New-NetFirewallRule -DisplayName "Allow UDP to $ip" -Direction Outbound -Protocol UDP -RemoteAddress $ip -Action Allow -Enabled True
}

Write-Output "Outgoing traffic to specified IP addresses has been allowed."
Write-Output "Firewall rules applied."
