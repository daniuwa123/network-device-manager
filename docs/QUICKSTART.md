# 快速开始指南 (Quick Start)

## ⚡ 5分钟快速入门

### 步骤1：安装（1分钟）

**Windows用户：**
1. 下载 `netman-2.8.6.5.exe`
2. 双击运行，按照提示完成安装
3. 安装完成会自动启动

**Linux/macOS用户：**
```bash
# 安装依赖
pip3 install PyQt6 paramiko requests

# 运行应用
python3 sw.py
```

### 步骤2：初始化（1分钟）

首次启动时：
1. 设置管理员用户名和密码
2. 点击"完成"

### 步骤3：添加设备（2分钟）

最简单的方式 - 单个添加：

1. 点击右侧 **"新增设备"** 按钮
2. 填写以下信息：
   - **IP**: `192.168.1.1`（你的交换机IP）
   - **名称**: `我的交换机`
   - **用户名**: `admin`（默认）
   - **密码**: `admin`（默认）
   - **厂商**: `自动检测`（推荐）

3. 点击 **"保存"**

### 步骤4：连接设备（1分钟）

1. 在左侧列表中选择刚添加的设备
2. 点击 **"连接"** 按钮（或双击设备）
3. 等待3-5秒

如果连接成功：
- 状态指示灯变成 🟢 绿色
- 下方出现设备命令提示符（如 `<sw>`）

### 步骤5：执行第一条命令（1分钟）

1. 在下方命令框输入命令（根据厂商不同）：

**华为设备：**
```
display version
```

**中兴设备：**
```
show version
```

**思科设备：**
```
show version
```

2. 按 **Enter** 或点击 **"执行"** 按钮
3. 查看返回结果

---

## 常见第一步操作

### 批量导入设备（推荐用于大型部署）

如果你有多台设备，建议使用批量导入：

#### 准备设备列表

创建文件 `devices.csv`，内容如下：

```csv
IP,Name,Username,Password,Vendor
192.168.1.1,核心交换机,admin,admin123,Huawei
192.168.1.2,接入交换机1,admin,admin123,ZTE
192.168.1.3,接入交换机2,admin,admin123,神州数码
```

#### 导入

1. 菜单 → **数据管理** → **导入设备**
2. 选择 `devices.csv` 文件
3. 点击 **"导入"** → **"确认"**
4. 所有设备导入完成

---

## 常见命令参考

### 查看系统信息

```bash
# 华为
display version
display device manufacture-date
display clock

# 中兴/其他
show version
show system
show clock
```

### 查看接口状态

```bash
# 华为
display interface brief
display interface GigabitEthernet 1/0/1

# 中兴/其他
show interface brief
show interface gigabit 1/0/1
```

### 查看VLAN

```bash
# 华为
display vlan all
display vlan 100

# 中兴/其他
show vlan all
show vlan 100
```

### 配置接口

```bash
# 进入接口配置模式
# 华为
system-view
interface GigabitEthernet 1/0/1
port link-type access
port access vlan 100
quit

# 中兴
configure terminal
interface GigabitEthernet1/0/1
switchport mode access
switchport access vlan 100
exit
```

---

## 常见问题快速排查

### ❌ 无法连接

**最可能的原因：** 设备IP、用户名或密码不正确

**快速排查：**
```bash
# 1. 测试网络
ping 192.168.1.1

# 2. 测试SSH端口
telnet 192.168.1.1 22
```

**解决：** 
- 确认IP地址无误
- 确认用户名密码无误
- 确认SSH服务已启动

### ❌ 命令执行超时

**可能原因：** 网络延迟或设备繁忙

**解决：**
1. 菜单 → 设置 → 网络
2. 增加超时时间到 60 秒
3. 重新执行命令

### ❌ 中文显示乱码

**可能原因：** 编码格式不匹配

**解决：**
1. 菜单 → 设置 → 编码
2. 逐个尝试：UTF-8 → GB2312 → GBK
3. 重新连接设备

---

## 下一步学习

### 备份配置（重要！）

1. 连接到设备后，点击 **"备份"** 按钮
2. 等待备份完成
3. 定期检查备份（右键设备 → 配置管理）

### 创建VLAN

1. 菜单 → 配置管理 → VLAN管理
2. 点击 **"新增VLAN"**
3. 输入VLAN ID和名称
4. 选择要加入的端口
5. 点击 **"应用"**

### 批量执行命令

1. 在左侧选择多个设备（Ctrl+点击）
2. 在命令框输入命令
3. 点击 **"批量发送"**
4. 查看每台设备的执行结果

### 导出设备信息

1. 菜单 → 数据管理 → 导出设备
2. 选择导出格式（CSV 或 Excel）
3. 选择保存位置
4. 导出完成

---

## 快速参考卡

### 快捷键

| 快捷键 | 功能 |
|-------|------|
| `Ctrl+N` | 新建设备 |
| `Ctrl+E` | 编辑设备 |
| `Ctrl+S` | 保存 |
| `Ctrl+B` | 备份 |
| `Ctrl+F` | 搜索 |
| `F5` | 刷新 |

### 常见厂商默认凭证

| 厂商 | 用户名 | 密码 |
|-----|-------|------|
| 华为 | admin | admin |
| 中兴 | admin | admin |
| 神州数码 | admin | admin |
| 迈普 | admin | admin |

### 常见端口

| 协议 | 默认端口 |
|-----|---------|
| SSH | 22 |
| Telnet | 23 |
| HTTP | 80 |
| HTTPS | 443 |

---

## 获取帮助

- **遇到问题？** → [完整故障排查](docs/troubleshooting.md)
- **有疑问？** → [FAQ](../FAQ.md)
- **需要详细文档？** → [用户手册](docs/user_manual.md)
- **微信公众号** → **理想壹点时间**

---

## 下一个版本

准备好深入学习了？

- 📖 阅读 [完整用户手册](docs/user_manual.md)
- 🔧 探索 [高级配置](docs/configuration.md)
- 📊 了解 [性能监控](docs/user_manual.md#性能监控)
- 🤝 查看 [贡献指南](../CONTRIBUTING.md) 参与开发

---

**祝贺！** 🎉 你已经完成了基本设置！

现在你可以：
- ✅ 管理网络设备
- ✅ 执行配置命令
- ✅ 备份重要配置
- ✅ 监控设备状态

有任何问题，随时查看文档或在微信公众号提问！
