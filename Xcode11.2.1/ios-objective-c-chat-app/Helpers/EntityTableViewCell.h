//
//  EntityTableViewCell.h
//  ios-objective-c-chat-app
//
//  Created by MacMini-03 on 10/06/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface EntityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIView *blockedView;
@property (weak, nonatomic) IBOutlet UIView *unreadCountBadge;
@property (weak, nonatomic) IBOutlet UILabel *unreadCountLabel;


-(void)bind:(AppEntity *)entity withIndexPath:(NSIndexPath*)indexPath;

@end

NS_ASSUME_NONNULL_END
