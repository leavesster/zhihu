//
//  StoryList.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/18.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Date;

@interface StoryList : NSManagedObject

@property (nonatomic, retain) NSString * gaPrefix;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSNumber * isRead;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Date *date;

@end
