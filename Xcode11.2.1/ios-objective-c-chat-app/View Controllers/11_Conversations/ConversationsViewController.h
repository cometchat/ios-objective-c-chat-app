//
//  ConversationsViewController.h
//  ios-objective-c-chat-app
//
//  Created by Nishant on 11/12/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface ConversationsViewController : UIViewController

@property (nonatomic, retain) NSArray<AppEntity *> *filteredUsers;
@property (weak, nonatomic) IBOutlet UITableView *tblView_conversation;
@property (strong,nonatomic) UISearchController *searchController;
@property (nonatomic, retain) NSMutableArray<Conversation *> *conversationListArray;
@property (nonatomic, retain) NSMutableArray<AppEntity *> *contactListArray;
@property (weak, nonatomic) IBOutlet UIView *view_backgroundView;

@property (nonatomic , retain) AppEntity *appEntity;
@end

NS_ASSUME_NONNULL_END
