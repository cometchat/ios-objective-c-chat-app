//
//  LoginViewController.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "DemoUsersViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController<UITextFieldDelegate,DemoUserDelegate,UIPopoverPresentationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@end

NS_ASSUME_NONNULL_END
