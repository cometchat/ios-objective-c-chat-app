//
//  ActionTableViewCell.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 15/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActionTableViewCell : UITableViewCell
+(NSString*)reuseIdentifier;
-(void)bind:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
