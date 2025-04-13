Get-Process | Where-Object { $_.WorkingSet -gt 100MB } | Sort-Object WorkingSet -Descending | Select-Object Name, ID, @{Name="Memory(MB)";Expression={"{0:N2}" -f ($_.WorkingSet / 1MB)}}
