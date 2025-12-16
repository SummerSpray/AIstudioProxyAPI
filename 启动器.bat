@echo off
chcp 65001 >nul
cd /d "%~dp0AIstudioProxyAPI"

:menu
cls
echo ========================================
echo          Gemini3 启动器
echo ========================================
echo.
echo 请选择运行模式：
echo.
echo [1] GUI 启动器 (新手、可视化配置)
echo [2] 无头模式 (日常使用、服务器)
echo [3] 普通模式 (查看浏览器窗口)
echo [4] 调试模式 (首次认证、故障排查)
echo [5] 虚拟显示模式 (Linux 无 GUI 环境)
echo [0] 退出
echo.
set /p choice=请输入选项 (0-5): 

if "%choice%"=="1" goto gui
if "%choice%"=="2" goto headless
if "%choice%"=="3" goto normal
if "%choice%"=="4" goto debug
if "%choice%"=="5" goto virtual
if "%choice%"=="0" goto end
echo.
echo 无效选项，请重新选择！
timeout /t 2 >nul
goto menu

:gui
echo.
echo 正在启动 GUI 启动器...
poetry run python gui_launcher.py
goto end

:headless
echo.
echo 正在启动无头模式...
poetry run python launch_camoufox.py --headless
goto end

:normal
echo.
echo 正在启动普通模式...
poetry run python launch_camoufox.py
goto end

:debug
echo.
echo 正在启动调试模式...
poetry run python launch_camoufox.py --debug
goto end

:virtual
echo.
echo 正在启动虚拟显示模式...
poetry run python launch_camoufox.py --virtual-display
goto end

:end
echo.
pause

