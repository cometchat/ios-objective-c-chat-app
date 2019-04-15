//
//  ContactsViewController.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactsViewController : UIViewController
@property (nonatomic, retain) NSMutableArray<AppEntity *> *contactListArray;
@property (nonatomic, retain) NSArray<AppEntity *> *filteredUsers;
@property (nonatomic, retain) UsersRequest *userRequest;
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (strong,nonatomic) UISearchController *searchController;
@end

NS_ASSUME_NONNULL_END
