@echo off
wmic path CIM_LogicalDevice where "Description like 'USB%'" get /value > usb_list.txt
echo Список сохранён в usb_list.txt
pause
