#import <UIKit/UIKit.h>
#import "Item.h"
#import "TaskListViewController.h"
#import "AddItemViewController.h"

@interface DayListViewController : UITableViewController<AddItemViewControllerDelegate, TaskListViewDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}

- (void) fetchRecords;
- (void) taskListViewClosed;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end