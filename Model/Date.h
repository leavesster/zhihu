//
//  Date.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/18.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class StoryList;

@interface Date : NSManagedObject

@property (nonatomic, retain) NSString * dateString;
@property (nonatomic, retain) NSSet *lists;
@end

@interface Date (CoreDataGeneratedAccessors)

- (void)addListsObject:(StoryList *)value;
- (void)removeListsObject:(StoryList *)value;
- (void)addLists:(NSSet *)values;
- (void)removeLists:(NSSet *)values;

@end
