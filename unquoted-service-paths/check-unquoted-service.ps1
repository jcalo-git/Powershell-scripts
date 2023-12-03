# Function to check for unquoted service paths
function CheckUnquotedServicePaths {
    # Get all services
    $services = Get-WmiObject -Class Win32_Service

    foreach ($service in $services) {
        $path = $service.PathName -replace '"', ''

        # Check if the path is unquoted
        if ($path -notlike 'C:\*' -and $path -notlike 'D:\*' -and $path -notlike 'E:\*' -and $path -notlike 'F:\*') {
            Write-Host "Unquoted path found for service $($service.DisplayName) - $($service.Name)"
            Write-Host "Path: $path"
        }
    }
}

# Run the function
CheckUnquotedServicePaths

