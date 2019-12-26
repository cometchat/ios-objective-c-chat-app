//
//  AppDelegate.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

@protocol MessageDelegate <NSObject>
@required - (void)applicationdidReceiveNewMessage:(BaseMessage *)message;
@required - (void)applicationDidReceivedisTypingEvent:(TypingIndicator *)typingIndicator isComposing:(BOOL)isComposing;
@required - (void)applicationDidReceivedReadAndDeliveryReceipts:(MessageReceipt *)receipts;
@end
@protocol UserEventDelegate <NSObject>
-(void)applicationDidReceiveUserEvent:(User*)user;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
-(void)switchViewControllerIfLoggedIn;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, weak) id<MessageDelegate> messagedelegate;
@property (nonatomic, weak) id<UserEventDelegate> usereventdelegate;
- (UIView*) topMostView;
@end

