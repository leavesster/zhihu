//
//  AppDelegate.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/10.
//  Copyright (c) 2015年 yleaf. All rights reserved.

#import "AppDelegate.h"
#import "StoryList.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "UIImageView+WebCache.h"
#import "DataManager.h"

@interface AppDelegate ()
@property (nonatomic, strong) UIView *launchView;
@property (nonatomic, strong) NSString *string;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = true;
    [[DataManager manager] downNetworking];
    [self.window makeKeyAndVisible];
    
    self.launchView = [[[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:nil options:nil] firstObject];
    self.launchView.frame = self.window.frame;
    NSString *url= @"http://news-at.zhihu.com/api/4/start-image/1080*1776";
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = self.window.frame;
    
    [self.launchView addSubview:imageV];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *string = responseObject[@"img"];
        [imageV sd_setImageWithURL:[NSURL URLWithString:string]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [self.window addSubview:self.launchView];
    [self.window bringSubviewToFront:self.launchView];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLaunch) userInfo:nil repeats:NO];

    return YES;
}

- (void)removeLaunch{
    [self.launchView removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[DataManager manager]saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [[DataManager manager]saveContext];
}

@end
