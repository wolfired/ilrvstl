# ilrvstl

## Clone and Setup and Build

```bat

git clone https://github.com/wolfired/ilrvstl.git

cd ilrvstl

git submodule update --init --recursive

script_setup.bat

:: 参考 dev/*/*.csproj.bak 调整生成的 dotnet 工程文件

:: 使用Unity3D打开一次项目

script_build.bat

:: start nginx
script_nginx_star.bat

:: open Main scene, add Main.cs in the embed.dll to the Main Camera

:: Good Luck!!

```
