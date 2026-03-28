# 为 daniuwa123 自动上传到 GitHub 的脚本

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  GitHub 仓库创建和上传" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

$username = "daniuwa123"
$repoName = "network-device-manager"

Write-Host "用户名: $username" -ForegroundColor Yellow
Write-Host "仓库名: $repoName"
Write-Host ""

# 第1步：打开浏览器创建仓库
Write-Host "[步骤1] 打开浏览器创建 GitHub 仓库..." -ForegroundColor Green
Write-Host ""
Write-Host "系统会打开浏览器，请按以下步骤操作:" -ForegroundColor Cyan
Write-Host "  1. 登录 GitHub（如果未登录）"
Write-Host "  2. 填写信息:"
Write-Host "     Repository name: $repoName"
Write-Host "     Description: Enterprise-grade network device management tool"
Write-Host "     Public: 选中"
Write-Host "     Initialize: 不要选择"
Write-Host "  3. 点击 'Create repository'"
Write-Host "  4. 完成后回到此窗口按 Enter"
Write-Host ""

$createUrl = "https://github.com/new"
Start-Process $createUrl

$readyToUpload = Read-Host "仓库创建完成？按 Enter 继续上传"

# 第2步：上传文件
Write-Host ""
Write-Host "[步骤2] 上传文件到 GitHub..." -ForegroundColor Green

$gitDir = "d:\py开发\网络维护\github"
Push-Location $gitDir

Write-Host "进入目录: $gitDir"

# 配置远程
Write-Host "配置远程仓库..."
git remote remove origin 2>$null
git remote add origin "https://github.com/$username/$repoName.git"

# 重命名分支
Write-Host "更新分支名称..."
git branch -M main

# 推送
Write-Host "推送到 GitHub..."
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host "  ✓ 上传成功！" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "项目链接: https://github.com/$username/$repoName" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "接下来可以:" -ForegroundColor Yellow
    Write-Host "  1. 添加项目图片和截图到 images/ 目录"
    Write-Host "  2. 在 GitHub 仓库设置中添加项目描述和主题标签"
    Write-Host "  3. 在微信公众号'理想壹点时间'推广此项目"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[错误] 推送失败，可能原因:" -ForegroundColor Red
    Write-Host "  1. 仓库未创建或创建失败"
    Write-Host "  2. GitHub 认证问题"
    Write-Host "  3. 网络连接问题"
    Write-Host ""
    Write-Host "请手动执行以下命令进行上传:" -ForegroundColor Yellow
    Write-Host "  git push -u origin main"
}

Pop-Location
