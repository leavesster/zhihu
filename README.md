# ZhiHuDemo
The first demo that two week's job.

##涉及内容参考自：
UITableView+NSFetchedResultsController————stanford open class
—_—
[webview中HTML格式参考](https://github.com/gnou/FakeZhihuDaily)其他地方也有点像……但我的扩展了更多，不一样了。
<br>
[APIs](https://github.com/izzyleung/ZhihuDailyPurify/wiki/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-API-%E5%88%86%E6%9E%90)

##实现功能：
1. 保存数据（暂时限于首页列表）。 ~~由于当日JSON地址固定，所以暂时必须先开网络下载首条，保存功能不完善。~~ 此处为bug，是由于在每次启动时都删除CoreData数据，已修复。
2.列表内容有更改自动刷新。NSFetchedResultsController，从开始使用类转化JSON，到单纯CoreData，再到最后配合NSFetchedResultsController，CoreData框架消耗时间最多。
2. 下拉刷新以及下拉刷新，下拉刷新下载比较当日JSON，下拉刷新，更新前一日内容———— MJRefresh控件+block，API。
3. 侧滑菜单————SWRevealViewController，有删改。
4. 登陆界面，官方分享窗口。
5. 点击内容页后，标记为已读，更改List表中字体颜色。Core Data记录。
6.内容页下拉放大————UIScrollviewDelegate，contentoffset.y。

##完善：
1.由于网速等原因，数次下载失败，在下次学习的过程中，进一步使用podfile依赖，不上传第三方库。
2.点击喜欢动画特效。
3.无WiFi保存功能。
