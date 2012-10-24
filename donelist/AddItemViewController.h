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


@interface AddItemViewController : UIViewController {
    IBOutlet UITextField *doneTextField;
    id <AddItemViewControllerDelegate> delegate;
}
- (IBAction)donePushed;

@property (nonatomic, retain) IBOutlet UITextField *doneTextField;
@property (nonatomic, retain) id <AddItemViewControllerDelegate> delegate;

@end

