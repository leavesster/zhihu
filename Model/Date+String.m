//
//  Date+String.m
//  MyZhiHu
//
//  Created by yleaf on 15/7/17.
//  Copyright (c) 2015年 yleaf. All rights reserved.
//

#import "Date+String.h"

@implementation Date (String)

+ (Date *)dateFromInfo:(NSString *)datestring inManagedObjectContext:(NSManagedObjectContext *)context{
    Date *date = nil;
    if (!datestring) {
        NSLog(@"no");
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Date" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"dateString = %@", datestring];
    [fetchRequest setPredicate:predicate];
    // Specify how the fetched objects should be sorted
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateString"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    if (fetchedObjects == nil || error || [fetchedObjects count] > 1) {
        NSLog(@"Error : fetch object from DB error");
    } else if ([fetchedObjects count]) {
        return [fetchedObjects firstObject];
    } else {
        date = [NSEntityDescription insertNewObjectForEntityForName:@"Date" inManagedObjectContext:context];
        date.dateString = datestring;
    }
    return date;
}

@end
