//
//  CreateUser.m
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import "CreateUser.h"
#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import <CometChatPro/CometChatPro-Swift.h>
#import "CometChatObjc-Swift.h"
#import "MainViewController.h"

@interface CreateUser ()

@end

@implementation CreateUser

@synthesize activityIndicator,backgroundView, submit ,textField,signInButtonConstraint, loadingView, loadingViewHeightConstriant, lodingViewTitle ;

- (void)viewDidLoad {
    [super viewDidLoad];
    [loadingView setHidden:YES];
    loadingViewHeightConstriant.constant = 0;
    [self registerObservers];
}




-(void) registerObservers {
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self hideKeyboardWhenTappedArround];
}

- (IBAction)cancelPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
}

- (void)keyboardWillShow:(NSNotification *)notification
{
   CGFloat keyboardHeight = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    signInButtonConstraint.constant = keyboardHeight - 10;
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
    if (submit.frame.origin.y != 0) {
        signInButtonConstraint.constant = 40;
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (IBAction)submitPressed:(id)sender {
    [self CreateUser];
}


-(void)CreateUser {
  dispatch_async(dispatch_get_main_queue(), ^{
      [self->loadingView setHidden: NO];
      self->loadingViewHeightConstriant.constant = 40;
      [self->activityIndicator startAnimating];
      self->lodingViewTitle.text = @"Creating an User...";
       self->loadingView.backgroundColor = [[UIColor alloc]initWithRed:0.4666666687 green:0.7647058964 blue:0.2666666806 alpha:1.0];
      [UIView animateWithDuration:0.25 animations:^{
          [self.view layoutIfNeeded];
      }];
    });

    NSUInteger currentTime = [[NSDate date] timeIntervalSince1970];
    NSString *uid = [[NSString alloc] initWithFormat:@"user%lu",(unsigned long)currentTime];
    
    User *user = [[User alloc] initWithUid: uid name: textField.text];
    
    [CometChat createUserWithUser:user apiKey:AUTH_KEY onSuccess:^(User * user) {
        
          dispatch_async(dispatch_get_main_queue(), ^{
             
              [self loginWithUID: user.uid];
              
          });

    } onError:^(CometChatException * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
          [self->loadingView setHidden: NO];
          self->loadingViewHeightConstriant.constant = 40;
          [self->activityIndicator startAnimating];
            self->lodingViewTitle.text = @"Failed to create user.";
           self->loadingView.backgroundColor = [[UIColor alloc]initWithRed:0.9254902005 green:0.2352941185 blue:0.1019607857 alpha:1.0];
          [UIView animateWithDuration:0.25 animations:^{
              [self.view layoutIfNeeded];
          }];
        });
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->activityIndicator stopAnimating];
          
        });
        NSLog(@"createUserWithUser failure: %@",error.errorDescription);
    }];
    
}

-(void)loginWithUID: (NSString *)uid {
     dispatch_async(dispatch_get_main_queue(), ^{
         [self->loadingView setHidden: NO];
         self->loadingViewHeightConstriant.constant = 40;
         [self->activityIndicator startAnimating];
         self->lodingViewTitle.text = @"Logging in...";
          self->loadingView.backgroundColor = [[UIColor alloc]initWithRed:0.4666666687 green:0.7647058964 blue:0.2666666806 alpha:1.0];
         [UIView animateWithDuration:0.25 animations:^{
             [self.view layoutIfNeeded];
         }];
       });
    [CometChat loginWithUID: uid apiKey:AUTH_KEY onSuccess:^(User * user) {
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
                [self->loadingView setHidden: NO];
                self->loadingViewHeightConstriant.constant = 40;
                [self->activityIndicator startAnimating];
                  self->lodingViewTitle.text = @"Failed to login the user.";
                 self->loadingView.backgroundColor = [[UIColor alloc]initWithRed:0.9254902005 green:0.2352941185 blue:0.1019607857 alpha:1.0];
                [UIView animateWithDuration:0.25 animations:^{
                    [self.view layoutIfNeeded];
                }];
              });
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->activityIndicator stopAnimating];
           
        });
        NSLog(@"login failure: %@",error.errorDescription);
    }];
}


@end
