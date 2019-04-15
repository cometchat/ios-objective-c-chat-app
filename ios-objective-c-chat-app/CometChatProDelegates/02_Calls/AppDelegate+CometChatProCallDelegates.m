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
    
    [[CallManager sharedInstance]reportOutGoingCall:acceptedCall forEntity: [acceptedCall callInitiator]];
}

- (void)onOutgoingCallRejectedWithRejectedCall:(Call * _Nullable)rejectedCall error:(CometChatException * _Nullable)error {
}
@end
