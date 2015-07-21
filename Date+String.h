//
//  Date+String.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/17.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "Date.h"

@interface Date (String)

+ (Date *)dateFromInfo:(NSString *)datestring inManagedObjectContext:(NSManagedObjectContext *)context;

@end
