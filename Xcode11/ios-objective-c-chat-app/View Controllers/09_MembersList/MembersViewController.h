//
//  MembersViewController.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface MembersViewController : UIViewController
@property (nonatomic) BOOL isLoadBanned;
@property (nonatomic) BOOL isLoadActive;
@property (nonatomic) BOOL isLoadBlocked;
@property (nonatomic ,strong) Group *group;
@end


NS_ASSUME_NONNULL_END
