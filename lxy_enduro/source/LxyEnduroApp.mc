import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

/**
 * LxyEnduro 表盘应用主类
 * 这是应用的入口点
 */
class LxyEnduroApp extends Application.AppBase {

    /**
     * 构造函数
     */
    function initialize() {
        AppBase.initialize();
    }

    /**
     * 应用启动时调用
     * @param state 应用状态（如从后台恢复）
     */
    function onStart(state as Dictionary?) as Void {
        // 初始化代码
    }

    /**
     * 应用停止时调用
     * @param state 应用状态（用于保存数据）
     */
    function onStop(state as Dictionary?) as Void {
        // 清理代码
    }

    /**
     * 返回初始视图
     * @return 视图数组 [View, Delegate]
     */
    function getInitialView() {
        return [ new LxyEnduroView() ];
    }

}

/**
 * 应用入口点
 * @param params 启动参数
 * @return 应用实例
 */
function getApp() as Application.AppBase {
    return Application.getApp() as LxyEnduroApp;
}
