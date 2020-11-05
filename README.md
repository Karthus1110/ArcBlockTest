## Usage

通过Xcode打开 `ArcBlockTest.xcworkspace `文件。`cmd+R`运行项目。



## 项目结构

- `Module`文件夹为程序各个模块，大部分App会包含常见Home、User等模块，模块内部分为MVC文件夹层级。` Base`文件夹存放项目基类，包括`ZYBaseViewController `,`ZYBaseNavigationController `，项目较大时，基类设计可以统一处理一些设计风格问题，包括导航栏等
- `ZYArchitecture`存放我个人或者项目中常用的一些工具类、拓展及组件
- `Resouce`一般存放一些本地资源，包括一些不常用的图片、音频文件等
- 项目中包管理工具使用[CocoaPods](https://github.com/CocoaPods/CocoaPods),个人在自己项目中使用过[SPM](https://github.com/apple/swift-package-manager)，[Carthage](https://github.com/Carthage/Carthage)。SPM为苹果官方推出，目前普及率较低，Carthage坑比较多，Xcode12升级，导致包管理工具出错，耗费两天时间处理，公司项目建议使用最成熟的CocoaPods
- 项目入口为`ZYRootViewController`，一般项目会有Tabbar则在此初始化TabbarController，此处只是简单示例。



## 技术栈使用

- 纯Swift编写，采用MVC架构
- 网络图片处理使用swift框架[Kingfisher](https://github.com/onevcat/Kingfisher),该框架自带异步加载，图片缓存等处理，不必重复造轮子
- 详情页多图使用banner方式加载，无图情况也做了判断处理（若是实际项目中会有img-text类型没有图片的情况，个人认为应算作接口数据异常）
- 首页导航栏右键模拟无数据或无网络情况，使用runtime监听tableview的DataSource来决定是否展示空占位图，个人项目[PixHall](https://apps.apple.com/cn/app/id1475197621)中有对图片及数据加载异常、网络异常等的详细处理，此处因时间问题，只是模拟展示
- 页面布局使用AutoLayout框架[SnapKit](https://github.com/SnapKit/SnapKit),链式语法，稳定高效，该库为Swift版本的[Masonry](https://github.com/SnapKit/Masonry)
- 项目内小图标使用iOS 13新增的 [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/)
- 多类型cell使用父类和多态的方式处理，所有cell继承自`ZYHomeCell`,统一通过model赋值，可以在处理tableview的DataSource中简化代码，减少if-else，switch使用，使代码更简洁、优雅。



## 一些问题

- 图片预览因时间问题，未做左右滑动，PixHall中使用的图片预览，有一些OC代码牵扯，暂时来不及移植