//
//  LoginWithUID.m
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import "LoginWithUID.h"
#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import <CometChatPro/CometChatPro-Swift.h>
#import "CometChatObjc-Swift.h"
#import "MainViewController.h"

@interface LoginWithUID ()

@end

@implementation LoginWithUID

@synthesize activityIndicator,backgroundView,signIn,textField,signInBottomConstraint;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerObservers];
}

-(void) registerObservers {
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self hideKeyboardWhenTappedArround];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
   CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    signInBottomConstraint.constant = keyboardHeight - 10;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];

}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [self dismissKeyboard];
}

-(void) hideKeyboardWhenTappedArround{
 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
 self.backgroundView.userInteractionEnabled = YES;
 [self.backgroundView addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [textField resignFirstResponder];
    if (signIn.frame.origin.y != 0) {
        signInBottomConstraint.constant = 40;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (IBAction)signInPressed:(id)sender {

    [self loginWithUID];
}


-(void)loginWithUID {
    [activityIndicator startAnimating];
    [CometChat loginWithUID: textField.text apiKey:API_KEY onSuccess:^(User * user) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->activityIndicator stopAnimating];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            MainViewController * mainVC = [storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:mainVC];
            navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
            navigationController.title = @"CometChat KitchenSink";
            navigationController.navigationBar.prefersLargeTitles = YES;
            [self presentViewController:navigationController animated:YES completion:nil];
        });
    } onError:^(CometChatException * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->activityIndicator stopAnimating];
            CometChatSnackbar *snackBar = [[CometChatSnackbar alloc]initWithMessage:error.errorDescription duration:( CometChatSnackbarDurationShort)];
            [snackBar show];
        });
        NSLog(@"login failure: %@",error.errorDescription);
    }];
}


@end
