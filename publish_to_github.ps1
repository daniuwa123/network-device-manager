# GitHub 自动发布脚本 (PowerShell 版本)
# 使用方法: 在 PowerShell 中运行此脚本

param(
    [string]$GithubUsername = "",
    [string]$GithubToken = "",
    [string]$RepoName = "network-device-manager",
    [string]$RepoDescription = "Enterprise-grade network device management tool"
)

# 颜色输出函数
function Write-Success { Write-Host "[✓] $args" -ForegroundColor Green }
function Write-Error { Write-Host "[✗] $args" -ForegroundColor Red }
function Write-Info { Write-Host "[i] $args" -ForegroundColor Cyan }
function Write-Warning { Write-Host "[!] $args" -ForegroundColor Yellow }

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  网络设备管理工具 - GitHub 自动发布脚本" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 检查是否提供了必要信息
if (-not $GithubUsername -or $GithubUsername -eq "") {
    Write-Error "缺少 GitHub 用户名"
    Write-Info "使用方法:"
    Write-Host "  .\publish_to_github.ps1 -GithubUsername 'your-username' -GithubToken 'your-token'"
    Write-Host ""
    Write-Warning "GitHub Token 获取方式:"
    Write-Host "  1. 访问 https://github.com/settings/tokens"
    Write-Host "  2. 点击 'Generate new token'"
    Write-Host "  3. 选择 'repo' 权限"
    Write-Host "  4. 复制 Token"
    Write-Host ""
    exit 1
}

if (-not $GithubToken -or $GithubToken -eq "") {
    Write-Error "缺少 GitHub Token"
    Write-Info "使用方法:"
    Write-Host "  .\publish_to_github.ps1 -GithubUsername '$GithubUsername' -GithubToken 'your-token'"
    exit 1
}

# 显示配置信息
Write-Info "配置信息:"
Write-Host "  GitHub 用户名: $GithubUsername"
Write-Host "  仓库名称: $RepoName"
Write-Host "  仓库描述: $RepoDescription"
Write-Host ""

# 检查 Git 安装
Write-Info "检查 Git 安装..."
$gitVersion = git --version 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Error "未检测到 Git，请先安装"
    Write-Host "  下载: https://git-scm.com/" -ForegroundColor Yellow
    exit 1
}
Write-Success "Git 已安装: $gitVersion"
Write-Host ""

# 进入 github 目录
Write-Info "进入项目目录..."
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Push-Location $scriptPath

if (-not (Test-Path "README.md")) {
    Write-Error "无法找到 README.md，脚本位置可能不正确"
    Write-Host "  当前位置: $(Get-Location)" -ForegroundColor Yellow
    exit 1
}
Write-Success "已进入目录: $(Get-Location)"
Write-Host ""

# 初始化 Git 仓库
Write-Info "步骤 1/7: 初始化 Git 仓库..."
if (Test-Path ".git") {
    Write-Warning "Git 仓库已存在，跳过初始化"
} else {
    git init | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Git 初始化失败"
        exit 1
    }
    Write-Success "Git 仓库初始化完成"
}
Write-Host ""

# 配置 Git 用户信息
Write-Info "步骤 2/7: 配置 Git 用户信息..."
git config user.name $GithubUsername 2>$null
git config user.email "$GithubUsername@users.noreply.github.com" 2>$null
Write-Success "Git 用户信息已配置"
Write-Host ""

# 配置 Git 凭证（仅限 Windows）
if ($PSVersionTable.Platform -eq "Win32NT" -or $PSVersionTable.OS -like "*Windows*") {
    Write-Info "步骤 3/7: 配置 GitHub 凭证..."
    
    # 创建临时凭证存储
    $credentialFile = "$env:USERPROFILE\.git-credentials"
    $credentialEntry = "https://${GithubUsername}:${GithubToken}@github.com"
    
    # 检查是否已存在
    if (Test-Path $credentialFile) {
        $existingContent = Get-Content $credentialFile
        if ($existingContent -like "*github.com*") {
            Write-Warning "GitHub 凭证已存在"
        } else {
            Add-Content $credentialFile $credentialEntry
            Write-Success "GitHub 凭证已添加"
        }
    } else {
        Add-Content $credentialFile $credentialEntry
        Write-Success "GitHub 凭证已创建"
    }
    
    # 配置凭证辅助工具
    git config --global credential.helper manager 2>$null
    Write-Success "凭证辅助工具已配置"
} else {
    Write-Info "步骤 3/7: 配置凭证辅助工具 (Linux/macOS)..."
    git config --global credential.helper store 2>$null
    Write-Success "凭证辅助工具已配置"
}
Write-Host ""

# 添加所有文件
Write-Info "步骤 4/7: 添加所有文件到 Git..."
git add . 2>$null
Write-Success "所有文件已添加"
Write-Host ""

# 创建初始 commit
Write-Info "步骤 5/7: 创建初始提交..."
git commit -m "Initial commit: Add complete GitHub documentation" 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Success "初始提交已创建"
} else {
    Write-Warning "没有新文件需要提交（可能已提交过）"
}
Write-Host ""

# 配置远程仓库
Write-Info "步骤 6/7: 配置远程仓库..."
git remote remove origin 2>$null
git remote add origin "https://github.com/$GithubUsername/$RepoName.git" 2>$null
Write-Success "远程仓库已配置"
Write-Host ""

# 检查远程仓库是否存在
Write-Info "步骤 7/7: 验证 GitHub 仓库..."
Write-Host ""
Write-Host "请确保已在 GitHub 上创建了仓库：" -ForegroundColor Yellow
Write-Host "  1. 打开: https://github.com/new" -ForegroundColor Yellow
Write-Host "  2. Repository name: $RepoName" -ForegroundColor Yellow
Write-Host "  3. Description: $RepoDescription" -ForegroundColor Yellow
Write-Host "  4. 选择 Public（公开）" -ForegroundColor Yellow
Write-Host "  5. 不要初始化任何文件" -ForegroundColor Yellow
Write-Host "  6. 点击 'Create repository'" -ForegroundColor Yellow
Write-Host ""
Write-Host "按 Enter 继续上传..." -ForegroundColor Cyan
Read-Host

# 确保主分支名称为 main
Write-Info "更新分支名称..."
git branch -M main 2>$null
Write-Success "分支名称已更新"

# 推送到 GitHub
Write-Info "推送文件到 GitHub..."
Write-Host ""

$pushed = $false
git push -u origin main 2>&1 | ForEach-Object {
    Write-Host $_
    if ($_ -like "*master -> main*" -or $_ -like "*done*") {
        $pushed = $true
    }
}

Write-Host ""

if ($LASTEXITCODE -ne 0) {
    Write-Error "推送失败"
    Write-Warning "可能原因："
    Write-Host "  1. GitHub 仓库尚未创建"
    Write-Host "  2. GitHub Token 或用户名不正确"
    Write-Host "  3. 网络连接问题"
    Write-Host ""
    Write-Host "手动推送命令:" -ForegroundColor Yellow
    Write-Host "  git push -u origin main" -ForegroundColor Yellow
    Write-Host ""
    Pop-Location
    exit 1
}

# 成功
Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "  ✓ 发布完成！" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
Write-Host ""
Write-Host "你的项目已成功发布到 GitHub！" -ForegroundColor Green
Write-Host ""
Write-Host "项目链接:" -ForegroundColor Cyan
Write-Host "  https://github.com/$GithubUsername/$RepoName" -ForegroundColor Cyan
Write-Host ""
Write-Host "接下来建议:" -ForegroundColor Yellow
Write-Host "  1. ✓ 添加项目 Logo 和微信二维码到 images/ 目录"
Write-Host "  2. ✓ 在 GitHub 仓库页面设置中填写："
Write-Host "      - Description: $RepoDescription"
Write-Host "      - Topics: network, device, management, automation, ssh, python"
Write-Host "      - Homepage URL（如果有网站）"
Write-Host "  3. ✓ 在微信公众号'理想壹点时间'推广此项目"
Write-Host "  4. ✓ 邀请用户反馈和贡献"
Write-Host ""

Pop-Location
