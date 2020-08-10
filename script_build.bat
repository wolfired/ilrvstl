@call script_const.bat

dotnet build -o %BIN_ROOT% %DEV_ROOT% -c Release
xcopy /Y %BIN_ROOT%\editor.dll .\Assets\Editor\Plugins\
xcopy /Y %BIN_ROOT%\editor.pdb .\Assets\Editor\Plugins\
xcopy /Y %BIN_ROOT%\embed.dll .\Assets\Plugins\
xcopy /Y %BIN_ROOT%\embed.pdb .\Assets\Plugins\
