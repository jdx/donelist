#import <UIKit/UIKit.h>
#import "Item.h"
#import "TaskListViewController.h"

@interface DayListViewController : UITableViewController
{
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController *fetchedResultsController;
}

- (void) fetchRecords;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end