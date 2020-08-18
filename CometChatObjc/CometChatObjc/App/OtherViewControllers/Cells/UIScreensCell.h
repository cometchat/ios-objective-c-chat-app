//
//  UIScreensCell.h
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol ScreensViewDelegate <NSObject>
-(void)didLaunchPressed:(UISegmentedControl*)typeSegment screens:(UISegmentedControl*)screensSegment;
@end

@interface UIScreensCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *screensSegment;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;
@property (nonatomic, weak) id<ScreensViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
