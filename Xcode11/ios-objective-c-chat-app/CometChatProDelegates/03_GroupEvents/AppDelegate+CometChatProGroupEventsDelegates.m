//
//  AppDelegate+CometChatProGroupEventsDelegates.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 23/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppDelegate+CometChatProGroupEventsDelegates.h"

@implementation AppDelegate (CometChatProGroupEventsDelegates)

#pragma mark - CometChatPro Group Events Delegate

- (void)onGroupMemberBannedWithAction:(ActionMessage * _Nonnull)action bannedUser:(User * _Nonnull)bannedUser bannedBy:(User * _Nonnull)bannedBy bannedFrom:(Group * _Nonnull)bannedFrom {
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationdidReceiveNewMessage:)]) {
        
        [self.messagedelegate applicationdidReceiveNewMessage:action];
    }
}

- (void)onGroupMemberJoinedWithAction:(ActionMessage * _Nonnull)action joinedUser:(User * _Nonnull)joinedUser joinedGroup:(Group * _Nonnull)joinedGroup {
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationdidReceiveNewMessage:)]) {
        
        [self.messagedelegate applicationdidReceiveNewMessage:action];
    }
}

- (void)onGroupMemberKickedWithAction:(ActionMessage * _Nonnull)action kickedUser:(User * _Nonnull)kickedUser kickedBy:(User * _Nonnull)kickedBy kickedFrom:(Group * _Nonnull)kickedFrom {
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationdidReceiveNewMessage:)]) {
        
        [self.messagedelegate applicationdidReceiveNewMessage:action];
    }
}

- (void)onGroupMemberLeftWithAction:(ActionMessage * _Nonnull)action leftUser:(User * _Nonnull)leftUser leftGroup:(Group * _Nonnull)leftGroup {
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationdidReceiveNewMessage:)]) {
        
        [self.messagedelegate applicationdidReceiveNewMessage:action];
    }
}

- (void)onGroupMemberScopeChangedWithAction:(ActionMessage * _Nonnull)action user:(User * _Nonnull)user scopeChangedTo:(NSString * _Nonnull)scopeChangedTo scopeChangedFrom:(NSString * _Nonnull)scopeChangedFrom group:(Group * _Nonnull)group {
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationdidReceiveNewMessage:)]) {
        
        [self.messagedelegate applicationdidReceiveNewMessage:action];
    }
}

- (void)onGroupMemberUnbannedWithAction:(ActionMessage * _Nonnull)action unbannedUser:(User * _Nonnull)unbannedUser unbannedBy:(User * _Nonnull)unbannedBy unbannedFrom:(Group * _Nonnull)unbannedFrom {
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationdidReceiveNewMessage:)]) {
        
        [self.messagedelegate applicationdidReceiveNewMessage:action];
    }
}


@end
