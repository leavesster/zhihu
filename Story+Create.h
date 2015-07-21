//
//  Story+Create.h
//  MyZhiHu
//
//  Created by yleaf on 15/7/19.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "Story.h"

@interface Story (Create)

+ (Story *)newStory:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context;

@end
