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
    if ([[self environment] isEqualToString:@"production"])
        return @"49cdcfa11fc03c08c79a509277e5e3cd6e04a9a5e2dd26c008d100cd5d1de8aa";
    else
        return @"390bc9941d98c7f5d87f5c3364f95d0672e02767ceb53a8767ff38971fe99020";
}

+ (NSString *) secret
{
    if ([[self environment] isEqualToString:@"production"])
        return @"2694065de13fe87f6350965ed0de6e91f53ac648ab9c7bbaade9ae29a4baa9c0";
    else
        return @"5f00bafd7d5390cfa5932f3e0bab2d7896aafea1c3e6d53339b2aa3b73fe4dca";
}
@end
