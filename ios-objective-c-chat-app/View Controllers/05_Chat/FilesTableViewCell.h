//
//  FilesTableViewCell.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 12/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AppFileDelegate <NSObject>
-(void)didSelectFileAtIndexPath:(NSInteger)tag;
@end

@interface FilesTableViewCell : UITableViewCell
+(NSString*)reuseIdentifier;
-(void)bind:(MediaMessage *)message withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection indexPath:(NSIndexPath *)indexPath;
@property (nonatomic, weak) id<AppFileDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
