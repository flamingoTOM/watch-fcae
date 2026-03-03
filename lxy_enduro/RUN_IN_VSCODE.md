# 在 VS Code 中运行（最简单的方法）

SDK 正在后台下载中...

## 🚀 最简单的方法 - 让 VS Code 自动处理

### 方法 1：使用 VS Code 命令（推荐）

1. **确保 VS Code 已打开项目**
   - 当前应该已经打开了 `LxyEnduroApp.mc` 文件

2. **打开命令面板**
   ```
   按 Ctrl+Shift+P
   ```

3. **配置 SDK（首次使用）**
   ```
   输入：Monkey C: Edit SDKs
   ```
   - 如果 SDK 未安装，扩展会自动提示下载
   - 点击 "Download" 按钮
   - 等待下载完成（约 5-10 分钟）

4. **选择设备**
   ```
   按 Ctrl+Shift+P
   输入：Monkey C: Select Device
   选择：enduro
   ```

5. **运行项目**
   ```
   按 F5
   ```
   或
   ```
   按 Ctrl+Shift+P
   输入：Monkey C: Run Without Debugging
   ```

### 方法 2：使用侧边栏

1. 点击 VS Code 左侧的 **Run and Debug** 图标（播放按钮）
2. 点击顶部的绿色 **播放按钮**
3. 选择 **"Run on ENDURO Simulator"**

### 方法 3：使用菜单

1. 顶部菜单：**Run** → **Start Debugging** (F5)
2. 或：**Run** → **Run Without Debugging** (Ctrl+F5)

---

## ⏳ SDK 下载进度

SDK 正在通过脚本自动下载到：
```
C:\Users\xiaoyu.liu\AppData\Roaming\Garmin\ConnectIQ\Sdks
```

下载完成后，VS Code 会自动检测到 SDK。

---

## 🎯 预期效果

编译成功后，你会看到：

1. **终端输出**
   ```
   Building for device enduro...
   Compiling source/LxyEnduroApp.mc
   Compiling source/LxyEnduroView.mc
   Linking...
   Build successful!
   ```

2. **模拟器启动**
   - 会弹出一个新窗口
   - 显示 ENDURO 手表界面
   - 表盘会自动加载

3. **表盘显示**
   ```
   ┌─────────────────────┐
   │ HR: 75    BAT: 85%  │
   │                     │
   │       12:45         │
   │                     │
   │ STEPS: 5230    WED  │
   │            JAN 5    │
   └─────────────────────┘
   ```

---

## 🐛 如果遇到问题

### 问题 1：Monkey C 扩展未安装

**解决方案**：
1. 按 `Ctrl+Shift+X` 打开扩展市场
2. 搜索 "Monkey C"
3. 点击 "Install"（作者：Garmin）

### 问题 2：SDK 下载失败

**解决方案**：
1. 手动下载：https://developer.garmin.com/connect-iq/sdk/
2. 解压到：`C:\Users\xiaoyu.liu\AppData\Roaming\Garmin\ConnectIQ\Sdks\`

### 问题 3：找不到设备

**解决方案**：
1. 按 `Ctrl+Shift+P`
2. 输入 "Monkey C: Set Launch Config"
3. 选择 "enduro"

### 问题 4：编译错误

**解决方案**：
- 检查 OUTPUT 面板的详细错误信息
- 确保所有 import 语句正确
- 确保 manifest.xml 格式正确

---

## 💡 快捷键速查

| 操作 | 快捷键 |
|------|--------|
| 运行/调试 | `F5` |
| 运行（不调试） | `Ctrl+F5` |
| 停止调试 | `Shift+F5` |
| 重启调试 | `Ctrl+Shift+F5` |
| 命令面板 | `Ctrl+Shift+P` |
| 构建 | `Ctrl+Shift+B` |

---

现在就试试吧！按 **F5** 🚀
