//
//  StoryList+Create.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/17.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "StoryList.h"
#import "Date+String.h"


@interface StoryList (Create)

+ (StoryList *)storyFromInfo:(NSDictionary *)dictionary withDate:(NSString *)date inManagedObjectContext:(NSManagedObjectContext *)context;

+ (void)loadStoryArray:(NSArray *)storylists withDate:(NSString *)date intoManagedObjectContext:(NSManagedObjectContext *)context;

@end
