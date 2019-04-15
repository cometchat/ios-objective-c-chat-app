//
//  MediaTableViewCell.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 06/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface MediaTableViewCell : UITableViewCell
+(NSString*)reuseIdentifier;
-(void)bind:(MediaMessage *)messsage withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
