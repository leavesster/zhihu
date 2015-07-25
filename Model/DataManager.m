//
//  DataManager.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/10.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking.h"
#import <CoreData/CoreData.h>

#import "StoryList+Create.h"
#import "Story+Create.h"


@interface DataManager ()

@end

@implementation DataManager

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (DataManager *)manager{
    return [[DataManager alloc] init];
}


- (void)downNetworking{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://news-at.zhihu.com/api/4/news/latest" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self manageData:responseObject];
        NSLog(@"down success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}


- (void)downPastDate:(NSString *)date{
    NSString *pastDate = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/4/news/before/%@",date];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:pastDate parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self manageData:responseObject];
        NSLog(@"down success");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
    }];
}

//- (void)downURLString:(NSString *)urlString {
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        [self manageWebData:responseObject];
//        NSLog(@"down web success");
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }];
//}

- (void)manageWebData:(id)responseObject{
    [Story newStory:responseObject inManagedObjectContext:self.managedObjectContext];
    NSError *error = nil;
    [self.managedObjectContext save:&error];
}

- (void)manageData:(id)responseObject{
    
    NSString *dateString = responseObject[@"date"];
    NSArray *dict = responseObject[@"stories"];
    [StoryList loadStoryArray:dict withDate:dateString intoManagedObjectContext:self.managedObjectContext];
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"not save");
    }
}

- (void)deleteCoreData{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *en = [NSEntityDescription entityForName:@"StoryList" inManagedObjectContext:self.managedObjectContext];
    request.entity = en;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"gaPrefix" ascending:NO];
    request.sortDescriptors = @[sort];
    
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!results) {
        [NSException raise:@"Fecth Failed" format:@"Reason: %@",[error localizedDescription]];
    }
    if (!error && results && results.count) {
        for (StoryList *story in results) {
            [self.managedObjectContext deleteObject:story];
        }
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"error:%@",[error localizedDescription]);
        }
    }
}



#pragma mark -properties
//属性，三个连贯设置
//model
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyZhiHu" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

//context.persistent.....
- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:[self persistentStoreCoordinator]];
    return _managedObjectContext;
}

//persis.model = .....
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    NSURL *storeURL = [[self applicationDocumentsURL] URLByAppendingPathComponent:@"MyZhiHu.sqlite"];
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"ERROR: %@", [error localizedDescription]);
    }
    return _persistentStoreCoordinator;
}

#pragma mark -
//返回文档位置
- (NSURL *)applicationDocumentsURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//存储context
- (void)saveContext{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"ERROR: %@", [error localizedDescription]);
            abort();
        }
        NSLog(@"Save success");
    }
}

@end
