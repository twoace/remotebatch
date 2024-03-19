@echo off
setlocal

rem Verzögerungszeit in Sekunden
set "timeout_duration=30"

rem Definiere den Pfad zum gemeinsamen Netzwerkordner
set "filepath=\\Server\SharedFolder\logged_in_users.txt"

:start
cls
rem Anzeigen der eingeloggten Benutzer außer dem aktuellen Benutzer
echo Liste der anderen eingeloggten Benutzer:
query user | findstr /V /R "^ *%USERNAME% *"
echo Aktive Admins:
type "%filepath%"

rem Menü
echo Bitte wählen Sie eine Option:
echo 1. Admin Login
echo 2. Admin Logout
echo 3. Skript Neustart
choice /C 123 /N /M "Ihre Auswahl: " /T %timeout_duration% /D 3

if errorlevel 3 goto restart
if errorlevel 2 goto logout
if errorlevel 1 goto login

:login
echo Admin Login
echo %USERNAME% >> "%filepath%"
goto restart

:logout
echo Admin Logout
findstr /V /C:%USERNAME% "%filepath%" > temp.txt
move /Y temp.txt "%filepath%"
goto restart

:restart
timeout /T 2 >nul
goto start
