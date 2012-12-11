#import "Day.h"

@implementation Day

@synthesize date;
@synthesize tasks;

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ (%d tasks)", date.description, tasks.count];
}

@end
