#import "DayListViewController.h"

@interface DayListViewController ()

@end

@implementation DayListViewController

@synthesize managedObjectContext;
@synthesize fetchedResultsController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchRecords];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[fetchedResultsController sections] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Item *row = [fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = row.day;
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
        Item *item = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        TaskListViewController *taskListVC = [segue destinationViewController];
        taskListVC.managedObjectContext = self.managedObjectContext;
        taskListVC.delegate = self;
        taskListVC.day = item.day;
    }
    else if ([[segue identifier] isEqualToString:@"addItem"])
    {
        AddItemViewController *addItemViewController = [segue destinationViewController];
        addItemViewController.delegate = self;
    }
}

- (void)itemAdded:(NSString *)title
{
    Item *item = (Item *)[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:managedObjectContext];
    item.title = title;
    item.timestamp = [NSDate date];
    [self.managedObjectContext save:nil];
    [self fetchRecords];
}

- (void)fetchRecords
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"timestamp"
                                                                                     ascending:NO
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:@"day"
                                                                                   cacheName:@"Rows"];
    [fetchedResultsController performFetch:nil];
    [self.tableView reloadData];
}

- (void)taskListViewClosed
{
    [self fetchRecords];
}

@end