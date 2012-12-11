#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskListViewController.h"
#import "AddItemViewController.h"
#import "RestKit.h"

@interface DayListViewController : UITableViewController<AddItemViewControllerDelegate, TaskListViewDelegate> {
    NSArray *tasks;
    NSString *accessToken;
}

- (void) fetchRecords;
- (void) taskListViewClosed;

@property (nonatomic, retain) NSArray *tasks;
@property (nonatomic, retain) NSString *accessToken;

@end