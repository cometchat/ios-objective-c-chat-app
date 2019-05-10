//
//  AppDelegate+CometChatProDelegate.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 16/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppDelegate+CallManagerDelegate.h"

@implementation AppDelegate (CallManagerDelegate)

#pragma mark - Call Manager Delegate

- (void)callDidAnswer:(nonnull Call *)answeredCall {
    
    NSLog(@"%@",[answeredCall stringValue]);
    [CometChat acceptCallWithSessionID:[answeredCall sessionID] onSuccess:^(Call * answered_call) {
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            [CometChat startCallWithSessionID:[answered_call sessionID] inView:[self topMostView] userJoined:^(User * joined_user) {
                
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
            
        });
        
    } onError:^(CometChatException * error) {
        
        NSLog(@"CometChatException %@",[error errorDescription]);
    }];
    
}
-(void)callDidReject:(Call *)rejectedCall{
    
    NSLog(@"EndedCall :- %@",[rejectedCall stringValue]);
    [CometChat rejectCallWithSessionID:[rejectedCall sessionID] status:callStatusRejected onSuccess:^(Call * rejected_call) {
        
        NSLog(@"%@",[rejected_call stringValue]);
        
    } onError:^(CometChatException * error) {
        
        NSLog(@"%@",[error errorDescription]);
        
    }];
    
}
- (void)callDidFail:(nonnull Call *)failedCall {
    
    NSLog(@"failedCall :- %@",[failedCall stringValue]);
}

@end
