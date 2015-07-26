# ZhiHuDemo
The first demo that two week's job.

一开始没学会（懒，轴）上传，爬过的坑，提醒自己版本管理的重要性。
UITableView+NSFetchedResultsController————stanford open class

—_—
[webview中HTML内容参考]
(https://github.com/gnou/FakeZhihuDaily)
其他地方也有点像……解释不清也许。
在contentView和列表中增加了委托回调，点击返回键返回后（未禁用侧滑返回），字体变浅色。点击切换喜欢；以上功能并不能实际存储，，官方分享等功能。
目录页面，完成了登录界面的部分设计，考虑了4s布局

点入内部知乎讨论弹出的网页会出现图片遮盖部分位置。如果使用contentInset可以避免，但是拼接内容时自动空了图片内容。所以还是嵌入webView.Scrollview内部。

[APIs]
(https://github.com/izzyleung/ZhihuDailyPurify/wiki/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-API-%E5%88%86%E6%9E%90)

#功能以及界面
1. 保存数据（暂限首页列表）以及载入时自动刷新———— 由于当日JSON地址固定，所以暂时必须先开网络下载首条，保存功能不完善。 NSFetchedResultsController，从开始使用类转化JSON，到单纯CoreData，再到最后配合NSFetchedResultsController，花了很大一部分时间在这个上面。
2. 下拉刷新以及下拉刷新，同时网络数据随之更新———— MJRefresh控件+block，API。
3. 侧滑菜单————SWRevealViewController
4. 登陆，分享窗口

其他实现：
内容页下拉放大————UIScrollviewDelegate，contentoffset.y
代码写部分首页图片

#未来：
Cocoapod支持，由于网速等原因，数次下载失败，在下次学习的过程中，进一步使用podfile依赖，不上传第三方库。

·目录整理

·侧滑栏：夜间模式，点击动画特效
