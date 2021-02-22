//
//  AppDelegate.m
//  ios-objective-c-chat-app
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConstants.h"
#import <CometChatPro/CometChatPro-Swift.h>
#define ROOTVIEW [[[UIApplication sharedApplication] keyWindow] rootViewController]
@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if ([CometChat getLoggedInUser] != nil) {
        
        CometChat.calldelegate = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController * mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:mainVC];
            navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
            navigationController.title = @"CometChat KitchenSink";
            navigationController.navigationBar.prefersLargeTitles = YES;
            [ROOTVIEW presentViewController:navigationController animated:YES completion:^{}];
        });
    }
    
    [self initialization];
    return YES;
    
}

- (void)onIncomingCallReceivedWithIncomingCall:(Call *)incomingCall error:(CometChatException *)error{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CometChatIncomingCall *incomingCallScreen = [[CometChatIncomingCall alloc]init];
        [incomingCallScreen setCallWithCall:incomingCall];
        [ROOTVIEW presentViewController:incomingCallScreen animated:YES completion:^{}];
        });
    [CometChatCallManager.incomingCallDelegate onIncomingCallReceivedWithIncomingCall:incomingCall error:error];
}

- (void)onOutgoingCallRejectedWithRejectedCall:(Call *)rejectedCall error:(CometChatException *)error{
    
    [CometChatCallManager.outgoingCallDelegate onOutgoingCallRejectedWithRejectedCall:rejectedCall error:error];
}

- (void)onIncomingCallCancelledWithCanceledCall:(Call *)canceledCall error:(CometChatException *)error{
    
    [CometChatCallManager.incomingCallDelegate onIncomingCallCancelledWithCanceledCall:canceledCall error:error];
    
}

- (void)onOutgoingCallAcceptedWithAcceptedCall:(Call *)acceptedCall error:(CometChatException *)error{
    
    [CometChatCallManager.outgoingCallDelegate onOutgoingCallAcceptedWithAcceptedCall:acceptedCall error:error];
    
}

-(void)initialization {
    AppSettingsBuilder *appSettingBuilder = [[AppSettingsBuilder alloc]init];
    AppSettings *appSettings = [[[appSettingBuilder subscribePresenceForAllUsers]setRegionWithRegion: REGION_CODE]build];
    
    [[CometChat alloc]initWithAppId:APP_ID appSettings:appSettings onSuccess:^(BOOL isSuccess) {
        NSLog(isSuccess ? @"CometChat Initialize Success:-YES" : @"CometChat Initialize Success:-NO");
         [CometChat setSourceWithResource:@"ui-kit" platform:@"iOS" language:@"objective-c"];
    } onError:^(CometChatException * error) {
        NSLog(@"Error %@",[error errorDescription]);
    }];
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}





@end
