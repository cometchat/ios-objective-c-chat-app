//
//  NSError+Util.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "NSError+Util.h"

@implementation NSError (Util)
//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (NSError *)description:(NSString *)description code:(NSInteger)code
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSString *domain = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:description};
    return [NSError errorWithDomain:domain code:code userInfo:userInfo];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (NSString *)description
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    return self.userInfo[NSLocalizedDescriptionKey];
}
@end
