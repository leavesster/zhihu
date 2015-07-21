//
//  HeaderView.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/13.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "HeaderView.h"


@interface HeaderView ()<UIScrollViewDelegate>

@end

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@synthesize scrollV = _scrollV;
@synthesize pageC = _pageC;

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect bigframe = frame;
        bigframe.size.width *= 2;

        _scrollV = [[UIScrollView alloc]initWithFrame:frame];
        _scrollV.contentSize = bigframe.size;
        _scrollV.pagingEnabled = YES;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.delegate = self;
        
        UIImageView *imageV1 = [[UIImageView alloc] initWithFrame:frame];
        imageV1.image = [UIImage imageNamed:@"screenshot1"];
        imageV1.contentMode = UIViewContentModeCenter;
        imageV1.clipsToBounds = YES;
        [_scrollV addSubview:imageV1];
        frame.origin.x = frame.size.width;
        
        UIImageView *imageV2 = [[UIImageView alloc] initWithFrame:frame];
        imageV2.image = [UIImage imageNamed:@"screenshot2"];
        imageV2.contentMode = UIViewContentModeCenter;
        imageV2.clipsToBounds = YES;
        [_scrollV addSubview:imageV2];
        
        [self addSubview:_scrollV];
        
        CGRect halfFrame = CGRectMake(CGRectGetMaxX(frame)/4 - 10, CGRectGetMaxY(frame) - 30 , 20, 20);
        _pageC = [[UIPageControl alloc] initWithFrame:halfFrame];
        [_pageC addTarget:self action:@selector(movePage) forControlEvents:UIControlEventValueChanged];
        _pageC.numberOfPages = 2;
        
        [self addSubview:_pageC];
    
    }
    return self;
}

- (void)movePage{
    NSInteger currentPage = self.pageC.currentPage;
    self.scrollV.contentOffset = CGPointMake((currentPage * [UIScreen mainScreen].bounds.size.width), 0);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = _scrollV.contentOffset.x / CGRectGetMidX(self.scrollV.frame);
    _pageC.currentPage = page;
}

@end
