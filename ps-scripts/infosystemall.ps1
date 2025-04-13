$timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$outputPath = "$env:USERPROFILE\Desktop\System_Report_$timestamp.txt"

"=== SYSTEM INFORMATION REPORT ($timestamp) ===" | Out-File $outputPath -Encoding UTF8

"\n--- ОС и базовая информация ---" | Out-File $outputPath -Append
Get-ComputerInfo | Select-Object CsName, WindowsProductName, OsArchitecture, WindowsVersion, OsBuildNumber, BiosVersion, CsManufacturer, CsModel | Format-List | Out-File $outputPath -Append

"\n--- Аптайм системы ---" | Out-File $outputPath -Append
(New-TimeSpan -Start (gcim Win32_OperatingSystem).LastBootUpTime -End (Get-Date)) | Out-File $outputPath -Append


"\n--- Локальные пользователи ---" | Out-File $outputPath -Append
Get-LocalUser | Select-Object Name, Enabled, LastLogon | Out-File $outputPath -Append

"\n--- Группы и участники ---" | Out-File $outputPath -Append
Get-LocalGroup | ForEach-Object {
    "$($_.Name):" | Out-File $outputPath -Append
    Get-LocalGroupMember $_.Name | Select-Object Name, ObjectClass | Format-Table | Out-File $outputPath -Append
}

"\n--- Сетевые адаптеры и IP ---" | Out-File $outputPath -Append
Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4'} | Format-Table InterfaceAlias,IPAddress,PrefixLength | Out-File $outputPath -Append

"\n--- DNS ---" | Out-File $outputPath -Append
Get-DnsClientServerAddress | Format-Table | Out-File $outputPath -Append

"\n--- Установленные приложения ---" | Out-File $outputPath -Append
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | \
    Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Sort-Object DisplayName | Out-File $outputPath -Append

"\n--- Активные процессы ---" | Out-File $outputPath -Append
Get-Process | Sort-Object CPU -Descending | Select-Object -First 15 | Out-File $outputPath -Append

"\n--- Диски и использование ---" | Out-File $outputPath -Append
Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free, @{Name='Used(%)';Expression={"{0:N2}" -f ($_.Used / ($_.Used + $_.Free) * 100)}} | Out-File $outputPath -Append

"\n--- Службы (авто и не запущены) ---" | Out-File $outputPath -Append
Get-Service | Where-Object {$_.StartType -eq 'Automatic' -and $_.Status -ne 'Running'} | Format-Table Name, Status, StartType | Out-File $outputPath -Append

"\n[✔] Отчёт сохранён: $outputPath"
Start-Process notepad.exe $outputPath
