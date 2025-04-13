@echo off
echo Очистка мусора...
del /s /q %temp%\*
cleanmgr /sagerun:1
echo Готово.
pause
