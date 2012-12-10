//
//  LoginViewController.h
//  110
//
//  Created by Jeff Dickey on 12/9/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "RestKit.h"
#import "KeychainItemWrapper.h"
#import "Task.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate> {
    NSManagedObjectContext *managedObjectContext;
    KeychainItemWrapper *keyWrapper;
    NSString *accessToken;
}

- (IBAction)loginPushed;
- (KeychainItemWrapper *)keyWrapper;
- (NSString *)accessToken;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) IBOutlet UITextField *usernameField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

@end
