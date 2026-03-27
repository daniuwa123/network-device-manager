# 配置指南 (Configuration)

## 应用配置

### 配置文件位置

**Windows:**
```
C:\Users\<username>\AppData\Roaming\network_tool\config.json
```

**Linux:**
```
~/.config/network_tool/config.json
```

**macOS:**
```
~/Library/Application Support/network_tool/config.json
```

### 主配置文件结构

```json
{
  "version": "2.8.6.5",
  "general": {
    "language": "zh-CN",
    "theme": "light",
    "auto_save": true,
    "save_interval": 300
  },
  "network": {
    "ssh_port": 22,
    "telnet_port": 23,
    "ssh_timeout": 30,
    "command_timeout": 30,
    "encoding": "utf-8",
    "keep_alive": true,
    "keep_alive_interval": 60
  },
  "backup": {
    "auto_backup": false,
    "backup_interval": 86400,
    "max_backups": 30,
    "backup_path": "./backups"
  },
  "monitoring": {
    "enable_monitoring": true,
    "refresh_interval": 5,
    "cpu_threshold": 80,
    "memory_threshold": 85
  },
  "ui": {
    "window_width": 1280,
    "window_height": 800,
    "font_size": "normal",
    "show_status_bar": true
  }
}
```

## 网络配置

### SSH 配置

```json
{
  "network": {
    "ssh": {
      "port": 22,
      "timeout": 30,
      "banner_timeout": 5,
      "read_timeout": 10,
      "write_timeout": 10,
      "algorithms": {
        "kex": ["diffie-hellman-group14-sha1"],
        "encryption": ["aes128-ctr", "aes256-ctr"],
        "authentication": ["password", "publickey"]
      }
    }
  }
}
```

### Telnet 配置

```json
{
  "network": {
    "telnet": {
      "port": 23,
      "timeout": 30,
      "encoding": "utf-8"
    }
  }
}
```

## 备份配置

### 启用自动备份

```json
{
  "backup": {
    "auto_backup": true,
    "backup_interval": 86400,
    "max_backups": 30,
    "backup_path": "C:\\Users\\<username>\\AppData\\Roaming\\network_tool\\backups",
    "compress": true,
    "include_logs": false
  }
}
```

参数说明：
- `backup_interval`: 备份间隔（秒），86400=1天
- `max_backups`: 最多保留的备份数
- `compress`: 是否压缩备份文件
- `include_logs`: 是否包含日志文件

## 监控和告警

### 性能监控配置

```json
{
  "monitoring": {
    "enable_monitoring": true,
    "refresh_interval": 5,
    "collect_metrics": ["cpu", "memory", "interface", "uptime"],
    "thresholds": {
      "cpu": 80,
      "memory": 85,
      "interface_errors": 100,
      "interface_discards": 50
    }
  }
}
```

### 告警配置

```json
{
  "alarm": {
    "enable_alarm": true,
    "alarm_types": [
      "cpu_high",
      "memory_high",
      "device_down",
      "interface_error"
    ],
    "notification": {
      "email": true,
      "sms": false,
      "sound": true
    },
    "email_config": {
      "smtp_server": "smtp.gmail.com",
      "smtp_port": 587,
      "username": "your-email@gmail.com",
      "password": "your-password",
      "recipients": ["admin@example.com"]
    }
  }
}
```

## 设备配置

### 设备配置文件

**位置:**
```
C:\Users\<username>\AppData\Roaming\network_tool\device_config.json
```

**结构:**
```json
{
  "device_groups": [
    {
      "id": "group_001",
      "name": "核心层",
      "description": "核心交换机分组",
      "username": "admin",
      "password": "encrypted_password",
      "devices": [
        {
          "id": "dev_001",
          "ip": "192.168.1.1",
          "name": "核心交换机-1",
          "vendor": "Huawei",
          "protocol": "SSH",
          "port": 22,
          "username": "admin",
          "password": "encrypted_password",
          "tags": ["production", "core"],
          "description": "主要核心交换机",
          "last_connected": "2024-03-27 10:30:00"
        }
      ]
    }
  ]
}
```

## 高级配置

### 代理配置

```json
{
  "network": {
    "proxy": {
      "enable": false,
      "type": "socks5",
      "host": "proxy.example.com",
      "port": 1080,
      "username": "proxy_user",
      "password": "proxy_password"
    }
  }
}
```

### LDAP/AD 认证

```json
{
  "authentication": {
    "type": "ldap",
    "ldap": {
      "server": "ldap.example.com",
      "port": 389,
      "base_dn": "dc=example,dc=com",
      "bind_dn": "cn=admin,dc=example,dc=com",
      "bind_password": "password",
      "use_tls": true
    }
  }
}
```

### Syslog 配置

```json
{
  "logging": {
    "syslog": {
      "enable": true,
      "server": "syslog.example.com",
      "port": 514,
      "protocol": "udp",
      "facility": "local0",
      "level": "info"
    }
  }
}
```

## 命令行配置

### 启动参数

```bash
# 指定配置目录
netman.exe --config-dir "D:\custom_config"

# 指定日志级别
netman.exe --log-level debug

# 无GUI模式（命令行使用）
netman.exe --headless

# 指定设备组
netman.exe --group "核心层"
```

## 系统要求和限制

### 推荐配置

- **设备数量**: 最多 10,000 台
- **并发连接**: 最多 100 个
- **命令缓冲**: 最多 1000 条
- **备份保留**: 最多 100 个版本

### 性能调优

**对于大规模部署（>5000台设备）：**

```json
{
  "performance": {
    "device_page_size": 100,
    "disable_auto_refresh": true,
    "lazy_load_devices": true,
    "cache_device_info": true,
    "cache_ttl": 300
  }
}
```

参数说明：
- `device_page_size`: 设备分页大小
- `disable_auto_refresh`: 禁用自动刷新
- `lazy_load_devices`: 延迟加载设备信息
- `cache_device_info`: 缓存设备信息
- `cache_ttl`: 缓存有效期（秒）

## 调试配置

### 启用调试模式

```json
{
  "debug": {
    "enable": true,
    "log_level": "DEBUG",
    "log_network": true,
    "log_commands": true,
    "save_raw_output": true,
    "performance_metrics": true
  }
}
```

### 生成诊断报告

应用菜单 → 工具 → 诊断报告，会生成包含以下内容的报告：
- 系统信息
- 网络配置
- 已连接设备列表
- 最近的错误日志
- 性能指标

---

## 配置示例

### 小规模部署（<100台设备）

```json
{
  "general": {
    "language": "zh-CN",
    "theme": "light"
  },
  "network": {
    "ssh_timeout": 30,
    "command_timeout": 30
  },
  "backup": {
    "auto_backup": true,
    "backup_interval": 86400
  },
  "monitoring": {
    "enable_monitoring": true,
    "refresh_interval": 5
  }
}
```

### 企业级部署（1000+台设备）

```json
{
  "general": {
    "language": "zh-CN",
    "theme": "light",
    "auto_save": true
  },
  "network": {
    "ssh_timeout": 60,
    "command_timeout": 60
  },
  "backup": {
    "auto_backup": true,
    "backup_interval": 43200,
    "compress": true
  },
  "monitoring": {
    "enable_monitoring": false,
    "refresh_interval": 30
  },
  "performance": {
    "device_page_size": 100,
    "lazy_load_devices": true,
    "cache_device_info": true
  }
}
```

---

## 修复配置问题

### 配置文件损坏

如果配置文件损坏无法启动：

1. 备份现有配置文件
2. 删除损坏的配置文件
3. 应用将自动创建默认配置
4. 重新导入设备列表

### 重置为默认配置

```bash
# 备份当前配置
copy config.json config.json.bak

# 删除配置文件
del config.json

# 重启应用，将使用默认配置
```

---

更多配置问题？查看 [FAQ](../FAQ.md) 或关注微信公众号 **理想壹点时间** 获取帮助！
