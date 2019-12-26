//
//  EntityDetailsTableViewCell.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface EntityDetailsTableViewCell : UITableViewCell
+ (NSString *)cellIdentifier;
@property (nonatomic ,strong) UIImageView *icon;
@property (nonatomic ,retain) UILabel *titleLbl;
@property (nonatomic ,retain) UILabel *statusLbl;
@end

NS_ASSUME_NONNULL_END
