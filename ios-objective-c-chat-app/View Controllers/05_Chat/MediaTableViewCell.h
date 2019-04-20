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

@protocol AppMediaDelegate <NSObject>
-(void)didSelectMediaAtIndexPath:(NSInteger)tag;
@end

@interface MediaTableViewCell : UITableViewCell
+(NSString*)reuseIdentifier;
-(void)bind:(MediaMessage *)messsage withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, weak) id<AppMediaDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
