//
//  ActionTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 15/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "ActionTableViewCell.h"
@interface ActionTableViewCell()
@property (nonatomic ,retain) UILabel *messageLabel;
@property (nonatomic ,retain) UIView  *messageHolder;
@end
@implementation ActionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+(NSString *)reuseIdentifier{
     return NSStringFromClass([self class]);
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.messageHolder];
        [_messageHolder setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_messageHolder addSubview:self.messageLabel];
        [_messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_messageHolder
                                                                   attribute:(NSLayoutAttributeCenterX)
                                                                   relatedBy:(NSLayoutRelationEqual)
                                                                      toItem:self.contentView
                                                                   attribute:(NSLayoutAttributeCenterX)
                                                                  multiplier:1
                                                                    constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_messageHolder
                                                                   attribute:(NSLayoutAttributeCenterY)
                                                                   relatedBy:(NSLayoutRelationEqual)
                                                                      toItem:self.contentView
                                                                   attribute:(NSLayoutAttributeCenterY)
                                                                  multiplier:1
                                                                    constant:0]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_messageHolder
                                                                     attribute:(NSLayoutAttributeWidth)
                                                                     relatedBy:(NSLayoutRelationEqual)
                                                                        toItem:nil
                                                                     attribute:(NSLayoutAttributeWidth)
                                                                    multiplier:1
                                                                      constant:self.frame.size.width -paddingX*2]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_messageHolder
                                                                     attribute:(NSLayoutAttributeHeight)
                                                                     relatedBy:(NSLayoutRelationEqual)
                                                                        toItem:nil
                                                                     attribute:(NSLayoutAttributeHeight)
                                                                    multiplier:1
                                                                      constant:self.frame.size.height -paddingX*2]];
        
        [_messageHolder addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel
                                                                     attribute:(NSLayoutAttributeCenterX)
                                                                     relatedBy:(NSLayoutRelationEqual)
                                                                        toItem:_messageHolder
                                                                     attribute:(NSLayoutAttributeCenterX)
                                                                    multiplier:1
                                                                      constant:0]];
        [_messageHolder addConstraint:[NSLayoutConstraint constraintWithItem:_messageLabel
                                                                     attribute:(NSLayoutAttributeCenterY)
                                                                     relatedBy:(NSLayoutRelationEqual)
                                                                        toItem:_messageHolder
                                                                     attribute:(NSLayoutAttributeCenterY)
                                                                    multiplier:1
                                                                      constant:0]];
        
    }
    return self;
}

-(void)bind:(NSString *)message
{
    _messageLabel.text = message;
    [_messageLabel sizeToFit];
}
-(UILabel*)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByClipping;
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = [UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
-(UIView *)messageHolder
{
    if (!_messageHolder) {
        
        _messageHolder = [UIView new];
        [_messageHolder setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        _messageHolder.layer.masksToBounds = YES;
        _messageHolder.layer.cornerRadius = 6.0f;
    }
    return _messageHolder;
}
@end
