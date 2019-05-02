//
//  AppSettings.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 01/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppSettings.h"


@interface AppSettings()
@end

@implementation AppSettings
{
    HexToRGBConvertor *hexToRgb;
}
@synthesize navigationBarColor = _naviagtionbarcolor;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource: @"CometChat-info" ofType:@"plist"];
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSLog(@"%@",dict);
        hexToRgb = [HexToRGBConvertor new];
    }
    return self;
}
-(void)print
{
    NSLog(@"something");
}

@end
