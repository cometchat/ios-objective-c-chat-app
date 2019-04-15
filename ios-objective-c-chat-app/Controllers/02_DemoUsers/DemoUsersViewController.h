//
//  PopOverView.h
//  SparkChat
//
//  Created by Ins on 12/06/18.
//  Copyright © 2018 inscripts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoUser.h"
@protocol DemoUserDelegate <NSObject>
- (void)selectedUser:(DemoUser*)user;
@end
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

@interface DemoUsersViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic, weak) id<DemoUserDelegate> delegate;
@end
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

