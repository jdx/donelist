#import <Foundation/Foundation.h>
#import "Task.h"

@interface Day : NSObject {
    NSArray *tasks;
}

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSArray *tasks;

@end
