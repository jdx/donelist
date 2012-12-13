#import "Constants.h"

@implementation Constants

+ (NSString *) environment
{
    // return @"production";
    return @"development";
}

+ (NSString *) hostname
{
    if ([[self environment] isEqualToString:@"production"])
        return @"http://110.dickey.xxx";
    else
        return @"http://127.0.0.1:3000";
}

+ (NSString *) key
{
        return @"49cdcfa11fc03c08c79a509277e5e3cd6e04a9a5e2dd26c008d100cd5d1de8aa";
}

+ (NSString *) secret
{
        return @"2694065de13fe87f6350965ed0de6e91f53ac648ab9c7bbaade9ae29a4baa9c0";
}
@end
