# 如何编译和运行 LXY Enduro 表盘

## ✅ 准备工作已完成

你的表盘项目已经准备就绪：

- ✅ 源代码已创建（LxyEnduroApp.mc, LxyEnduroView.mc）
- ✅ 配置文件已设置（manifest.xml, monkey.jungle）
- ✅ 资源文件已配置（strings.xml, bitmaps.xml）
- ✅ 图标已生成（icon.png）
- ✅ VS Code 配置已创建（.vscode/）

---

## 🚀 方法一：使用 VS Code（推荐）

### 步骤 1：确保 Connect IQ SDK 已安装

1. **打开 VS Code**
   ```bash
   code C:\Users\xiaoyu.liu\Desktop\my_project\watch-fcae\lxy_enduro
   ```

2. **检查 Monkey C 扩展**
   - 按 `Ctrl+Shift+X` 打开扩展面板
   - 搜索 "Monkey C"
   - 确认已安装 **Monkey C** 扩展（作者：Garmin）

3. **配置 SDK（首次使用）**
   - 按 `Ctrl+Shift+P` 打开命令面板
   - 输入 "Monkey C: Edit SDK Manager"
   - 如果 SDK 未安装，扩展会提示你下载
   - 选择最新的 SDK 版本并下载安装

### 步骤 2：选择目标设备

1. **打开命令面板**
   - 按 `Ctrl+Shift+P`

2. **选择设备**
   - 输入 "Monkey C: Set Launch Config"
   - 或直接输入 "Monkey C: Select Device"
   - 选择 **enduro** 作为目标设备

### 步骤 3：编译和运行

#### 选项 A：使用快捷键（最简单）
```
按 F5 键 - 启动调试模式（自动编译并在模拟器中运行）
```

#### 选项 B：使用命令面板
1. 按 `Ctrl+Shift+P`
2. 输入 "Monkey C: Run Without Debugging"
3. 等待编译完成，模拟器会自动启动

#### 选项 C：使用菜单
1. 点击 VS Code 顶部菜单：**Run → Start Debugging**
2. 或点击：**Run → Run Without Debugging**

### 步骤 4：查看表盘

编译成功后：
- ✅ 模拟器会自动启动
- ✅ 表盘会显示在模拟器中
- ✅ 你可以看到时间、心率、电量、步数、星期、月份

### 模拟器操作

- **返回键**：模拟器左上角的按钮
- **确认键**：模拟器右上角的按钮
- **上下键**：模拟器左右两侧的按钮
- **时间设置**：File → Set Time

---

## 🛠 方法二：使用命令行

### 步骤 1：找到 SDK 路径

```bash
# SDK 通常安装在以下位置之一：
# Windows: C:\Users\<用户名>\AppData\Roaming\Garmin\ConnectIQ\Sdks\
# Mac: ~/Library/Application Support/Garmin/ConnectIQ/Sdks/
# Linux: ~/.Garmin/ConnectIQ/Sdks/
```

### 步骤 2：设置环境变量

```bash
# 设置 SDK 路径（根据实际路径修改）
export CIQ_SDK="C:/Users/xiaoyu.liu/AppData/Roaming/Garmin/ConnectIQ/Sdks/connectiq-sdk-win-7.4.1-2025-01-07-dcc1e6836"

# 将 bin 目录添加到 PATH
export PATH="$CIQ_SDK/bin:$PATH"
```

### 步骤 3：编译项目

```bash
cd /c/Users/xiaoyu.liu/Desktop/my_project/watch-fcae/lxy_enduro

# 编译项目
monkeyc \
  -d enduro \
  -f monkey.jungle \
  -o bin/lxy_enduro.prg \
  -y "$CIQ_SDK/developer_key"
```

### 步骤 4：运行模拟器

```bash
# 启动模拟器
connectiq &

# 或指定设备
connectiq -d enduro -a bin/lxy_enduro.prg
```

---

## 📱 方法三：部署到真机

### 准备工作

1. **生成开发者密钥**（首次）
   ```bash
   openssl genrsa -out developer_key.pem 2048
   openssl pkcs8 -topk8 -inform PEM -outform DER \
     -in developer_key.pem -out developer_key -nocrypt
   ```

2. **编译发布版本**
   ```bash
   monkeyc \
     -d enduro \
     -f monkey.jungle \
     -o bin/lxy_enduro.prg \
     -r \
     -y developer_key
   ```

### 部署到手表

#### 方法 A：通过 USB
1. 使用 USB 连接手表到电脑
2. 将 `bin/lxy_enduro.prg` 复制到手表的 `GARMIN/APPS/` 目录
3. 断开手表，表盘会自动安装

#### 方法 B：通过 Connect IQ App
1. 在 [Garmin Connect IQ Store](https://apps.garmin.com/developer) 创建应用
2. 上传 `.prg` 文件
3. 在手机上通过 Connect IQ App 安装到手表

---

## 🐛 故障排除

### 问题 1：找不到 monkeyc 命令

**原因**：SDK 未安装或未添加到 PATH

**解决方案**：
1. 在 VS Code 中使用 Monkey C 扩展自动安装 SDK
2. 或手动下载：https://developer.garmin.com/connect-iq/sdk/

### 问题 2：编译错误 "Cannot find symbol"

**原因**：缺少 import 语句或 API 不兼容

**解决方案**：
```monkeyc
// 确保在文件顶部添加所有必要的 import
import Toybox.Graphics;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Activity;
import Toybox.Time.Gregorian;
```

### 问题 3：模拟器无法启动

**原因**：Java 未安装或版本不兼容

**解决方案**：
1. 安装 Java 8 或更高版本
2. 设置 JAVA_HOME 环境变量

### 问题 4：图标不显示

**原因**：icon.png 文件缺失或路径错误

**解决方案**：
```bash
# 检查图标文件是否存在
ls resources/images/icon.png

# 如果不存在，重新生成
cd resources/images
python -c "from PIL import Image; img = Image.new('RGB', (80, 80), 'blue'); img.save('icon.png')"
```

### 问题 5：心率或步数显示为 0

**原因**：模拟器默认没有模拟数据

**解决方案**：
在模拟器中：
- File → Simulation → Activity Tracking
- 设置模拟的步数和心率数据

---

## 📊 表盘功能说明

你创建的表盘包含以下元素：

| 位置 | 显示内容 | 颜色 | 字体 |
|------|---------|------|------|
| **中央** | 时间（HH:MM） | 白色 | 大号 |
| **左上角** | 心率（HR） | 红色标签 + 白色数值 | 小号 |
| **右上角** | 电量（BAT） | 绿色标签 + 白色数值 | 小号 |
| **左下角** | 步数（STEPS） | 蓝色标签 + 白色数值 | 小号 |
| **右下角** | 星期 + 日期 | 黄色星期 + 白色日期 | 小号 |

---

## 🎯 快速启动命令

### 在 VS Code 中（最简单）

```bash
# 1. 打开项目
code C:\Users\xiaoyu.liu\Desktop\my_project\watch-fcae\lxy_enduro

# 2. 按 F5 运行
```

### 使用命令行

```bash
# 进入项目目录
cd /c/Users/xiaoyu.liu/Desktop/my_project/watch-fcae/lxy_enduro

# 如果 SDK 已配置，直接运行（假设安装了 VS Code 扩展）
# VS Code 扩展会自动处理编译和运行
```

---

## 📚 下一步

### 测试表盘
- ✅ 检查时间显示是否正确
- ✅ 验证心率数据（需要在模拟器中设置）
- ✅ 检查电量显示
- ✅ 验证步数统计
- ✅ 确认星期和日期格式

### 进阶开发
- 添加秒针动画
- 自定义配色方案
- 添加天气信息
- 添加日出日落时间
- 添加更多活动数据

### 发布表盘
1. 注册 Garmin 开发者账号
2. 在 Connect IQ Store 创建应用
3. 上传表盘并填写信息
4. 提交审核

---

## 💡 提示

- 使用 `System.println()` 打印调试信息
- 在 VS Code 的 OUTPUT 面板查看日志
- 使用 F5 启动调试，Ctrl+Shift+F5 重启模拟器
- 修改代码后保存，F5 自动重新编译

---

## 🆘 需要帮助？

- [Garmin Connect IQ 官方文档](https://developer.garmin.com/connect-iq/)
- [Connect IQ API 文档](https://developer.garmin.com/connect-iq/api-docs/)
- [Garmin 开发者论坛](https://forums.garmin.com/developer/)

---

祝你开发愉快！🎉
