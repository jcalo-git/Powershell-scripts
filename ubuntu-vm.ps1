function New-UbuntuVM {
    param(
        [string]$Name = "ubuntu-1",
        [string]$Switch = "Default Switch",
        [int]$MemoryGB = 4,
        [int]$Cores = 2,
        [int]$DiskGB = 40
    )

    $path = "E:\VMs\$Name"
    New-Item -ItemType Directory -Force -Path $path | Out-Null

    New-VM -Name $Name -Generation 2 -MemoryStartupBytes (${MemoryGB}GB) -Path "C:\VMs" `
        -NewVHDPath "$path\$Name.vhdx" -NewVHDSizeBytes (${DiskGB}GB) -SwitchName $Switch | Out-Null

    Set-VM -Name $Name -ProcessorCount $Cores
    Start-VM -Name $Name
}
