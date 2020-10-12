//
//  LoginWithDemoUsers.m
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import "LoginWithDemoUsers.h"
#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import <CometChatPro/CometChatPro-Swift.h>
#import "CometChatObjc-Swift.h"
#import "MainViewController.h"

@interface LoginWithDemoUsers ()

@end

@implementation LoginWithDemoUsers

@synthesize activityIndicator,superhero1View,superhero2View,superhero3View,superhero4View;


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addObservers];
}

-(void)addObservers {
    
    UITapGestureRecognizer *tapOnSuperHero1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoginWithSuperHero1:)];
    self.superhero1View.userInteractionEnabled = YES;
    [self.superhero1View addGestureRecognizer:tapOnSuperHero1];
    
    UITapGestureRecognizer *tapOnSuperHero2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoginWithSuperHero2:)];
    self.superhero2View.userInteractionEnabled = YES;
    [self.superhero2View addGestureRecognizer:tapOnSuperHero2];
    
    UITapGestureRecognizer *tapOnSuperHero3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoginWithSuperHero3:)];
    self.superhero3View.userInteractionEnabled = YES;
    [self.superhero3View addGestureRecognizer:tapOnSuperHero3];
    
    UITapGestureRecognizer *tapOnSuperHero4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(LoginWithSuperHero4:)];
    self.superhero4View.userInteractionEnabled = YES;
    [self.superhero4View addGestureRecognizer:tapOnSuperHero4];
}


- (void)LoginWithSuperHero1:(UITapGestureRecognizer *)recognizer {
    [self loginWithUID:@"superhero1"];
}

- (void)LoginWithSuperHero2:(UITapGestureRecognizer *)recognizer {
     [self loginWithUID:@"superhero2"];
}

- (void)LoginWithSuperHero3:(UITapGestureRecognizer *)recognizer {
     [self loginWithUID:@"superhero3"];
}

- (void)LoginWithSuperHero4:(UITapGestureRecognizer *)recognizer {
     [self loginWithUID:@"superhero4"];
}

-(void)loginWithUID:(NSString *)UID {
    [activityIndicator startAnimating];
    [CometChat loginWithUID:UID apiKey:API_KEY onSuccess:^(User * user) {
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
