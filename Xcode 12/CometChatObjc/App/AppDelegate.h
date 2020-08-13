//
//  AppDelegate.h
//  ios-objective-c-chat-app
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CometChatPro/CometChatPro-Swift.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CometChatCallDelegate>

-(void)initialization;
@property (strong, nonatomic) UIWindow *window;
@end

