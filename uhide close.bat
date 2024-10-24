@echo off
rem =============================================
rem Projet : Uhide
rem Description : Script pour bloquer et débloquer les ports USB avec protection par mot de passe.
rem Éditeur : Tantely Orion
rem =============================================

rem Définir le chemin du fichier pour stocker l'identifiant et le mot de passe
set "credentialsFile=%userprofile%\usb_security.txt"

rem Vérifier si les identifiants existent déjà
if exist "%credentialsFile%" (
    echo Les identifiants existent déjà. Utilisez ces identifiants pour déverrouiller les clés USB.
) else (
    rem Si aucun identifiant n'existe, demander à l'utilisateur de créer un identifiant et un mot de passe
    echo === Configuration de sécurité USB ===
    set /p username="Entrez un identifiant : "
    set /p password="Entrez un mot de passe : "

    rem Sauvegarder l'identifiant et le mot de passe dans un fichier (fichier texte, non sécurisé)
    echo %username% > "%credentialsFile%"
    echo %password% >> "%credentialsFile%"

    echo Identifiant et mot de passe créés avec succès.
)

rem === Bloquer les clés USB ===
rem Modifier la clé de registre pour désactiver les ports USB
reg add "HKLM\System\CurrentControlSet\Services\USBSTOR" /v "Start" /t REG_DWORD /d "4" /f

rem Ajouter une restriction supplémentaire pour les périphériques USB
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoUSBDevices" /t REG_DWORD /d "1" /f

rem Redémarrer l'explorateur Windows pour appliquer les modifications
taskkill /f /im explorer.exe
start explorer.exe

@echo on
rem === Confirmation du blocage ===
echo Les clés USB sont désormais bloquées sur cet ordinateur.
echo Veuillez redémarrer votre ordinateur pour que les modifications prennent effet.
pause
