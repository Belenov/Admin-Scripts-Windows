@echo off
setlocal
set targets=8.8.8.8 ya.ru google.com
for %%a in (%targets%) do (
    ping -n 2 %%a > nul
    if errorlevel 1 (
        echo %%a не отвечает >> log_ping.txt
    )
)
echo Проверка завершена
pause
