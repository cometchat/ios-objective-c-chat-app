//
//  MainViewController.h
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CometChatObjc-Swift.h"
#import "UnifiedCell.h"
#import "ComponentCell.h"
#import "UIScreensCell.h"
#import "UICallingCell.h"
#import "LogoutCell.h"
#import "LoginWithDemoUsers.h"


NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UnifiedViewDelegate, CallingViewDelegate, ScreensViewDelegate, UICompnentViewDelegate, LogoutViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
-(void)makeCallToEntity:(NSString *)user withType:(CallType *)type withEntityType:(ReceiverType *)receiverType;
@end

NS_ASSUME_NONNULL_END
