@echo off
ping yourserver.com -n 2 | find "TTL=" > nul
if errorlevel 1 (
    echo Сервак лежит. Перезапуск службы...
    net stop "ИмяСервиса"
    net start "ИмяСервиса"
) else (
    echo Всё работает.
)
pause