@call script_const.bat

if exist %DEV_ROOT%\dev.sln (
    exit 0
)

:: dev solution
dotnet new sln -o %DEV_ROOT%

:: exter project
dotnet new classlib -o %PRJ_EXTER%
del %PRJ_EXTER%\*.cs
if exist %U3D_ROOT% (
    xcopy /Y /R %PRJ_EXTER%\exter.csproj.bak %PRJ_EXTER%\exter.csproj
)
dotnet sln %DEV_ROOT% add %PRJ_EXTER%

rmdir /S /Q %PRJ_EXTER%\Dependencies\
xcopy /Y /E .\ILRuntime\Dependencies %PRJ_EXTER%\Dependencies\
xcopy /Y /E .\ILRuntime\Dependencies .\Assets\Plugins\

rmdir /S /Q %PRJ_EXTER%\ILRuntime\
xcopy /Y /E .\ILRuntime\ILRuntime %PRJ_EXTER%\ILRuntime\
rmdir /S /Q %PRJ_EXTER%\ILRuntime\bin\
rmdir /S /Q %PRJ_EXTER%\ILRuntime\obj\
rmdir /S /Q %PRJ_EXTER%\ILRuntime\Properties\
del %PRJ_EXTER%\ILRuntime\ILRuntime.csproj

:: embed project
dotnet new classlib -o %PRJ_EMBED%
del %PRJ_EMBED%\*.cs
if exist %U3D_ROOT% (
    xcopy /Y /R %PRJ_EMBED%\embed.csproj.bak %PRJ_EMBED%\embed.csproj
)
dotnet add %PRJ_EMBED% reference %PRJ_EXTER%
dotnet sln %DEV_ROOT% add %PRJ_EMBED%

:: core project
dotnet new classlib -o %PRJ_CORE%
del %PRJ_CORE%\*.cs
if exist %U3D_ROOT% (
    xcopy /Y /R %PRJ_CORE%\core.csproj.bak %PRJ_CORE%\core.csproj
)
dotnet add %PRJ_CORE% reference %PRJ_EMBED%
dotnet sln %DEV_ROOT% add %PRJ_CORE%

:: editor project
dotnet new classlib -o %PRJ_EDITOR%
del %PRJ_EDITOR%\*.cs
if exist %U3D_ROOT% (
    xcopy /Y /R %PRJ_EDITOR%\editor.csproj.bak %PRJ_EDITOR%\editor.csproj
)
dotnet add %PRJ_EDITOR% reference %PRJ_EXTER%
dotnet sln %DEV_ROOT% add %PRJ_EDITOR%

:: setup tolua
xcopy /Y /E %TOLUA_ROOT%\Assets .\Assets\
xcopy /Y %TOLUA_ROOT%\Luajit .\Luajit\
xcopy /Y %TOLUA_ROOT%\Luajit64 .\Luajit64\
