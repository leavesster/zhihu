//
//  DataManager.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/10.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryList.h"

@interface DataManager : NSObject

+ (DataManager *)manager;
- (void)downNetworking;
//- (void)downURLString:(NSString *)urlString;
- (void)deleteCoreData;
- (void)downPastDate:(NSString *)date;

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@end
