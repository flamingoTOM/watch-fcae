# LXY Enduro 表盘

这是一个为 Garmin ENDURO1 手表开发的简单表盘 Demo。

## 项目结构

```
lxy_enduro/
├── manifest.xml              # 应用配置文件
├── monkey.jungle            # 构建配置
├── source/                  # 源代码目录
│   ├── LxyEnduroApp.mc     # 应用入口类
│   └── LxyEnduroView.mc    # 表盘视图类
├── resources/              # 资源目录
│   ├── bitmaps.xml        # 位图资源定义
│   ├── strings.xml        # 本地化字符串
│   └── images/            # 图片资源
│       └── icon.png       # 应用图标
└── README.md              # 本文件
```

## 功能特性

### 基础功能
- ✅ 数字时间显示（支持 12/24 小时制）
- ✅ 日期显示
- ✅ 秒数显示（唤醒状态）
- ✅ 步数统计
- ✅ 心率监测
- ✅ 睡眠模式支持（省电）

### 视觉设计
- 深色背景（适合户外运动）
- 圆形表盘边框
- 装饰性内圆
- 四个方向刻度标记
- 清晰的数字时间显示
- 底部活动数据展示

## 支持设备

- Garmin ENDURO
- Garmin Fenix 6 系列
  - Fenix 6
  - Fenix 6 Pro
  - Fenix 6S
  - Fenix 6S Pro
  - Fenix 6X Pro

## 开发环境设置

### 1. 安装 Connect IQ SDK
从 Garmin 官网下载并安装：
https://developer.garmin.com/connect-iq/sdk/

### 2. 安装 Visual Studio Code 扩展（推荐）
- Monkey C（Connect IQ 官方扩展）

### 3. 或使用 Eclipse IDE
- 安装 Connect IQ 插件
- 导入项目

## 编译和测试

### 使用 VS Code（推荐）

1. **打开项目**
   ```bash
   code lxy_enduro
   ```

2. **选择设备**
   - 按 `Ctrl+Shift+P`（Windows）或 `Cmd+Shift+P`（Mac）
   - 输入 "Monkey C: Select Device"
   - 选择 "enduro" 或其他支持设备

3. **编译项目**
   - 按 `F5` 启动调试
   - 或按 `Ctrl+Shift+B` 仅编译

4. **在模拟器中测试**
   - 编译后会自动启动模拟器
   - 查看表盘显示效果

### 使用命令行

```bash
# 编译项目
monkeyc -o lxy_enduro.prg -f monkey.jungle -y developer_key

# 在模拟器中运行
connectiq
```

## 部署到真机

### 方法 1：通过 Garmin Express

1. 使用 USB 连接手表到电脑
2. 编译生成 `.prg` 文件
3. 将 `.prg` 文件复制到手表的 `GARMIN/APPS` 目录
4. 断开手表，表盘会自动安装

### 方法 2：通过 Connect IQ App Store

1. 在 Garmin Connect IQ 开发者网站上传应用
2. 通过 Connect IQ 手机 App 安装到手表

## 代码说明

### LxyEnduroApp.mc（应用入口）

```monkeyc
class LxyEnduroApp extends Application.AppBase {
    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new LxyEnduroView() ];
    }
}
```

**关键点：**
- 继承 `Application.AppBase`
- `getInitialView()` 返回视图实例

### LxyEnduroView.mc（表盘视图）

```monkeyc
class LxyEnduroView extends WatchUi.WatchFace {
    function onUpdate(dc) {
        // 绘制表盘
    }

    function onEnterSleep() {
        // 进入省电模式
    }

    function onExitSleep() {
        // 退出省电模式
    }
}
```

**关键方法：**
- `onLayout(dc)` - 初始化，加载资源
- `onUpdate(dc)` - 完整更新，每分钟调用
- `onPartialUpdate(dc)` - 部分更新，用于秒针等
- `onEnterSleep()` - 进入睡眠模式
- `onExitSleep()` - 退出睡眠模式

### 绘图 API 常用方法

```monkeyc
// 设置颜色
dc.setColor(foreground, background);

// 清空屏幕
dc.clear();

// 绘制文本
dc.drawText(x, y, font, text, justification);

// 绘制圆形
dc.drawCircle(x, y, radius);

// 绘制矩形
dc.fillRectangle(x, y, width, height);

// 设置画笔宽度
dc.setPenWidth(width);
```

## 性能优化建议

### 1. 使用部分更新
```monkeyc
function onPartialUpdate(dc) {
    // 仅更新变化的部分（如秒针）
    dc.setClip(x, y, width, height);
    // 绘制秒针
}
```

### 2. 离屏缓冲
```monkeyc
var buffer = new Graphics.BufferedBitmap({
    :width => dc.getWidth(),
    :height => dc.getHeight()
});
```

### 3. 睡眠模式优化
```monkeyc
function onEnterSleep() {
    isAwake = false;
    // 停止不必要的更新
}
```

### 4. 资源预加载
```monkeyc
function onLayout(dc) {
    // 在初始化时加载资源
    icon = WatchUi.loadResource(Rez.Drawables.LauncherIcon);
}
```

## 进阶功能

### 添加设置菜单
```monkeyc
function getSettingsView() {
    return [new SettingsView(), new SettingsDelegate()];
}
```

### 添加并发症（Complications）
```monkeyc
// 显示更多活动数据
var calories = activityInfo.calories;
var distance = activityInfo.distance;
```

### 添加动画效果
```monkeyc
WatchUi.animate(
    object,
    :locX,
    WatchUi.ANIM_TYPE_LINEAR,
    startValue,
    endValue,
    duration,
    null
);
```

### 自定义字体
1. 将 `.ttf` 字体文件放入 `resources/fonts/`
2. 在 `resources.xml` 中引用：
   ```xml
   <font id="CustomFont" filename="fonts/custom.ttf" />
   ```

## 调试技巧

### 1. 使用 System.println() 打印日志
```monkeyc
System.println("Current time: " + clockTime.hour);
```

### 2. 查看日志输出
在 VS Code 的 "OUTPUT" 面板查看

### 3. 使用断点调试
在 VS Code 中设置断点，按 F5 启动调试

### 4. 模拟器快捷键
- `Ctrl+F5` - 启动模拟器
- `Ctrl+Shift+F5` - 重新启动模拟器

## 常见问题

### Q: 编译错误 "Cannot find symbol"
A: 检查 import 语句，确保引入了正确的模块

### Q: 时间不显示
A: 确保调用了 `System.getClockTime()` 并正确格式化

### Q: 心率显示为 0
A: 确保手表佩戴正确，心率传感器工作正常

### Q: 模拟器无法启动
A: 检查 Connect IQ SDK 是否正确安装

## 学习资源

- [Garmin Connect IQ 官方文档](https://developer.garmin.com/connect-iq/)
- [Connect IQ API 文档](https://developer.garmin.com/connect-iq/api-docs/)
- [Connect IQ 示例项目](https://github.com/garmin/connectiq-samples)
- [garmin-connectiq-samples 中文说明](../garmin-connectiq-samples-brief-explanations/README.md)

## 开发路线图

### Version 1.0.0（当前）
- ✅ 基础时间显示
- ✅ 日期显示
- ✅ 步数、心率显示
- ✅ 睡眠模式支持

### 未来计划（Version 1.1.0）
- ⬜ 秒针动画
- ⬜ 自定义配色方案
- ⬜ 天气信息显示
- ⬜ 电量指示
- ⬜ 蓝牙连接状态
- ⬜ 更多活动数据（卡路里、距离等）

### 高级功能（Version 2.0.0）
- ⬜ 模拟表盘模式
- ⬜ 多时区支持
- ⬜ 动画效果
- ⬜ 自定义并发症
- ⬜ 表盘设置菜单

## 贡献指南

欢迎提交 Issue 和 Pull Request！

### 代码风格
- 使用 4 空格缩进
- 函数和变量使用驼峰命名
- 添加必要的注释

### 提交信息规范
```
feat: 添加新功能
fix: 修复 bug
docs: 更新文档
style: 代码格式调整
refactor: 代码重构
```

## 许可证

MIT License

## 作者

刘晓煜 (LXY)

## 致谢

感谢 Garmin Connect IQ 团队提供的优秀开发平台和文档。
