//
//  CustomCell.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/10.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *containView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

@end
