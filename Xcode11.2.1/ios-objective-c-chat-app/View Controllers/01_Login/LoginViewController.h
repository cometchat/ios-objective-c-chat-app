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

@interface LoginViewController : UIViewController<UITextFieldDelegate,DemoUserDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *view_LoginView;
@property (weak, nonatomic) IBOutlet UITextField *txtFld_UID;
@property (weak, nonatomic) IBOutlet UIButton *btn_superHero1;
@property (weak, nonatomic) IBOutlet UIButton *btn_superHero2;
@property (weak, nonatomic) IBOutlet UIButton *btn_superHero4;
@property (weak, nonatomic) IBOutlet UIButton *btn_superHero3;
@property (weak, nonatomic) IBOutlet UIButton *btn_login;
@property (weak, nonatomic) IBOutlet UIView *view_superHero2;
@property (weak, nonatomic) IBOutlet UIView *view_superHero3;
@property (weak, nonatomic) IBOutlet UIView *view_superHero4;
@property (weak, nonatomic) IBOutlet UIView *view_superHero1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView_login;



@end

NS_ASSUME_NONNULL_END
