//
//  ListTableViewController.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ListViewDelegate <NSObject>
- (void)RowAtIndexPath:(AppEntity*)appEntity;
- (void)WillDisplayCellforRowAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface ListTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)  UITableView * __tableView;
@property (nonatomic, strong) NSMutableArray<AppEntity*> *SectionOneListItems;
@property (nonatomic, weak) id<ListViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
