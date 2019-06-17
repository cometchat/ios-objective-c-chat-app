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
    [self setBadgeForContactsTab];
    [self setBadgeForGroupsTab];
    hexToRgb = [HexToRGBConvertor new];
    
    [[UITabBar appearance] setTintColor:[hexToRgb colorWithHexString:@"#2636BE"]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
}

-(void)setBadgeForContactsTab {
    
    [CometChatProRequests getUnreadCountForAllUsers:@"" onSuccess:^(NSDictionary * _Nonnull success) {
        NSLog(@"getUnreadCountForAllUsers success: %@",success);
    
        NSString *badgeValue = [NSString stringWithFormat:@"%ld",success.count];
         dispatch_async(dispatch_get_main_queue(), ^(){
             [[self.tabBar.items objectAtIndex:0]setBadgeValue:badgeValue];
         });
    } andError:^(CometChatException * _Nonnull error) {
        NSLog(@"error: %@",error.debugDescription);
    }];
   
}

-(void)setBadgeForGroupsTab {
    
    [CometChatProRequests getUnreadCountForAllGroups:@"" onSuccess:^(NSDictionary * _Nonnull success) {
        NSLog(@"getUnreadCountForAllGroups success : %@",success);
        NSString *badgeValue = [NSString stringWithFormat:@"%ld",success.count];
        dispatch_async(dispatch_get_main_queue(), ^(){
            [[self.tabBar.items objectAtIndex:1]setBadgeValue:badgeValue];
        });
    } andError:^(CometChatException * _Nonnull error) {
        NSLog(@"error: %@",error.debugDescription);
    }];
}



@end

