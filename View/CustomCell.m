//
//  CustomCell.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/10.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (void)awakeFromNib {
    // Initialization code
    //弧度 CGFloat
    _containView.layer.cornerRadius = 5;
    //阴影颜色，CGColorRef
    _containView.layer.shadowColor=[UIColor blackColor].CGColor;
    _containView.layer.shadowOffset=CGSizeMake(0,0);
    _containView.layer.shadowOpacity= 0.2;//透明度
    _containView.layer.shadowRadius= 2;//阴影弧度

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
