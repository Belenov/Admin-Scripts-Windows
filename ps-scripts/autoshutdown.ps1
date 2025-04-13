$lastInput = [Environment]::TickCount
while ($true) {
    $idle = [Environment]::TickCount - $lastInput
    if ($idle -gt 600000) {
        Stop-Computer
    }
    Start-Sleep -Seconds 60
}