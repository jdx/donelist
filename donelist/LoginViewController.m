//
//  LoginViewController.m
//  110
//
//  Created by Jeff Dickey on 12/9/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameField;
@synthesize passwordField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    usernameField.text = [self.keyWrapper objectForKey:(__bridge id)kSecAttrAccount];
    passwordField.text = [self.keyWrapper objectForKey:(__bridge id)kSecValueData];
    [self loginPushed];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self loginPushed];
    return YES;
}

- (IBAction)loginPushed
{
    NSURL *tokenUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/oauth/token", [Constants hostname]]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tokenUrl];
    request.HTTPMethod = @"POST";
    NSString *params = [NSString stringWithFormat:@"grant_type=password&username=%@&password=%@&client_id=%@&client_secret=%@", usernameField.text, passwordField.text, [Constants key], [Constants secret]];
    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        accessToken = [JSON objectForKey:@"access_token"];
        [self.keyWrapper setObject:usernameField.text forKey:(__bridge id)kSecAttrAccount];
        [self.keyWrapper setObject:passwordField.text forKey:(__bridge id)kSecValueData];
        [self performSegueWithIdentifier:@"showDashboard" sender:self];

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Credentials" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }];
    [operation start];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DayListPageViewController *vc = [segue destinationViewController];
    vc.accessToken = self.accessToken;
}

- (KeychainItemWrapper *)keyWrapper
{
    if (!keyWrapper) {
        keyWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"onetenLoginData" accessGroup:nil];
    }
    return keyWrapper;
}

- (NSString *)accessToken
{
    return accessToken;
}



@end
