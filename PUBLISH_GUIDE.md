# 快速发布到 GitHub 指南

## 方式1：使用 PowerShell 脚本（推荐）⭐

### 前置准备

**1. 获取 GitHub Token**
   - 打开：https://github.com/settings/tokens
   - 点击 "Generate new token" → "Generate new token (classic)"
   - 选择 "repo" 权限
   - 复制生成的 Token（保管好，只显示一次）

**2. 准备你的 GitHub 用户名**
   - 你的 GitHub 用户名（例如：yourname）

### 执行步骤

**第1步：打开 PowerShell**
```bash
# Windows: 按 Win+X，选择 Windows PowerShell (管理员)
# 或按 Win+R，输入 powershell，按 Enter
```

**第2步：进入 github 文件夹**
```powershell
cd "d:\py开发\网络维护\github"
```

**第3步：允许脚本执行（首次运行）**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

**第4步：运行脚本（填入你的信息）**
```powershell
.\publish_to_github.ps1 -GithubUsername "你的GitHub用户名" -GithubToken "你的GitHub Token"
```

**示例：**
```powershell
.\publish_to_github.ps1 -GithubUsername "john-doe" -GithubToken "ghp_xxxxxxxxxxxxxxxxxxx"
```

**第5步：按提示操作**
- 脚本会提示你在 GitHub 创建仓库
- 打开浏览器，访问 https://github.com/new
- 填写仓库信息（脚本会告诉你填什么）
- 创建仓库后，返回 PowerShell，按 Enter

**完成！** 🎉

---

## 方式2：使用批处理脚本（简单版）

**第1步：修改脚本**
1. 右键 `publish_to_github.bat`
2. 选择 "用记事本打开"
3. 修改这两行：
   ```batch
   set GITHUB_USERNAME=你的GitHub用户名
   set GITHUB_TOKEN=你的GitHub Token
   ```
4. 保存并关闭

**第2步：运行脚本**
- 双击 `publish_to_github.bat`
- 按照提示完成操作

---

## 方式3：手动操作（完全控制）

### 第1步：创建 GitHub 仓库

1. 打开 https://github.com/new
2. 填写信息：
   - **Repository name**: `network-device-manager`
   - **Description**: `Enterprise-grade network device management tool`
   - **Public** 选中（公开）
   - **不要** 初始化任何文件
3. 点击 "Create repository"

### 第2步：在本地初始化和上传

**打开 PowerShell，执行以下命令：**

```powershell
# 进入文件夹
cd "d:\py开发\网络维护\github"

# 初始化 Git
git init
git config user.name "你的GitHub用户名"
git config user.email "你的邮箱@users.noreply.github.com"

# 添加所有文件
git add .

# 创建初始提交
git commit -m "Initial commit: Add complete GitHub documentation"

# 添加远程仓库
git remote add origin https://github.com/你的GitHub用户名/network-device-manager.git

# 上传（会提示输入密码/Token）
git push -u origin main
```

当提示输入凭证时：
- **用户名**: 你的 GitHub 用户名
- **密码**: 你的 GitHub Token（不是 GitHub 密码！）

---

## 获取 GitHub Token 详细步骤

1. **登录 GitHub**
   - 访问 https://github.com
   - 确保已登录

2. **进入 Token 设置**
   - 点击右上角头像 → Settings（设置）
   - 左侧菜单：Developer settings（开发者设置）
   - Personal access tokens → Tokens (classic)

3. **生成 Token**
   - 点击 "Generate new token" → "Generate new token (classic)"
   - 填写 Token 信息：
     - **Note**: 自定义名称（如 "GitHub Desktop"）
     - **Expiration**: 选择过期时间（建议 90 days）
     - **Scopes**: 勾选 "repo"

4. **复制 Token**
   - 点击 "Generate token"
   - 复制显示的 Token
   - ⚠️ 关闭此页面后无法再看到，请妥善保管

---

## 上传后的操作

### 添加项目信息

1. 访问你的仓库：https://github.com/你的用户名/network-device-manager
2. 点击 "Settings"（设置）
3. 填写以下信息：
   - **Description**: Enterprise-grade network device management tool
   - **Topics**: 添加标签
     ```
     network, device, management, automation, 
     ssh, telnet, python, opensource
     ```
   - **Homepage** URL（如果有）

### 添加 Logo 和截图

1. 创建 `github/images/` 文件夹
2. 添加以下文件：
   - `logo.png` - 项目 Logo（200x200px）
   - `wechat_qrcode.png` - 微信公众号二维码
   - `screenshots/` - 应用截图目录

3. 提交到 GitHub：
   ```powershell
   cd "d:\py开发\网络维护\github"
   git add images/
   git commit -m "Add images: logo, wechat QR code, and screenshots"
   git push
   ```

### 在微信公众号推广

使用 `WECHAT_PROMOTION.md` 中的文案：
- 发布项目介绍文章
- 分享使用技巧
- 邀请用户反馈

---

## 常见问题

### Q: Token 是什么？
**A**: Token 是用来验证身份的安全码，相当于临时密码。比账户密码更安全，因为可以限制权限和过期时间。

### Q: 密码 vs Token？
**A**: 
- **GitHub 密码**：账户登录密码，权限全，不建议用于命令行
- **GitHub Token**：临时访问码，权限可控，更安全，推荐用于命令行

### Q: 能用账户密码代替 Token 吗？
**A**: 可以，但不安全。GitHub 官方推荐使用 Token。

### Q: 上传失败怎么办？

**如果显示 "Authentication failed"：**
```powershell
# 清除本地存储的凭证
git credential reject
protocol=https
host=github.com

# 重新推送，会再次提示输入凭证
git push
```

**如果显示 "Repository not found"：**
- 检查仓库名称是否正确
- 确认仓库已创建
- 检查用户名是否正确

**如果显示 "Permission denied"：**
- 确认 Token 未过期
- 确认 Token 有 "repo" 权限

### Q: 如何更新已上传的文件？

```powershell
cd "d:\py开发\网络维护\github"

# 修改文件后
git add .
git commit -m "Update: 描述你的更改"
git push
```

---

## 推荐使用顺序

### 快速上传（推荐新手）
```
1. 运行 PowerShell 脚本
2. 按照提示操作
3. 完成！
```

### 完全控制（推荐开发者）
```
1. 手动方式
2. 逐步执行命令
3. 可随时调整
```

---

## 需要帮助？

- 📖 查看 GitHub 官方文档：https://docs.github.com/
- 📚 查看本项目文档：[INDEX.md](INDEX.md)
- 💬 在微信公众号"理想壹点时间"提问

---

## 完成清单

上传后请检查：

- [ ] 仓库已创建并可访问
- [ ] README.md 在首页正确显示
- [ ] 所有文件已上传
- [ ] 添加了项目描述和 Topics
- [ ] 添加了 Logo 和二维码（可选）
- [ ] 在微信公众号推广（可选）

---

**祝贺！** 🎉 你的项目已成功发布到 GitHub！

现在全世界的人都可以看到你的项目了！
