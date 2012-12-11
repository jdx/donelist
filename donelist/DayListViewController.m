#import "DayListViewController.h"

@interface DayListViewController ()

@end

@implementation DayListViewController

@synthesize tasks;
@synthesize accessToken;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = TRUE;
    [self fetchRecords];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Task *row = [tasks objectAtIndex:indexPath.row];
    cell.textLabel.text = row.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"selectDay" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"selectDay"])
    {
//        Task *item = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
//        TaskListViewController *taskListVC = [segue destinationViewController];
//        taskListVC.managedObjectContext = self.managedObjectContext;
//        taskListVC.delegate = self;
//        taskListVC.day = item.day;
    }
    else if ([[segue identifier] isEqualToString:@"addItem"])
    {
        AddItemViewController *addItemViewController = [segue destinationViewController];
        addItemViewController.delegate = self;
    }
}

- (void)itemAdded:(NSString *)title
{
    Task *item = [[Task alloc] init];
    item.title = title;
    //item.timestamp = [NSDate date];
    [self fetchRecords];
}

- (void)fetchRecords
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Task class]];
    [mapping addAttributeMappingsFromArray:@[@"title"]];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    
    RKResponseDescriptor *taskDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:nil keyPath:@"tasks" statusCodes:statusCodes];
    
    RKObjectManager *manager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:@"http://110.dickey.xxx"]];
    
    [manager addResponseDescriptorsFromArray:@[ taskDescriptor ]];
    
    NSDictionary *params = @{ @"access_token": self.accessToken };
    [manager getObjectsAtPath:@"/api/tasks.json" parameters:params success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        tasks = [mappingResult array];
        NSLog(@"tasks: %@", tasks);
        [self.tableView reloadData];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Failed with error: %@", [error localizedDescription]);
    }];
}

- (void)taskListViewClosed
{
    [self fetchRecords];
}

@end