//
//  LoginWithDemoUsers.h
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginWithDemoUsers : UIViewController


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (weak, nonatomic) IBOutlet UIView *superhero1View;
@property (weak, nonatomic) IBOutlet UIView *superhero2View;
@property (weak, nonatomic) IBOutlet UIView *superhero3View;
@property (weak, nonatomic) IBOutlet UIView *superhero4View;

 -(void)addObservers;

@end

NS_ASSUME_NONNULL_END
