//
//  DayViewController.h
//  110
//
//  Created by Jeff Dickey on 12/10/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"

@interface DayViewController : UIViewController
{
    Day *day;
}

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) Day *day;
@end
