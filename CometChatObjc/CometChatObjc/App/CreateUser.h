//
//  CreateUser.h
//  CometChatObjc
//
//  Created by Pushpsen on 01/06/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CreateUser : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) IBOutlet UILabel *lodingViewTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loadingViewHeightConstriant;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signInButtonConstraint;
@end



NS_ASSUME_NONNULL_END
