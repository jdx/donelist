//
//  AddItemViewController.m
//  donelist
//
//  Created by Jeff Dickey on 10/23/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()

@end

@implementation AddItemViewController

@synthesize delegate;
@synthesize doneTextField;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePushed {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [delegate itemAdded:doneTextField.text];
}

@end
