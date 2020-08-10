@call script_const.bat

if not exist %DEV_ROOT%\dev.sln (
    exit 0
)

rmdir /S /Q %BIN_ROOT%

rmdir /S /Q %PRJ_EMBED%\bin
rmdir /S /Q %PRJ_EMBED%\obj
del %PRJ_EMBED%\*.csproj

rmdir /S /Q %PRJ_CORE%\bin
rmdir /S /Q %PRJ_CORE%\obj
del %PRJ_CORE%\*.csproj

rmdir /S /Q %PRJ_EDITOR%\bin
rmdir /S /Q %PRJ_EDITOR%\obj
del %PRJ_EDITOR%\*.csproj

del %DEV_ROOT%\*.sln
