//
//  Item.h
//  donelist
//
//  Created by Jeff Dickey on 10/24/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSString * title;

- (NSString *)day;

@end
