//
//  AppDelegate.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[CometChat alloc]initWithAppId:@APP_ID onSuccess:^(BOOL isSuccess) {
        
        // Successfully init CometChat
        NSLog(isSuccess ? @"YES" : @"NO");
        
        CometChat.messagedelegate = self;
        CometChat.userdelegate    = self;
        CometChat.groupdelegate   = self;
        CometChat.calldelegate    = self;
        [[CallManager sharedInstance] setDelegate:self];
        
        [self switchViewControllerIfLoggedIn];
        
        
    } onError:^(CometChatException * error) {
        // Error in init CometChat
        NSLog(@"Error %@",[error errorDescription]);
    }];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - Switch View According to User Logged In or Not

-(void)switchViewControllerIfLoggedIn{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@IS_LOGGED_IN]) {
        
        TabBarViewController *tabBarViewController = [storyboard instantiateViewControllerWithIdentifier:@"TabBarViewController"];
        [app.window setRootViewController:tabBarViewController];
        tabBarViewController = nil;
        
    } else {
        
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [app.window setRootViewController:loginViewController];
        loginViewController = nil;
    }
}



@end
