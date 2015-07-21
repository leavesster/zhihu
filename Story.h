//
//  Story.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/19.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Story : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * gaPrefix;
@property (nonatomic, retain) NSString * body;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * css;

@end
