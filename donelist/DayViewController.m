//
//  DayViewController.m
//  110
//
//  Created by Jeff Dickey on 12/10/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import "DayViewController.h"

@interface DayViewController ()

@end

@implementation DayViewController

@synthesize day;
@synthesize label;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    label.text = day.description;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
