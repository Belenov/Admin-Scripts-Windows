Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location | Out-File "$env:USERPROFILE\Desktop\startup_backup.txt"
Get-CimInstance Win32_StartupCommand | ForEach-Object { $_.Delete() }
