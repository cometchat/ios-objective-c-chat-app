//
//  TextTableViewCell.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 25/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN


@interface TextTableViewCell : UITableViewCell
//
+(NSString*)reuseIdentifier;
-(void)bind:(TextMessage *)messsage withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection;
//
@end

NS_ASSUME_NONNULL_END
