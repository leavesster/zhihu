//
//  Story+Create.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/19.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "Story+Create.h"
//category
@implementation Story (Create)

+ (Story *)newStory:(NSDictionary *)dict inManagedObjectContext:(NSManagedObjectContext *)context{
    Story *story= nil;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Story" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id = %@", dict[@"id"]];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil || error || [fetchedObjects count] > 1) {
        NSLog(@"ERROR");
    }else if ([fetchedObjects count]){
        return [fetchedObjects firstObject];
    }else{
        story = [NSEntityDescription insertNewObjectForEntityForName:@"Story" inManagedObjectContext:context];
        story.id = dict[@"id"];
        story.body = dict[@"body"];
        story.css = [dict[@"css"] firstObject];
        story.imageURL = dict[@"imageURL"];
        story.gaPrefix = dict[@"ga_prefix"];
    }
    return story;
}

@end
