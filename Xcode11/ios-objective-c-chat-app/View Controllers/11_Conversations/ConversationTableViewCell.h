//
//  ConversationTableViewCell.h
//  ios-objective-c-chat-app
//
//  Created by Nishant on 12/12/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConversationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView_avatar;
@property (weak, nonatomic) IBOutlet UILabel *lbl_name;
@property (weak, nonatomic) IBOutlet UILabel *lbl_time;
@property (weak, nonatomic) IBOutlet UILabel *lbl_conversation;



@end

NS_ASSUME_NONNULL_END
