//
//  ChatViewController.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 19/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChatViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic, retain) MessagesRequest *messageRequest;

@property (nonatomic, retain) NSMutableArray<BaseMessage *> *messsagesArray;

@property (weak, nonatomic) IBOutlet UITableView *_tableView;

@property (nonatomic , retain) AppEntity *appEntity;

@property (nonatomic , strong) UIRefreshControl *refreshControl;

@property (weak, nonatomic) IBOutlet UIButton *attachmentBtn;

@property (weak, nonatomic) IBOutlet UITextView *sendMessageTextView;

@property (weak, nonatomic) IBOutlet UIButton *sendMessageBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottomConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wrapperBottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendMessageHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wrapperHeightConstraint;
- (IBAction)sendBtnPressed:(UIButton *)sender;
- (IBAction)attachmentBtnPressed:(UIButton *)sender;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property(strong ,nonatomic) CALayer *border;

@end

NS_ASSUME_NONNULL_END
