@echo off

set download_url=https://github.com/sumo43/gear/releases/download/0.1.3windows/gearcli.exe
set destination_dir=%USERPROFILE%\gearcli

rem Create the destination directory if it doesn't exist
if not exist "%destination_dir%" (
    mkdir "%destination_dir%"
    echo Created %destination_dir% directory
) else (
    echo %destination_dir% directory already exists
)

rem Download the gearcli binary
echo Downloading gearcli binary...
powershell -Command "Invoke-WebRequest -Uri '%download_url%' -OutFile '%destination_dir%\gearcli.exe'"

rem Add the destination directory to PATH if not already present
echo Checking PATH...
for /F "skip=2 tokens=1,2*" %%A in ('%SystemRoot%\System32\reg.exe query "HKCU\Environment" /v "Path" 2^>nul') do if "%%A"=="Path" set "UserPath=%%C"
if "%UserPath:gearcli=%" equ "%UserPath%" (
    echo Adding %destination_dir% to PATH...
    setx PATH "%UserPath%;%destination_dir%"
) else (
    echo %destination_dir% is already in PATH
)

echo Installation completed successfully!
