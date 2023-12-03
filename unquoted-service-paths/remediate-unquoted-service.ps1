# Function to check and remediate unquoted service paths
function CheckAndRemediateUnquotedServicePaths {
    # Get all services
    $services = Get-WmiObject -Class Win32_Service

    foreach ($service in $services) {
        $path = $service.PathName -replace '"', ''

        # Check if the path is unquoted
        if ($path -notlike 'C:\*' -and $path -notlike 'D:\*' -and $path -notlike 'E:\*' -and $path -notlike 'F:\*') {
            Write-Host "Unquoted path found for service $($service.DisplayName) - $($service.Name)"
            
            # Remediate by quoting the path
            $quotedPath = "`"$path`""
            sc.exe config $service.Name binPath= $quotedPath

            Write-Host "Path remediated for $($service.DisplayName)"
        }
    }
}

# Run the function
CheckAndRemediateUnquotedServicePaths

