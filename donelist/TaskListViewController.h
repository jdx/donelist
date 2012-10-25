//
//  TaskListViewController.h
//  donelist
//
//  Created by Jeff Dickey on 10/23/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"
#import "Item.h"

@interface TaskListViewController : UITableViewController<AddItemViewControllerDelegate, NSFetchedResultsControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    NSArray *items;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void) fetchRecords;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end