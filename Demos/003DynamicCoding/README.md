# 003DynamicCoding

## 1. 启动界面
* 启动界面实质上是截图。
* LaunchScreen.storyboard中添加视图是不可响应的，因为最终显示的启动界面实质上是它的截图。
* 若开发过程中更改启动界面视图或图片后启动界面没有变化则删除应用后重新安装即可。

## 2. 更改TabBar外观
* 全局更改tabbar选中颜色UITabBar.appearance().tintColor = UIColor.red。

## 3. 独立storyboard
* 在一个工程中可使用多个storyboard，可创建storyboard然后通过storyboard references建立连接，也可选中需提取的view controllers然后Editor->Refactor to Storyboard将选中的view controllers提取为一个storyboard。
* 每个storyboard中都需要指定当前storyboard的initial view controller。

## 3. 命名空间
* swift命名空间就是ProductName，使用class获取类时前面需要加命名空间否则找不到。

