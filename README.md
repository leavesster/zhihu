# ZhiHuDemo
The first demo that two week's job.

一开始没学会（懒，轴）上传，爬过的坑，提醒自己版本管理的重要性。

参考资料：
[iOS知乎日报](https://github.com/gnou/FakeZhihuDaily) —_— 涉及大量ReactiveCocoa的部分都没看懂，而ReactiveCocoa部分又比较多……

[API提供](https://github.com/izzyleung/ZhihuDailyPurify/wiki/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-API-%E5%88%86%E6%9E%90)

#功能以及界面
1.保存数据（暂限首页列表）以及载入时自动刷新———— CoreData + NSFetchedResultsController。
2.下拉刷新以及下拉刷新，同时网络数据随之更新———— MJRefresh控件+block，API。
3.侧滑菜单————SWRevealViewController
4.登陆，分享界面

个人实现：
内容页下拉放大，UIScrollviewDelegate相关

#未来：
Cocoapod支持，由于网速等原因，数次下载失败，在下次学习的过程中，进一步使用podfile管理。
目录整理
夜间模式
