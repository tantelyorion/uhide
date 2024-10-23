@echo off
rem Bloquer les clés USB
reg add "HKLM\System\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d "4" /f
rem Message d'avertissement
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoUSBDevices" /t REG_DWORD /d "1" /f
rem Redémarrer l'explorateur Windows
taskkill /f /im explorer.exe
start explorer.exe

@echo on
rem Message de confirmation
echo Les clés USB sont désormais bloquées sur cet ordinateur.
echo Veuillez redémarrer votre ordinateur pour que les modifications prennent effet.