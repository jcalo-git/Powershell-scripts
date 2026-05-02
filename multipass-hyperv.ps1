param(
    [string]$SwitchName = "multipass",
    [string]$HostIP = "192.168.199.1",
    [int]$PrefixLength = 24
)

$existing = Get-VMSwitch -Name $SwitchName -ErrorAction SilentlyContinue
if (-not $existing) {
    New-VMSwitch -Name $SwitchName -SwitchType Internal | Out-Null
}

$adapter = Get-NetAdapter | Where-Object { $_.Name -eq "vEthernet ($SwitchName)" }
if (-not $adapter) {
    throw "Could not find vEthernet adapter for switch '$SwitchName'"
}

$oldIPs = Get-NetIPAddress -InterfaceAlias $adapter.Name -AddressFamily IPv4 -ErrorAction SilentlyContinue |
    Where-Object { $_.IPAddress -ne $HostIP }
foreach ($ip in $oldIPs) {
    Remove-NetIPAddress -InterfaceAlias $adapter.Name -IPAddress $ip.IPAddress -Confirm:$false -ErrorAction SilentlyContinue
}

if (-not (Get-NetIPAddress -InterfaceAlias $adapter.Name -AddressFamily IPv4 -ErrorAction SilentlyContinue |
    Where-Object { $_.IPAddress -eq $HostIP })) {
    New-NetIPAddress -InterfaceAlias $adapter.Name -IPAddress $HostIP -PrefixLength $PrefixLength
}

Write-Host "Switch ready: $SwitchName"
Write-Host "Host adapter: $($adapter.Name) -> $HostIP/$PrefixLength"
