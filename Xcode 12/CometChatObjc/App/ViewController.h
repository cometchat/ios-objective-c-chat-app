//
//  ViewController.h
//  ios-objective-c-chat-app
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CometChatPro/CometChatPro-Swift.h>
#import "CometChatObjc-Swift.h"

@interface ViewController : UIViewController

@property (nonatomic) CometChatUnified *unifiedUI;

@end

