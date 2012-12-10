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

@synthesize managedObjectContext;
@synthesize usernameField;
@synthesize passwordField;

- (void)viewDidLoad
{
    [super viewDidLoad];
    usernameField.text = [self.keyWrapper objectForKey:(__bridge id)kSecAttrAccount];
    passwordField.text = [self.keyWrapper objectForKey:(__bridge id)kSecValueData];
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
    NSString *clientID = @"49cdcfa11fc03c08c79a509277e5e3cd6e04a9a5e2dd26c008d100cd5d1de8aa";
    NSString *clientSecret= @"2694065de13fe87f6350965ed0de6e91f53ac648ab9c7bbaade9ae29a4baa9c0";
    NSURL *tokenUrl = [NSURL URLWithString:@"http://110.dickey.xxx/oauth/token"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:tokenUrl];
    request.HTTPMethod = @"POST";
    NSString *params = [NSString stringWithFormat:@"grant_type=password&username=%@&password=%@&client_id=%@&client_secret=%@", usernameField.text, passwordField.text, clientID, clientSecret];
    request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        accessToken = [JSON objectForKey:@"access_token"];
        [self getShit];
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
    id vc = [segue destinationViewController];
    [vc setManagedObjectContext:self.managedObjectContext];
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

- (void)getShit
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Task class]];
    [mapping addAttributeMappingsFromArray:@[@"title"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
    RKResponseDescriptor *taskDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:nil keyPath:@"tasks" statusCodes:statusCodes];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://110.dickey.xxx"]];
    
    [manager addResponseDescriptorsFromArray:@[ taskDescriptor ]];
    
    NSDictionary *params = @{ @"access_token": self.accessToken };
    [manager getObjectsAtPath:@"/api/tasks.json" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        Task *task = [[mappingResult array] objectAtIndex:0];
        NSLog(@"Mapped the task: %@", task.title);
        NSLog(@"tasks: %@", [mappingResult array]);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
}


@end
