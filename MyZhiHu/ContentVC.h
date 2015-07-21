//
//  ContentVC.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/12.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ContentVC : UIViewController

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *htmlString;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
- (IBAction)backTo:(UIBarButtonItem *)sender;
- (IBAction)favorite:(UIBarButtonItem *)sender;





@end