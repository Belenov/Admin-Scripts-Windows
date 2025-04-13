@echo off
netstat -ano > ports.txt
tasklist /fi "PID eq 1234" >> ports.txt
echo Результат в ports.txt
pause
