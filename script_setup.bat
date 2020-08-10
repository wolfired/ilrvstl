@call script_const.bat

if exist %DEV_ROOT%\dev.sln (
    exit 0
)

::
dotnet new sln -o %DEV_ROOT%

::
dotnet new classlib -o %PRJ_EMBED%
del %PRJ_EMBED%\*.cs
dotnet sln %DEV_ROOT% add %PRJ_EMBED%

rmdir /S /Q %PRJ_EMBED%\Dependencies\
xcopy /Y /E .\ILRuntime\Dependencies %PRJ_EMBED%\Dependencies\
xcopy /Y /E .\ILRuntime\Dependencies .\Assets\Plugins\

rmdir /S /Q %PRJ_EMBED%\ILRuntime\
xcopy /Y /E .\ILRuntime\ILRuntime %PRJ_EMBED%\ILRuntime\
rmdir /S /Q %PRJ_EMBED%\ILRuntime\Properties\
del %PRJ_EMBED%\ILRuntime\ILRuntime.csproj

:: 
dotnet new classlib -o %PRJ_CORE%
del %PRJ_CORE%\*.cs
dotnet add %PRJ_CORE% reference %PRJ_EMBED%
dotnet sln %DEV_ROOT% add %PRJ_CORE%

::
dotnet new classlib -o %PRJ_EDITOR%
del %PRJ_EDITOR%\*.cs
dotnet add %PRJ_EDITOR% reference %PRJ_EMBED%
dotnet sln %DEV_ROOT% add %PRJ_EDITOR%
