//
//  UIComponentCell.h
//  CometChatObjc
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol UICompnentViewDelegate <NSObject>
-(void)didNavigateButtonPressed;
@end

@interface ComponentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (nonatomic, weak) id<UICompnentViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
