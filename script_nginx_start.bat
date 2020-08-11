@echo off
cd .\tools\nginx

if not exist .\logs (
    mkdir .\logs
)

if not exist .\temp (
    mkdir .\temp
)

..\RunHiddenConsole.exe .\nginx.exe

cd ..\..
