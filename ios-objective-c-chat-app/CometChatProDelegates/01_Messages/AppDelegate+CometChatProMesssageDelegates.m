//
//  AppDelegate+CometChatProMesssageDelegates.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 23/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppDelegate+CometChatProMesssageDelegates.h"

@implementation AppDelegate (CometChatProMesssageDelegates)

#pragma mark - CometChatPro New Message Delagate

- (void)onMediaMessageReceivedWithMediaMessage:(MediaMessage *)mediaMessage {
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationdidReceiveNewMessage:)]) {
        [self.messagedelegate applicationdidReceiveNewMessage:mediaMessage];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"com.inscripts.updateBadge" object:nil userInfo:nil];
}

- (void)onTextMessageReceivedWithTextMessage:(TextMessage *)textMessage{
   
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationdidReceiveNewMessage:)]) {
        
        [self.messagedelegate applicationdidReceiveNewMessage:textMessage];
    }
}


-(void)onTypingStarted:(TypingIndicator *)typingDetails{
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationDidReceivedisTypingEvent:isComposing:)]) {
        
        [self.messagedelegate applicationDidReceivedisTypingEvent:typingDetails isComposing:YES];
    }
}
-(void)onTypingEnded:(TypingIndicator *)typingDetails{
    
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationDidReceivedisTypingEvent:isComposing:)]) {
        
        [self.messagedelegate applicationDidReceivedisTypingEvent:typingDetails isComposing:NO];
    }
}
-(void)onMessageDeliveredWithReceipt:(MessageReceipt *)receipt
{
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationDidReceivedReadAndDeliveryReceipts:)]) {
        
        [self.messagedelegate applicationDidReceivedReadAndDeliveryReceipts:receipt];
    }
}
-(void)onMessageReadWithReceipt:(MessageReceipt *)receipt
{
    if (self.messagedelegate && [self.messagedelegate respondsToSelector:@selector(applicationDidReceivedReadAndDeliveryReceipts:)]) {
        
        [self.messagedelegate applicationDidReceivedReadAndDeliveryReceipts:receipt];
    }
}
@end
