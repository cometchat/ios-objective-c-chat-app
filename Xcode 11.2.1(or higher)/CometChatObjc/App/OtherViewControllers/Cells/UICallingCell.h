//
//  UICallingCell.h
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CallingViewDelegate <NSObject>
-(void)didMakeCallButtonPressed:(UISegmentedControl*)usersSegment entity:(UISegmentedControl*)typeSegment callType:(UISegmentedControl*)calltypeSegment;
@end

@interface UICallingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISegmentedControl *usersSegment;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *entitySegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *callTypeSegment;
@property (nonatomic, weak) id<CallingViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
