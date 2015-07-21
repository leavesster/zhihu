//
//  HeaderView.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/13.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect bigframe = frame;
        bigframe.size.width *= 2;

        UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:frame];
        scroll.contentSize = bigframe.size;
        scroll.pagingEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
    
        
        UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:frame];
        imageV1.image = [UIImage imageNamed:@"screenshot1"];
        imageV1.contentMode = UIViewContentModeCenter;
        imageV1.clipsToBounds = YES;
        [scroll addSubview:imageV1];
        
        frame.origin.x = frame.size.width;
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:frame];
        imageV2.image = [UIImage imageNamed:@"screenshot2"];
        imageV2.contentMode = UIViewContentModeCenter;
        imageV2.clipsToBounds = YES;
        [scroll addSubview:imageV2];
        
        [self addSubview:scroll];
    
    }
    return self;
}



@end
