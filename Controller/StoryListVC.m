//
//  StoryListVC.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/10.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "StoryListVC.h"
#import "ContentVC.h"
#import "CustomCell.h"
#import "SWRevealViewController.h"
#import "StoryList.h"

#import "DataManager.h"
#import "AppDelegate.h"
#import "HeaderView.h"
#import "UIImageView+WebCache.h"

#import "MJRefresh.h"

@interface StoryListVC ()
@property (nonatomic, strong) HeaderView *headerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic, strong) NSManagedObjectContext *context;

@property (nonatomic, strong) NSString *before;
@property (nonatomic, strong) NSString *predate;

@property (nonatomic, strong) MJRefreshNormalHeader *header;
@end


@implementation StoryListVC

@synthesize fetchedResultsController = _fetchedResultsController;

#pragma mark -aboutTheView

- (void)viewDidLoad {
    [super viewDidLoad];
    //cell横线
    self.tableView.separatorStyle = NO;
    //侧边栏初始化,跳转方法绑定，添加手势识别，最后是菜单栏宽度
    self.barButton.target = self.revealViewController;
    self.barButton.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.revealViewController.rightViewRevealWidth = 100.0f;
    
    self.tableView.rowHeight = 125.00f;
    
    //插入滚动视图的frame，设置为tableview的头视图
    CGRect frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
    HeaderView *headerView = [[HeaderView alloc] initWithFrame:frame];
    self.tableView.tableHeaderView = headerView;
    
    [self performFetch];
    
    //下拉刷新
    __weak UITableView *tableView = self.tableView;
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[DataManager manager]downNetworking];
        [tableView.header endRefreshing];
    }];
    
    //上拉刷新
    tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [[DataManager manager]downPastDate:self.before];
        [self getPredate];
        [tableView.footer endRefreshing];
    }];
}

#pragma mark -today
- (NSString *)before{
    if (!_before) {
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMdd"];
        _before = [formatter stringFromDate:date];
    }
    return _before;
}

#pragma mark -Date affair
//转化日期文字表达
- (NSString *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat: @"yyyyMMdd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];

    [dateFormatter setDateFormat:@"yy年MM月dd日"];
    NSString *date = [dateFormatter stringFromDate:destDate];

    return date;
}

//转化为转化为下一天,nsstring格式
- (void)getPredate{
    NSString *strDate = self.before;
    
    NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYYMMdd"];
    NSDate *locationdate=[formatter dateFromString:strDate];
    NSDate *predate = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:locationdate];
    NSString *locationString = [formatter stringFromDate:predate];

    self.before = locationString;
}

#pragma mark - NSNotificationCenter
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector: @selector(contextDidSave:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:nil];
}

- (void)contextDidSave:(NSNotification*)notification{
    NSLog(@"contextDidSave Notification fired.");
    SEL selector = @selector(mergeChangesFromContextDidSaveNotification:);
    [self.context performSelectorOnMainThread:selector withObject:notification waitUntilDone:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -properties
- (void)performFetch
{
    NSError *error;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    if (!success) NSLog(@"[%@ %@] performFetch: failed", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    if (error) NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription], [error localizedFailureReason]);
}

- (NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    //context
    self.context = [DataManager manager].managedObjectContext;
    //fetch
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoryList" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"gaPrefix" ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    [fetchRequest setFetchBatchSize:20];

    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest                                                                                                 managedObjectContext:self.context
sectionNameKeyPath:@"date.dateString" cacheName:nil];
    //取出的分列是怎么做到排序的？date.dateString
    
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;

    return _fetchedResultsController;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (void)configureCell:(CustomCell*)cell atIndextPath:(NSIndexPath *)indexPath{
    
    StoryList *story = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",story.imageURL]];
    
    [cell.titleImageView sd_setImageWithURL:url];
    cell.titleName.text = story.title;
    //此处还是坑爹地方，CoreData的boolean是NSNumber，NSNumber为0，判断也为真，同一个类似坑。if(xx),当x为对象时，判断的是是否存在。
    if ([story.isRead isEqualToNumber:@1]) {
        cell.titleName.textColor = [UIColor grayColor];
    }else{
        cell.titleName.textColor = [UIColor blackColor];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    
    [self configureCell:cell atIndextPath:indexPath];
    
    return cell;
}

//固定高就直接设置好了，毕竟方法调用还是有计算成本的,虽然不多
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
//   return 125.0f;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *dateString = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter  alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *todayString = [dateFormatter stringFromDate:today];
    if ([dateString isEqualToString:todayString]) {
        return @"今日热门";
    }
    
    return [self dateFromString:dateString];
//    }
}

//当self.fetchedResultsController发生变化时，更新表格，先开放更新，然后根据不同的变化，进行不同的动作。
//配合NSNotificationCenter，当context变化时，更新FRC（缩写）
#pragma mark - fetchedRequestDelegate
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    NSLog(@"content change");
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{

    UITableView *tableView = self.tableView;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{

    UITableView *tableView = self.tableView;
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}

#pragma mark - Pass Key

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //获取点击cell的indexpath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    if ([segue.identifier isEqualToString:@"Content"]) {
        ContentVC *content = segue.destinationViewController;
        StoryList *cellStory = [self.fetchedResultsController objectAtIndexPath:indexPath];
        content.delegate = self;
        content.indexPath = indexPath;
        content.id = cellStory.id;
        NSLog(@"isRead : %@",cellStory.isRead);
    }
}

#pragma mark -delegate
- (void)changeTextColor:(NSIndexPath *)indexPath{

    [self updateStoryWith:indexPath];

}


//记录已读功能
//根据给的id，取出数据,更改属性，然后在使用context save ，保存，在cell for indexPath里面，根据属性选择字体颜色，防止复用时，把这个属性带入。
#pragma mark -Updatedata
- (void)updateStoryWith:(NSIndexPath *)indexPath{
    
    StoryList *story = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoryList" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@", story.id];
    [fetchRequest setPredicate:predicate];

    NSError *error = nil;
    NSArray *fetchedObjects = [self.context executeFetchRequest:fetchRequest error:&error];
    if ([fetchedObjects count] == 1) {
        StoryList *story = [fetchedObjects lastObject];
//        NSLog(@"title = %@",story.title);
        [story setIsRead:[NSNumber numberWithBool:YES]];
        NSError *upError = nil;
        if([self.context save:&upError]){
            NSLog(@"context update");
        }
    }else{
        NSLog(@"something wrong");
    }
}

@end
