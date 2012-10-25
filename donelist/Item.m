//
//  Item.m
//  donelist
//
//  Created by Jeff Dickey on 10/24/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import "Item.h"


@implementation Item

@dynamic timestamp;
@dynamic title;

- (NSString *)day {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    
    return [dateFormatter stringFromDate:self.timestamp];
}

@end
