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

@interface TaskListViewController : UITableViewController<AddItemViewControllerDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    NSString *day;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void) fetchRecords;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSString *day;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end