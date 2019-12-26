//
//  AppDelegate+CometChatProCallDelegates.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 23/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppDelegate+CometChatProCallDelegates.h"

@implementation AppDelegate (CometChatProCallDelegates)

#pragma mark - CometChatPro Call Delegate

- (void)onIncomingCallCancelledWithCanceledCall:(Call * _Nullable)canceledCall error:(CometChatException * _Nullable)error {

}

- (void)onIncomingCallReceivedWithIncomingCall:(Call * _Nullable)incomingCall error:(CometChatException * _Nullable)error {
    
    [[CallManager sharedInstance]reportIncomingCall:incomingCall];
}

- (void)onOutgoingCallAcceptedWithAcceptedCall:(Call * _Nullable)acceptedCall error:(CometChatException * _Nullable)error {
    
    NSLog(@"acceptedCall %@",[acceptedCall sessionID]);
    
    [CometChat startCallWithSessionID:[acceptedCall sessionID] inView:[self topMostView] userJoined:^(User * joined_user) {

        NSLog(@"%@",[joined_user stringValue]);

    } userLeft:^(User * left_user) {

        NSLog(@"%@",[left_user stringValue]);

    } onError:^(CometChatException * error) {

        NSLog(@"%@",[error errorDescription]);

    } callEnded:^(Call * ended_call) {

        if ([[CallManager sharedInstance] currentCall]) {
            [[CallManager sharedInstance] endCall];
        }
    }];
}

- (void)onOutgoingCallRejectedWithRejectedCall:(Call * _Nullable)rejectedCall error:(CometChatException * _Nullable)error {

    // call rejected by next person //
    
    
}
@end
