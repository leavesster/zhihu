//
//  StoryList+Create.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/17.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//


#import "StoryList+Create.h"

@implementation StoryList (Create)

//先查询是否重复；如果重复，则返回数据库中的数据，不修改context；如果不重复，新增实体数据，在context中插入数据。外部引用该方法时，可以达到只写入数据库内不存在的数据
+ (StoryList *)storyFromInfo:(NSDictionary *)dictionary withDate:(NSString *)dateString inManagedObjectContext:(NSManagedObjectContext *)context{
    
    StoryList *story = nil;
    
    //以下有代码块，直接打fetch下拉，可以快捷输入，知道的有点晚
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoryList" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@", dictionary[@"id"]];
    //此处的唯一标识是重点。开始是%d，可能是因为字典转换过来的是字符串，而非字典，所以导致永远没有存成一样的数据类型，也可能是NSPredicate的要求。
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted

    //其实一次只取出一个，没什么好排序的
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    //取出的results数组，单独取出这个数组的情况下，不知道为什么，有几个案例是在后面用for entityclass *item in results ，一个个遍历，然后再把遍历的项目一个个加到一个可变数组中，然后返回可变数组，不这么做，没法获取实体的属性，只能直接打印一大串内容，挺奇怪的。
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil || error || [fetchedObjects count] > 1) {
        //结果数组不存在(意味提取数组的过程中发现错误，而不是提取的数组为空)，或有错误，或者数据多于1个（数据库本身就有重复，说明唯一标识不对）。三者为任意一个成立，即执行该条件语句
        //nil表示对象不存在，0表示为空，初始化基本类型时，值是乱跳的。
        //反正还是有点点小乱吧。
        NSLog(@"Error : fetch object from DB error");
    } else if ([fetchedObjects count]) {
        //存在数据，且只有一个
//        NSLog(@"存在数据");
        //数据存在，直接返回,context的内容没有变化
    } else {
        story = [NSEntityDescription insertNewObjectForEntityForName:@"StoryList" inManagedObjectContext:context];
        //没有数据，给的数据就是新数据，所以要对context进行新增。
        story.id = dictionary[@"id"];
        story.title = dictionary[@"title"];
        story.gaPrefix = dictionary[@"ga_prefix"];
        story.imageURL = dictionary[@"images"][0];
        story.date = [Date dateFromInfo:(NSString *)dateString inManagedObjectContext:context];
//        NSLog(@"新增数据");
    }
    
    return story;
}

//批量处理，比较耗内存，最好可以优化成其他，好像记得字典说明的是哈希算法，很快
+ (void)loadStoryArray:(NSArray *)storylists withDate:(NSString *)dateString intoManagedObjectContext:(NSManagedObjectContext *)context{
    for (NSDictionary *dict in storylists) {
        [self storyFromInfo:dict withDate:dateString inManagedObjectContext:context];
    }
}

@end
