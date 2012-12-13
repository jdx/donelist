//
//  PageViewController.h
//  110
//
//  Created by Jeff Dickey on 12/10/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayViewController.h"
#import "RestKit.h"
#import "Task.h"
#import "Day.h"
#import "Constants.h"

@interface DayListPageViewController : UIPageViewController<UIPageViewControllerDataSource>
{
    NSArray *days;
    NSString *accessToken;
}

@property (nonatomic, retain) NSArray *days;
@property (nonatomic, retain) NSString *accessToken;

@end
