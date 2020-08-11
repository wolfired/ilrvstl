@call script_const.bat

dotnet build -o %BIN_ROOT% %DEV_ROOT% -c Release

if exist %BIN_ROOT%\editor.dll (
    xcopy /Y %BIN_ROOT%\editor.dll .\Assets\Editor\Plugins\
    xcopy /Y %BIN_ROOT%\editor.pdb .\Assets\Editor\Plugins\
)

if exist %BIN_ROOT%\embed.dll (
    xcopy /Y %BIN_ROOT%\embed.dll .\Assets\Plugins\
    xcopy /Y %BIN_ROOT%\embed.pdb .\Assets\Plugins\
)
