//
//  RegisterVC.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/20.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "RegisterVC.h"

//#import "IQKeyboardManager.h"
//#import "IQSegmentedNextPrevious.h"

@interface RegisterVC ()<UITextFieldDelegate,UIAlertViewDelegate>
- (IBAction)anonymity:(id)sender;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName.delegate = self;
    self.password.delegate = self;
//    [IQKeyboardManager sharedManager].enable = YES;

    [self.userName becomeFirstResponder];
    [self.userName addTarget:self action:@selector(next:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.password addTarget:self action:@selector(next:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}

- (void)hideKeyboard{
    [self.userName resignFirstResponder];
    [self.password resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)next:(UITextField *)sender{
    if (sender == self.userName) {
        [self.userName resignFirstResponder];
        [self.password becomeFirstResponder];
    }else if (sender == self.password){
        [self.password resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 
 self.userName = nil;
 self.password = nil;
 [self dismissViewControllerAnimated:YES completion:nil];
}
*/

- (IBAction)anonymity:(id)sender {
    if (!self.userName.text && !self.password.text) {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"things are null");
        }];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"确认信息" message:@"确认后输入信息会被删除" delegate:self cancelButtonTitle:@"取消：继续输入账号密码" otherButtonTitles:@"确认：匿名使用", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            NSLog(@"继续输入");
            break;
        case 1:
            self.userName = nil;
            self.password = nil;
            [self dismissViewControllerAnimated:YES completion:^{
                NSLog(@"quit");
            }];
        default:
            break;
    }
}

@end
