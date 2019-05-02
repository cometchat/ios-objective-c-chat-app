//
//  AppSettings.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 01/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppSettings : NSObject
@property (nonatomic, readonly) UIColor *navigationBarColor;
-(void)print;
@end


NS_ASSUME_NONNULL_END
