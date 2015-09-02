# ZhiHuDemo
The first demo that two week's job.

##涉及内容参考自：
·UITableView+NSFetchedResultsController————stanford open class
—_—
·[webview中HTML格式参考](https://github.com/gnou/FakeZhihuDaily)其他地方也有点像……但我的扩展了更多，不一样了。
<br>
·[APIs](https://github.com/izzyleung/ZhihuDailyPurify/wiki/%E7%9F%A5%E4%B9%8E%E6%97%A5%E6%8A%A5-API-%E5%88%86%E6%9E%90)

##实现功能：
1. 保存数据（限于首页列表）
2. 列表内容有更改自动刷新<br>NSFetchedResultsController，从开始使用类转化JSON，到单纯CoreData，再到最后配合NSFetchedResultsController，CoreData框架消耗时间最多。
3. 下拉刷新以及下拉刷新，下拉刷新下载比较当日JSON，下拉刷新，更新前一日内容<br> MJRefresh控件+block，API。
4. 侧滑菜单<br>SWRevealViewController，有删改。
5. 登陆界面，官方分享窗口
6. 记录已读界面，更改List表中字体颜色<br>Core Data记录，可存档。
7. 内容页下拉放大<br>UIScrollviewDelegate，contentoffset.y。

##完善：
1. 由于网速等原因，数次下载失败,已更改为cocoapods依赖。
<!--2. 点击喜欢动画特效。-->
