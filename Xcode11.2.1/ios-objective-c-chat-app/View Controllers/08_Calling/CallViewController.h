//
//  CallViewController.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 14/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface CallViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *calleeName;
@property (weak, nonatomic) IBOutlet UILabel *status;
- (IBAction)hangupBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *hangUp;

@property (nonatomic ,retain) AppEntity *entity;
@property (nonatomic) CallType callType;

@end

NS_ASSUME_NONNULL_END
