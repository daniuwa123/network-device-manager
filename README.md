# 网络设备管理工具 (Network Device Management Tool)

<div align="center">

![logo](images/logo.png)

**一款功能强大的企业级网络设备配置和管理工具**

[English](#english) | [中文](#中文)

---

### 官方公众号
<img src="images/wechat_qrcode.png" alt="理想壹点时间" width="200"/>

**微信公众号：给理想壹点时间**

关注我们获取最新功能更新、使用教程和行业资讯。

---

</div>

## 中文

### 📋 功能特性

本工具是一个功能完整的网络设备管理平台，支持多厂商、多协议的网络设备配置和管理：

#### 核心功能
- **设备管理**：支持创建多个设备组，快速组织和管理大量网络设备
- **多协议支持**：SSH、Telnet、WEB等多种通信协议
- **多厂商兼容**：支持华为、中兴、神州数码、迈普等主流厂商
- **自动检测**：智能识别设备型号和操作系统
- **命令执行**：批量发送配置命令到多台设备，实时查看执行结果
- **配置备份**：自动备份设备配置，支持版本对比和恢复
- **配置模板**：预设常用配置模板，快速部署网络策略
- **VLAN管理**：图形化界面创建、修改、删除VLAN配置
- **端口管理**：批量配置端口模式、速率、双工模式等
- **性能监控**：实时查看设备CPU、内存、流量等性能指标
- **日志审计**：记录所有操作日志，支持远程Syslog存储
- **数据导入/导出**：支持Excel、CSV等格式的设备数据导入导出

#### 高级功能
- **终端仿真**：内置SSH/Telnet终端，支持命令历史和自动补全
- **配置文件编辑**：可视化编辑设备配置，语法高亮
- **网络拓扑**：动态展示网络设备拓扑关系
- **告警管理**：设备异常自动告警，支持邮件通知
- **权限管理**：细粒度的用户权限控制

### 🎯 应用场景

- 学校、企业、运营商等大型网络环境的日常维护
- 网络设备集中配置和标准化部署
- 网络变更和故障排查
- 设备性能监控和优化
- 安全审计和日志管理

### 💻 系统要求

- **操作系统**：Windows 7及以上 / Linux / macOS
- **Python**：3.8+（仅用于开发）
- **内存**：最低512MB，建议2GB+
- **网络**：支持管理IPv4/IPv6网络设备

### 📦 安装与使用

#### 方式一：使用预编译版本（推荐）
1. 从Releases页面下载最新版本的 `netman-2.8.6.5.exe`
2. 运行安装程序或直接执行exe文件
3. 首次运行时会自动初始化配置

#### 方式二：从源代码运行
```bash
# 克隆仓库
git clone https://github.com/yourusername/network-device-manager.git
cd network-device-manager

# 安装依赖（仅供开发使用）
pip install -r requirements.txt

# 运行应用
python sw.py
```

### 🚀 快速开始

1. **首次启动**
   - 应用会自动创建配置目录
   - 设置管理员账户和密码

2. **添加设备**
   - 在左侧创建新的设备组
   - 添加具体的网络设备，输入IP、用户名、密码

3. **设备连接**
   - 选择设备，点击"连接"
   - 若连接成功，可看到设备实时信息

4. **执行命令**
   - 在命令输入框输入交换机命令
   - 支持批量发送到多台设备

5. **备份配置**
   - 点击"备份"按钮自动保存设备配置
   - 可随时对比和恢复备份版本

### 📸 功能演示

#### 主界面
- 左侧：设备树形结构，快速导航
- 中间：终端仿真区，实时命令交互
- 右侧：配置预览和设备状态监控

#### 常见操作
- **批量配置**：选择多台设备，执行相同配置
- **配置对比**：自动对比不同时间的配置文件
- **模板应用**：快速应用预设的标准配置模板

### ⚙️ 高级配置

#### 配置文件位置
- Windows: `C:\Users\<username>\AppData\Roaming\network_tool\config.json`
- Linux: `~/.config/network_tool/config.json`
- macOS: `~/Library/Application Support/network_tool/config.json`

#### 支持的厂商
- 华为 (Huawei)
- 中兴 (ZTE)
- 神州数码 (Dawning)
- 迈普 (Maipu)
- 其他标准Cisco/HP兼容设备

#### 通信协议
- SSH v2
- Telnet
- WEB (HTTP/HTTPS)
- SNMP v2/v3

### 📊 日志和审计

应用支持详细的操作日志：
```
log/
├── app.log           # 应用运行日志
├── network.log       # 网络通信日志
└── audit.log         # 操作审计日志
```

### 🔒 安全特性

- 密码加密存储（AES-256）
- 支持LDAP/AD集成认证
- 操作审计日志
- 支持TLS加密通信
- 会话超时自动锁定

### 🛠️ 故障排查

#### 常见问题

**Q: 无法连接到设备**
- 检查设备IP和网络连通性
- 验证用户名和密码是否正确
- 确认SSH/Telnet服务已启用

**Q: 命令执行超时**
- 增加命令超时设置（设置→网络→命令超时）
- 检查网络延迟和设备响应时间

**Q: 配置导入失败**
- 确保文件格式正确（JSON或CSV）
- 检查必填字段是否完整

详见 [完整故障排查指南](docs/troubleshooting.md)

### 📚 文档

- [用户手册](docs/user_manual.md)
- [API文档](docs/api.md)
- [故障排查](docs/troubleshooting.md)
- [配置指南](docs/configuration.md)
- [远程日志存储](docs/syslog_storage.md)

### 🤝 贡献

欢迎提交Issue和Pull Request！

- [贡献指南](CONTRIBUTING.md)
- [开发环境搭建](docs/development.md)

### 📝 更新日志

#### v2.8.6.5 (2024年3月)
- 新增设备性能监控面板
- 优化批量命令执行速度
- 修复终端排序显示问题
- 增加迈普厂商支持

#### v2.8.6.3 (2024年2月)
- 增强搜索和过滤功能
- 改进配置文件编辑器
- 新增配置差异对比

详见 [完整版本历史](CHANGELOG.md)

### 📄 许可证

本项目采用 MIT License - 详见 [LICENSE](LICENSE) 文件

### 💬 联系方式

- **微信公众号**：理想壹点时间
- **Email**：support@example.com
- **Issues**：[GitHub Issues](https://github.com/yourusername/network-device-manager/issues)

---

## English

### 📋 Features

A comprehensive enterprise-grade network device management platform supporting multiple vendors and protocols:

#### Core Features
- **Device Management**: Create device groups for easy organization of large-scale networks
- **Multi-Protocol Support**: SSH, Telnet, WEB and more
- **Multi-Vendor Compatibility**: Support for Huawei, ZTE, Dawning, Maipu, and other mainstream vendors
- **Auto Detection**: Intelligent device type and OS identification
- **Command Execution**: Batch send configuration commands with real-time results
- **Configuration Backup**: Automatic backup with version comparison and recovery
- **Configuration Templates**: Pre-configured templates for quick deployment
- **VLAN Management**: Graphical VLAN creation, modification, and deletion
- **Port Management**: Bulk port configuration (mode, speed, duplex, etc.)
- **Performance Monitoring**: Real-time CPU, memory, and traffic monitoring
- **Audit Logging**: Complete operation logging with remote Syslog support
- **Data Import/Export**: Support for Excel, CSV formats

#### Advanced Features
- **Terminal Emulation**: Built-in SSH/Telnet with command history
- **Configuration Editor**: Visual editor with syntax highlighting
- **Network Topology**: Dynamic topology visualization
- **Alarm Management**: Automatic anomaly alerts with email notification
- **Access Control**: Fine-grained permission management

### 🎯 Use Cases

- Maintenance of large-scale networks in schools, enterprises, and ISPs
- Centralized device configuration and standardized deployment
- Network changes and troubleshooting
- Device performance monitoring
- Security audit and log management

### 💻 System Requirements

- **OS**: Windows 7+ / Linux / macOS
- **Python**: 3.8+ (development only)
- **Memory**: Minimum 512MB, recommended 2GB+
- **Network**: IPv4/IPv6 support

### 📦 Installation

#### Option 1: Use Pre-built Executable (Recommended)
1. Download `netman-2.8.6.5.exe` from Releases
2. Run the installer or execute directly
3. Auto-initialization on first run

#### Option 2: Run from Source
```bash
git clone https://github.com/yourusername/network-device-manager.git
cd network-device-manager
pip install -r requirements.txt
python sw.py
```

### 🚀 Quick Start

1. **First Launch**: Configure admin account
2. **Add Devices**: Create groups and add network devices
3. **Connect**: Select device and click Connect
4. **Execute Commands**: Send commands to devices
5. **Backup Configuration**: Automatic backup feature

### 🔒 Security

- AES-256 password encryption
- LDAP/AD integration
- Operation audit logging
- TLS encrypted communication
- Session timeout protection

### 📚 Documentation

- [User Manual](docs/user_manual.md)
- [API Documentation](docs/api.md)
- [Troubleshooting](docs/troubleshooting.md)
- [Configuration Guide](docs/configuration.md)

### 📝 License

MIT License - See [LICENSE](LICENSE) file

### 💬 Contact

- **WeChat Official Account**: 理想壹点时间
- **Email**: support@example.com
- **Issues**: [GitHub Issues](https://github.com/yourusername/network-device-manager/issues)

---

<div align="center">

Made with ❤️ by the Network Team

</div>
