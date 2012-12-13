#import "DayListPageViewController.h"

@interface DayListPageViewController ()

@end

@implementation DayListPageViewController

@synthesize days;
@synthesize accessToken;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = TRUE;
    self.dataSource = self;

    RKObjectMapping *taskMapping = [RKObjectMapping mappingForClass:[Task class]];
    [taskMapping addAttributeMappingsFromArray:@[@"title"]];
    RKObjectMapping *dayMapping = [RKObjectMapping mappingForClass:[Day class]];
    [dayMapping addAttributeMappingsFromArray:@[@"date"]];
    [dayMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"tasks" toKeyPath:@"tasks" withMapping:taskMapping]];
    
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
    RKResponseDescriptor *taskDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:dayMapping pathPattern:nil keyPath:nil statusCodes:statusCodes];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:[Constants hostname]]];
    
    [manager addResponseDescriptorsFromArray:@[ taskDescriptor ]];
    
    NSDictionary *params = @{ @"access_token": self.accessToken };
    [manager getObjectsAtPath:@"/api/days.json" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        days = [mappingResult array];
        NSLog(@"tasks: %@", days);
        [self setViewControllers:@[ [self viewControllerAtIndex:0] ] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (DayViewController *)viewControllerAtIndex:(NSUInteger)index
{
    DayViewController *dayVC = [[DayViewController alloc] initWithNibName:@"DayViewController" bundle:nil];
    dayVC.day = [self.days objectAtIndex:index];
    return dayVC;
}

- (NSUInteger)indexOfViewController:(DayViewController *)viewController
{
    return [self.days indexOfObject:viewController.day];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DayViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DayViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.days count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end
