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
echo [6] 选择默认模型
echo [0] 退出
echo.
if defined MODEL_ARG (
    echo 当前模型设置: %MODEL_ARG:~8%
    echo.
)
set /p choice=请输入选项 (0-6): 

if "%choice%"=="1" goto gui
if "%choice%"=="2" goto headless
if "%choice%"=="3" goto normal
if "%choice%"=="4" goto debug
if "%choice%"=="5" goto virtual
if "%choice%"=="6" goto select_model
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
poetry run python launch_camoufox.py --headless %MODEL_ARG%
goto end

:normal
echo.
echo 正在启动普通模式...
poetry run python launch_camoufox.py %MODEL_ARG%
goto end

:debug
echo.
echo 正在启动调试模式...
poetry run python launch_camoufox.py --debug %MODEL_ARG%
goto end

:virtual
echo.
echo 正在启动虚拟显示模式...
poetry run python launch_camoufox.py --virtual-display %MODEL_ARG%
goto end

:select_model
cls
echo ========================================
echo          选择默认 AI 模型
echo ========================================
echo.
echo 请选择要使用的模型：
echo.
echo [1] Gemini 2.0 Flash Exp (默认, 快速)
echo [2] Gemini 2.5 Flash (新版, 更智能)
echo [3] Gemini 2.5 Pro (最强, 推理能力强)
echo [4] Gemini 1.5 Pro (稳定版)
echo [5] Gemini 1.5 Flash (轻量快速)
echo [0] 返回主菜单
echo.
if defined MODEL_ARG (
    echo 当前设置: %MODEL_ARG:~8%
    echo.
)
set /p model_choice=请输入选项 (0-5): 

if "%model_choice%"=="1" set MODEL_ARG=--model gemini-2.0-flash-exp
if "%model_choice%"=="2" set MODEL_ARG=--model gemini-2.5-flash
if "%model_choice%"=="3" set MODEL_ARG=--model gemini-2.5-pro
if "%model_choice%"=="4" set MODEL_ARG=--model gemini-1.5-pro
if "%model_choice%"=="5" set MODEL_ARG=--model gemini-1.5-flash
if "%model_choice%"=="0" goto menu

if not defined MODEL_ARG (
    echo.
    echo 无效选项，请重新选择！
    timeout /t 2 >nul
    goto select_model
)

echo.
echo 模型已设置！现在请选择运行模式...
timeout /t 2 >nul
goto menu

:end
echo.
pause
