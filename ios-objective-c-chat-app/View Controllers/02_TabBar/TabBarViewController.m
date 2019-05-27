//
//  TabBarViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "TabBarViewController.h"
@interface TabBarViewController ()

@end

@implementation TabBarViewController
{
    HexToRGBConvertor *hexToRgb;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    hexToRgb = [HexToRGBConvertor new];
    
    [[UITabBar appearance] setTintColor:[hexToRgb colorWithHexString:@"#2636BE"]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setBadge:) name:@"com.inscripts.updateBadge" object:nil];
}
-(void)setBadge:(id)sender
{
    NSString *badgeValue = [NSString stringWithFormat:@"%ld",[[[self.tabBar.items objectAtIndex:0] badgeValue] integerValue] + 1 ];
    [[self.tabBar.items objectAtIndex:0]setBadgeValue:badgeValue];
}

@end

