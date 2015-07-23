//
//  ContentVC.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/12.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "ContentVC.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

#import "DataManager.h"




@interface ContentVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSString *string;
@property (nonatomic, strong) UIView *topView;

- (IBAction)share:(UIBarButtonItem *)sender;


@end

@implementation ContentVC

@synthesize topView = _topView;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //push推送方式下，隐藏导航栏的方式
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backTo:)];
    panGesture.maximumNumberOfTouches = 1;

    self.string = [NSString stringWithFormat:@"http://news-at.zhihu.com/api/3/news/%@",self.id];

    [self netWorking];
//    self.webView.scalesPageToFit = YES;
    [self.webView.scrollView addSubview:self.imageV];
    self.webView.scrollView.delegate = self;

}

#pragma mark -properties
- (UIImageView *)imageV{
    if (!_imageV) {
        //代码写一个imageview的界面，image网址默认
        _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        self.imageV.contentMode = UIViewContentModeScaleAspectFill;
        self.imageV.clipsToBounds = YES;
        //文件只露出在frame的部分，不多显示多出的部分
        [self.indicator stopAnimating];
    }
    return _imageV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -networking
- (void)netWorking{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:self.string parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.imageURL = responseObject[@"image"];
        NSURL *url = [NSURL URLWithString:self.imageURL];
        [self.imageV sd_setImageWithURL:url];

        NSString *htmlBodyString = responseObject[@"body"];
        NSString *cssURLString = responseObject[@"css"][0];
        self.htmlString = [NSString stringWithFormat:@"<html><head><link rel=\"stylesheet\" type=\"text/css\" href=%@ /></head><body>%@</body></html>", cssURLString, htmlBodyString];
        [self.webView loadHTMLString:self.htmlString baseURL:nil];
//        NSLog(@"html = %@",self.htmlString);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark -delegate

//根据下拉效果，放大图片，图片保持按优先满足缩放的比例，不断放大imageview的frame
//在显示文字的节点位置，制作一个状态栏长宽的背景，减少文字阅读时状态栏的遮盖
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint offset = scrollView.contentOffset;
    
    if (offset.y < 0) {
        CGRect rect = self.imageV.frame;
        rect.origin.y = offset.y;
        rect.size.height = 200 - offset.y;
        self.imageV.frame = rect;
        self.imageV.contentMode = UIViewContentModeScaleAspectFill;
        self.imageV.clipsToBounds = YES;
    }else if(offset.y > 200 && !self.topView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        view.backgroundColor = [UIColor whiteColor];
        self.topView = view;
        [self.view addSubview:self.topView];
            NSLog(@"created");
        }else if(offset.y <=200 && self.topView != nil) {
            [self.topView removeFromSuperview];
            self.topView = nil;
            NSLog(@"it works");
    }
}


#pragma mark -actions

- (IBAction)backTo:(UIBarButtonItem *)sender {
    [self.delegate changeTextColor:self.indexPath];
    NSLog(@"delegate here");
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

- (IBAction)favorite:(UIBarButtonItem *)sender {
    static NSString *click = nil;
    if (!click) {
        sender.image = [UIImage imageNamed:@"favorite"];
        click = @"1";
    }else{
        sender.image = [UIImage imageNamed:@"unfavorite"];
        click = nil;
    }

}



- (IBAction)share:(UIBarButtonItem *)sender {
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"share" message:@"it's fine" preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:cancel];
//    [self presentViewController:alert animated:YES completion:nil];
    
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:@[@"one",@"two"] applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:^{
        NSLog(@"present is OK");
    }];
}
@end
