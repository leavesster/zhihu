//
//  StoryListVC.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/10.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//
#import <CoreData/CoreData.h>
#import <UIKit/UIKit.h>

@interface StoryListVC : UITableViewController <NSFetchedResultsControllerDelegate>

@property BOOL debug;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end