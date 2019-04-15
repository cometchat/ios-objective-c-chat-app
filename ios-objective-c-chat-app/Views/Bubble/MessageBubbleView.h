//
//  MessageBubbleView.h
//  SparkChat
//
//  Created by Inscripts on 06/11/13.
//  Copyright (c) 2013 com.inscripts. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageBubbleView : UIView
@property (strong, nonatomic) UIColor *senderColor;
@property (strong, nonatomic) UIColor *receiverColor;
@property (nonatomic) BOOL isSender;
- (id)initWithFrame:(CGRect)frame isSender:(BOOL)isSender;
@end
