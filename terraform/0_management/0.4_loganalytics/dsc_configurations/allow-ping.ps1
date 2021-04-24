Configuration Allow_Ping {
    Import-DSCResource -ModuleName NetworkingDsc

    Node localhost
    {
        Firewall AddFirewallRule
        {
            Name                  = 'PingFirewallRule'
            DisplayName           = 'Allow ICMP Ping'
            Group                 = 'Building Azure Plaform Firewall Rule Group'
            Ensure                = 'Present'
            Enabled               = 'True'
            Profile               = ('Domain', 'Private')
            Direction             = 'Inbound'
            RemotePort            = ('*', '*')
            LocalPort             = ('*', '*')
            Protocol              = 'icmpv4:8'
            Description           = 'Allow Ping requests from internal networks'
        }
    }
 }
 Allow_Ping
