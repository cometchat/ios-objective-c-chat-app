//
//  AppDelegate+CometChatProUserEventsDelegates.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 23/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppDelegate+CometChatProUserEventsDelegates.h"

@implementation AppDelegate (CometChatProUserEventsDelegates)


#pragma mark - CometChatPro User Online - Offline Status Delagate

- (void)onUserOfflineWithUser:(User * _Nonnull)user {
    
    if (self.usereventdelegate && [self.usereventdelegate respondsToSelector:@selector(applicationDidReceiveUserEvent:)]) {
        
        [self.usereventdelegate applicationDidReceiveUserEvent:user];
    }
}

- (void)onUserOnlineWithUser:(User * _Nonnull)user {
    
    if (self.usereventdelegate && [self.usereventdelegate respondsToSelector:@selector(applicationDidReceiveUserEvent:)]) {
        
        [self.usereventdelegate applicationDidReceiveUserEvent:user];
    }
}


@end
