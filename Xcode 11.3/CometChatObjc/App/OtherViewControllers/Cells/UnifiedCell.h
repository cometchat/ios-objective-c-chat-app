//
//  NewTableViewCell.h
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol UnifiedViewDelegate <NSObject>
-(void)didLaunchButtonPressed:(UISegmentedControl*)typeSegment;
@end
@interface UnifiedCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;
@property (weak, nonatomic) IBOutlet UIButton *launchButton;
@property (nonatomic, weak) id<UnifiedViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
