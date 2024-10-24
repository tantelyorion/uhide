




reg add "HKLM\System\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d "3" /f@echo off
rem =============================================
rem Projet : Uhide
rem Description : Script pour débloquer les ports USB avec protection par mot de passe.
rem Éditeur : Tantely Orion
rem =============================================

rem Définir le chemin du fichier contenant les identifiants
set "credentialsFile=%userprofile%\usb_security.txt"

rem Vérifier si les identifiants existent
if not exist "%credentialsFile%" (
    echo Aucun identifiant n'a été configuré. Impossible de déverrouiller les clés USB.
    pause
    exit
)

rem === Lecture des identifiants stockés ===
rem Récupérer l'identifiant et le mot de passe enregistrés
set /p storedUsername=< "%credentialsFile%"
set /p storedPassword=< "%credentialsFile%" skip=1

rem Demander l'identifiant et le mot de passe à l'utilisateur
echo === Déverrouillage de sécurité USB ===
set /p inputUsername="Entrez votre identifiant : "
set /p inputPassword="Entrez votre mot de passe : "

rem === Vérification des identifiants ===
if "%inputUsername%"=="%storedUsername%" if "%inputPassword%"=="%storedPassword%" (
    echo Identifiants corrects. Déverrouillage des clés USB...
    
    rem Débloquer les clés USB en modifiant la clé de registre
    reg add "HKLM\System\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d "3" /f
    
    rem Supprimer la restriction pour les périphériques USB
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoUSBDevices" /f
    
    rem Redémarrer l'explorateur Windows pour appliquer les modifications
    taskkill /f /im explorer.exe
    start explorer.exe
    
    echo Les clés USB sont désormais déverrouillées.
) else (
    echo Identifiant ou mot de passe incorrect. Déverrouillage échoué.
)

pause
