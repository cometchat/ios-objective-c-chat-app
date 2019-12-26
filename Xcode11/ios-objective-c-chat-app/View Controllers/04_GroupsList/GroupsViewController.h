//
//  GroupsViewController.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import "EntityTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface GroupsViewController : UIViewController
@property (nonatomic, retain) NSMutableArray<AppEntity *> *joinedgroupListArray;
@property (nonatomic, retain) NSMutableArray<AppEntity *> *unjoinedgroupListArray;
@property (nonatomic, retain) GroupsRequest *groupRequest;
@property (weak, nonatomic) IBOutlet UITableView *_tableView;
@property (nonatomic, retain) NSArray<AppEntity *> *filteredUsers;
@property (strong,nonatomic) UISearchController *searchController;
@end

NS_ASSUME_NONNULL_END
