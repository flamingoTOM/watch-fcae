import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

/**
 * LxyEnduro 简洁表盘
 * 显示：时间、心率、电量、步数、星期、月份
 */
class LxyEnduroView extends WatchUi.WatchFace {

    /**
     * 构造函数
     */
    function initialize() {
        WatchFace.initialize();
    }

    /**
     * 加载资源
     */
    function onLayout(dc) {
        // 布局初始化
    }

    /**
     * 表盘显示时调用
     */
    function onShow() {
    }

    /**
     * 更新表盘显示
     */
    function onUpdate(dc) {
        // 清空屏幕 - 黑色背景
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var centerX = width / 2;
        var centerY = height / 2;

        // 显示标题
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, 40, Graphics.FONT_MEDIUM, "LXY ENDURO", Graphics.TEXT_JUSTIFY_CENTER);

        // 显示时间
        var clockTime = System.getClockTime();
        var timeString = Lang.format("$1$:$2$", [
            clockTime.hour.format("%02d"),
            clockTime.min.format("%02d")
        ]);

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, centerY, Graphics.FONT_NUMBER_HOT, timeString, Graphics.TEXT_JUSTIFY_CENTER);

        // 显示电量
        var battery = System.getSystemStats().battery;
        var batteryText = "BAT: " + battery.format("%.0f") + "%";
        dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_TRANSPARENT);
        dc.drawText(centerX, height - 60, Graphics.FONT_SMALL, batteryText, Graphics.TEXT_JUSTIFY_CENTER);
    }

    /**
     * 表盘隐藏时调用
     */
    function onHide() {
    }

    /**
     * 进入睡眠模式
     */
    function onEnterSleep() {
    }

    /**
     * 退出睡眠模式
     */
    function onExitSleep() {
    }

}
