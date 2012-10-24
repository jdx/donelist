//
//  AddItemViewController.h
//  donelist
//
//  Created by Jeff Dickey on 10/23/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AddItemViewControllerDelegate
@required
- (void)itemAdded:(NSString *)item;
@end


@interface AddItemViewController : UITableViewController {
    IBOutlet UITextField *doneTextField;
    IBOutlet UIBarButtonItem *saveButton;
    id <AddItemViewControllerDelegate> delegate;
}
- (IBAction)donePushed;
- (IBAction)doneTextFieldUpdated;

@property (nonatomic, retain) IBOutlet UITextField *doneTextField;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *saveButton;
@property (nonatomic, retain) id <AddItemViewControllerDelegate> delegate;

@end

