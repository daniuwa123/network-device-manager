@echo off
chcp 65001 >nul
REM GitHub 自动发布脚本

echo ================================================
echo   网络设备管理工具 GitHub 发布脚本
echo ================================================
echo.

REM 配置信息 - 请修改以下内容
set GITHUB_USERNAME=your-github-username
set REPO_NAME=network-device-manager
set REPO_DESCRIPTION=Enterprise-grade network device management tool
set GITHUB_TOKEN=your-github-token

REM 如果尚未设置，提示用户输入
if "%GITHUB_USERNAME%"=="your-github-username" (
    echo.
    echo [错误] 请先配置此脚本：
    echo 1. 用记事本打开此文件
    echo 2. 修改以下变量：
    echo    - GITHUB_USERNAME: 你的GitHub用户名
    echo    - GITHUB_TOKEN: 你的GitHub Personal Access Token
    echo 3. 保存并重新运行
    echo.
    echo GitHub Token 获取方式：
    echo https://github.com/settings/tokens
    echo.
    pause
    exit /b 1
)

echo 配置信息：
echo - 用户名: %GITHUB_USERNAME%
echo - 仓库名: %REPO_NAME%
echo - 描述: %REPO_DESCRIPTION%
echo.

REM 检查 Git 是否安装
echo [检查] Git 是否已安装...
git --version >nul 2>&1
if errorlevel 1 (
    echo [错误] 未检测到 Git，请先安装：https://git-scm.com/
    pause
    exit /b 1
)
echo [成功] Git 已安装
echo.

REM 进入 github 文件夹
echo [步骤1] 进入项目目录...
cd /d "%~dp0"
if not exist "README.md" (
    echo [错误] 无法找到 README.md，脚本位置可能不正确
    pause
    exit /b 1
)
echo [成功] 进入目录：%cd%
echo.

REM 初始化 Git 仓库
echo [步骤2] 初始化 Git 仓库...
if exist ".git" (
    echo [信息] Git 仓库已存在，跳过初始化
) else (
    git init
    if errorlevel 1 (
        echo [错误] Git 初始化失败
        pause
        exit /b 1
    )
    echo [成功] Git 仓库初始化完成
)
echo.

REM 配置 Git 用户信息
echo [步骤3] 配置 Git 用户信息...
git config user.name "%GITHUB_USERNAME%" 2>nul
git config user.email "%GITHUB_USERNAME%@users.noreply.github.com" 2>nul
echo [成功] Git 用户信息已配置
echo.

REM 添加所有文件
echo [步骤4] 添加所有文件到 Git...
git add .
echo [成功] 所有文件已添加
echo.

REM 创建初始 commit
echo [步骤5] 创建初始提交...
git commit -m "Initial commit: Add complete GitHub documentation" 2>nul
if errorlevel 1 (
    echo [信息] 没有新文件需要提交（可能已提交过）
) else (
    echo [成功] 初始提交已创建
)
echo.

REM 添加远程仓库
echo [步骤6] 配置远程仓库...
git remote remove origin 2>nul
git remote add origin https://github.com/%GITHUB_USERNAME%/%REPO_NAME%.git
echo [成功] 远程仓库已配置
echo.

REM 准备上传
echo ================================================
echo   准备上传到 GitHub
echo ================================================
echo.
echo 接下来需要在浏览器中创建 GitHub 仓库：
echo.
echo 步骤：
echo 1. 打开：https://github.com/new
echo 2. 填写以下信息：
echo    - Repository name: %REPO_NAME%
echo    - Description: %REPO_DESCRIPTION%
echo    - Visibility: Public（公开）
echo    - 不要初始化任何文件（README/License/gitignore）
echo 3. 点击 "Create repository"
echo.
echo 仓库创建完成后，此脚本会自动上传文件...
echo.
pause

REM 推送到 GitHub
echo [步骤7] 推送文件到 GitHub...
echo.
git branch -M main
git push -u origin main

if errorlevel 1 (
    echo.
    echo [错误] 推送失败，可能是因为：
    echo 1. GitHub 仓库尚未创建
    echo 2. GitHub Token 或凭证不正确
    echo 3. 仓库已存在文件冲突
    echo.
    echo 手动推送命令：
    echo git push -u origin main
    echo.
    pause
    exit /b 1
)

echo.
echo ================================================
echo   🎉 发布完成！
echo ================================================
echo.
echo 你的项目已成功发布到 GitHub！
echo.
echo 查看项目：
echo https://github.com/%GITHUB_USERNAME%/%REPO_NAME%
echo.
echo 接下来建议：
echo 1. 添加项目 Logo 和微信二维码到 images/ 目录
echo 2. 在 GitHub 仓库设置中添加：
echo    - Description: %REPO_DESCRIPTION%
echo    - Topics: network, device, management, automation, ssh, python
echo    - Homepage: （如果有网站）
echo 3. 在微信公众号"理想壹点时间"推广此项目
echo.
echo 更多信息见：
echo d:\py开发\网络维护\github\FINAL_CHECKLIST.md
echo.
pause
