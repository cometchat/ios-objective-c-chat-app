//
//  CustomTableViewCell.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 19/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface EntityListTableViewCell : UITableViewCell
+ (NSString *)reuseIdentifier;
-(void)bind:(AppEntity *)entity withIndexPath:(NSIndexPath*)indexPath;
@end

NS_ASSUME_NONNULL_END
