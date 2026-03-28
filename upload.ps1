#!/usr/bin/env pwsh
# GitHub 一键上传脚本 (使用已登陆账号)

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  GitHub 一键上传脚本" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 输入 GitHub 用户名
$username = Read-Host "请输入你的 GitHub 用户名 (例如: john-doe)"

if (-not $username) {
    Write-Host "[错误] 用户名不能为空" -ForegroundColor Red
    exit 1
}

$repoName = "network-device-manager"
$repoUrl = "https://github.com/$username/$repoName.git"

Write-Host ""
Write-Host "配置信息:" -ForegroundColor Yellow
Write-Host "  GitHub 用户名: $username"
Write-Host "  仓库名称: $repoName"
Write-Host "  仓库 URL: $repoUrl"
Write-Host ""

# 确认信息
$confirm = Read-Host "确认是否继续？(y/n)"
if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "已取消" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "[步骤1] 检查 GitHub 仓库..." -ForegroundColor Cyan

# 检查仓库是否存在
$repoExists = $false
try {
    $response = Invoke-WebRequest -Uri "https://api.github.com/repos/$username/$repoName" -UseBasicParsing -ErrorAction SilentlyContinue
    if ($response.StatusCode -eq 200) {
        $repoExists = $true
        Write-Host "[✓] 仓库已存在" -ForegroundColor Green
    }
} catch {
    Write-Host "[i] 仓库不存在，需要创建" -ForegroundColor Yellow
}

if (-not $repoExists) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "  需要创建 GitHub 仓库" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "请按以下步骤创建:" -ForegroundColor Cyan
    Write-Host "  1. 打开浏览器访问: https://github.com/new"
    Write-Host "  2. 填写以下信息:"
    Write-Host "     - Repository name: $repoName"
    Write-Host "     - Description: Enterprise-grade network device management tool"
    Write-Host "     - 选择 Public (公开)"
    Write-Host "     - 不要选择 'Initialize this repository with'"
    Write-Host "  3. 点击 'Create repository'"
    Write-Host "  4. 完成后按 Enter 继续..."
    Write-Host ""
    
    $createUrl = "https://github.com/new"
    Write-Host "自动打开浏览器..." -ForegroundColor Yellow
    Start-Process $createUrl
    
    Read-Host "仓库创建完成后按 Enter 继续"
    
    $confirm2 = Read-Host "确认已创建仓库？(y/n)"
    if ($confirm2 -ne "y" -and $confirm2 -ne "Y") {
        Write-Host "已取消" -ForegroundColor Yellow
        exit 0
    }
}

Write-Host ""
Write-Host "[步骤2] 配置 Git 远程仓库..." -ForegroundColor Cyan

$gitDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $gitDir

# 移除旧的远程配置
git remote remove origin 2>$null

# 添加新的远程
git remote add origin $repoUrl
if ($LASTEXITCODE -eq 0) {
    Write-Host "[✓] 远程仓库已配置" -ForegroundColor Green
} else {
    Write-Host "[错误] 配置远程仓库失败" -ForegroundColor Red
    Pop-Location
    exit 1
}

Write-Host ""
Write-Host "[步骤3] 更新分支名称..." -ForegroundColor Cyan

git branch -M main 2>$null
Write-Host "[✓] 分支名称已更新为 main" -ForegroundColor Green

Write-Host ""
Write-Host "[步骤4] 推送到 GitHub..." -ForegroundColor Cyan
Write-Host ""

# 推送
git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host "  ✓ 上传成功！" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "你的项目已成功发布到 GitHub！" -ForegroundColor Green
    Write-Host ""
    Write-Host "项目链接:" -ForegroundColor Cyan
    Write-Host "  https://github.com/$username/$repoName" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "接下来建议:" -ForegroundColor Yellow
    Write-Host "  1. 打开项目页面: https://github.com/$username/$repoName/settings"
    Write-Host "  2. 在 Description 中添加: Enterprise-grade network device management tool"
    Write-Host "  3. 在 Topics 中添加: network, device, management, automation, ssh, python"
    Write-Host "  4. 在微信公众号'理想壹点时间'推广项目"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[错误] 推送失败" -ForegroundColor Red
    Write-Host ""
    Write-Host "可能的原因:" -ForegroundColor Yellow
    Write-Host "  1. 网络连接问题"
    Write-Host "  2. GitHub 仓库未创建"
    Write-Host "  3. 没有推送权限"
    Write-Host ""
    Write-Host "请检查以上问题后重试" -ForegroundColor Yellow
}

Pop-Location
