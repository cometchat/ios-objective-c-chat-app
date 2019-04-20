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
        [self.contentView addSubview:self.messageLabel];
        [_messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_messageLabel);
        
        NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_messageLabel]-|" options:0 metrics:nil views:views];
        NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_messageLabel]-|" options:0 metrics:nil views:views];
        
        [self.contentView addConstraints:subViewH1];
        [self.contentView addConstraints:subViewV1];
    }
    return self;
}

-(void)bind:(NSString *)message
{
    _messageLabel.text = message;
}
-(UILabel*)messageLabel {
    
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByClipping;
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = [UIFont  italicSystemFontOfSize:13.0f];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}
@end
