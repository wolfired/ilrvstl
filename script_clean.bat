@call script_const.bat

if not exist %DEV_ROOT%\dev.sln (
    exit 0
)

if exist %BIN_ROOT% (
    rmdir /S /Q %BIN_ROOT%
)

if exist %PRJ_EMBED%\bin (
    rmdir /S /Q %PRJ_EMBED%\bin
)

if exist %PRJ_EMBED%\obj (
    rmdir /S /Q %PRJ_EMBED%\obj
)

if exist %PRJ_EMBED%\*.csproj (
    del %PRJ_EMBED%\*.csproj
)

if exist %PRJ_CORE%\bin (
    rmdir /S /Q %PRJ_CORE%\bin
)

if exist %PRJ_CORE%\obj (
    rmdir /S /Q %PRJ_CORE%\obj
)

if exist %PRJ_CORE%\*.csproj (
    del %PRJ_CORE%\*.csproj
)

if exist %PRJ_EDITOR%\bin (
    rmdir /S /Q %PRJ_EDITOR%\bin
)

if exist %PRJ_EDITOR%\obj (
    rmdir /S /Q %PRJ_EDITOR%\obj
)

if exist %PRJ_EDITOR%\*.csproj (
    del %PRJ_EDITOR%\*.csproj
)

if exist %DEV_ROOT%\*.sln (
    del %DEV_ROOT%\*.sln
)

if exist .\Assets\Source (
    rmdir /S /Q .\Assets\Source
)

if exist .\Assets\ToLua (
    rmdir /S /Q .\Assets\ToLua
)

if exist .\Library (
    rmdir /S /Q .\Library
)

if exist .\Logs (
    rmdir /S /Q .\Logs
)

if exist .\Luajit (
    rmdir /S /Q .\Luajit
)

if exist .\Luajit64 (
    rmdir /S /Q .\Luajit64
)

if exist .\out (
    rmdir /S /Q .\out
)

if exist .\Temp (
    rmdir /S /Q .\Temp
)
