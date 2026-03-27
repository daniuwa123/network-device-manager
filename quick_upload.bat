@echo off
chcp 65001 >nul

echo ================================================
echo   GitHub 快速上传脚本 (使用已登陆账号)
echo ================================================
echo.

REM 配置
set REPO_NAME=network-device-manager
set REPO_DESCRIPTION=Enterprise-grade network device management tool

echo 准备上传文件到 GitHub...
echo 仓库名称: %REPO_NAME%
echo.

REM 进入文件夹
cd /d "%~dp0"

REM 初始化 Git
echo [1] 初始化 Git 仓库...
if exist ".git" (
    echo Git 仓库已存在，跳过初始化
) else (
    git init
    echo 已初始化
)
echo.

REM 配置用户
echo [2] 配置 Git 用户...
git config user.name "GitHub User"
git config user.email "user@github.com"
echo 已配置
echo.

REM 添加文件
echo [3] 添加所有文件...
git add .
echo 已添加所有文件
echo.

REM 提交
echo [4] 创建提交...
git commit -m "Initial commit: Add complete GitHub documentation" 2>nul
if errorlevel 1 (
    echo 文件未改变（可能已提交）
) else (
    echo 已创建提交
)
echo.

REM 提示用户操作
echo ================================================
echo 下一步操作
echo ================================================
echo.
echo 1. 打开浏览器，访问: https://github.com/new
echo.
echo 2. 填写以下信息:
echo    - Repository name: %REPO_NAME%
echo    - Description: %REPO_DESCRIPTION%
echo    - 选择 Public (公开)
echo    - 不要初始化任何文件
echo.
echo 3. 点击 "Create repository"
echo.
echo 4. 创建完成后，将下面的命令复制到 PowerShell 执行:
echo.
echo    git remote add origin https://github.com/YOUR_USERNAME/%REPO_NAME%.git
echo    git branch -M main
echo    git push -u origin main
echo.
echo 注意: 将 YOUR_USERNAME 替换为你的 GitHub 用户名
echo.
pause
