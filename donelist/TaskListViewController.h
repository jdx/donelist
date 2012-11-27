//
//  TaskListViewController.h
//  donelist
//
//  Created by Jeff Dickey on 10/23/12.
//  Copyright (c) 2012 dickeyxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@protocol TaskListViewDelegate
@required
- (void)taskListViewClosed;
@end

@interface TaskListViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
    NSString *day;
    id <TaskListViewDelegate> delegate;
}

- (void) fetchRecords;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSString *day;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) id <TaskListViewDelegate> delegate;

@end