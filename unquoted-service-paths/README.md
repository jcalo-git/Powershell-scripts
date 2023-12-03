# Unquoted Service Paths

This directory contains two PowerShell scripts to handle unquoted service paths.

1. `remediate-unquoted-service.ps1`: This script checks and remediates unquoted service paths. It retrieves all services using the `Get-WmiObject` command and iterates over each service, replacing any unquoted paths.

2. `check-unquoted-service.ps1`: This script checks for unquoted service paths. It retrieves all services using the `Get-WmiObject` command and iterates over each service, replacing any unquoted paths.

Please ensure you have the necessary permissions to run these scripts on your system.
