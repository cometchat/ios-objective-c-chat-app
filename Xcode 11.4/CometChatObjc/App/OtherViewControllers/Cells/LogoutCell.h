//
//  LogoutCell.h
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol LogoutViewDelegate <NSObject>
-(void)didLogoutPressed;
@end

@interface LogoutCell : UITableViewCell
@property (nonatomic, weak) id<LogoutViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@end

NS_ASSUME_NONNULL_END
