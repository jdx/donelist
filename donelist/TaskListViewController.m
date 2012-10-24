//
//  TaskListViewController.m
//  donelist
//
//  Created by Jeff Dickey on 10/23/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import "TaskListViewController.h"

@interface TaskListViewController ()

@end

@implementation TaskListViewController

@synthesize managedObjectContext;
@synthesize fetchedResultsController;
@synthesize items;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self fetchRecords];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addNewItem:sender {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    Item *row = [items objectAtIndex:indexPath.item];
    cell.textLabel.text = row.title;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Item *item = [items objectAtIndex:indexPath.item];
        [self.managedObjectContext deleteObject:item];
        [self.managedObjectContext save:nil];
        [self fetchRecords];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"addItem"])
    {
        AddItemViewController *addItemViewController = [segue destinationViewController];
        addItemViewController.delegate = self;
    }
}

- (void)itemAdded:(NSString *)title
{
    Item *item = (Item *)[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:managedObjectContext];
    item.title = title;
    [self.managedObjectContext save:nil];
    [self fetchRecords];
}

- (void)fetchRecords
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    items = [managedObjectContext executeFetchRequest:request error:nil];
    [self.tableView reloadData];
}

@end