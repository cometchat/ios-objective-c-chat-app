//
//  EntityDetailsTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "EntityDetailsTableViewCell.h"
@interface EntityDetailsTableViewCell()
@property (nonatomic ,retain) UIView *wrapper;

@end

@implementation EntityDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.wrapper];
        [self.wrapper addSubview:self.icon];
        [self.wrapper addSubview:self.titleLbl];
        [self.wrapper addSubview:self.statusLbl];
        
        [_wrapper setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_icon setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_titleLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_statusLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSArray *wrapperH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_wrapper]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_wrapper)];
        NSArray *wrapperV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(80)-[_wrapper]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_wrapper)];
        
        [self.contentView addConstraints:wrapperH];
        [self.contentView addConstraints:wrapperV];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_icon ,_titleLbl , _statusLbl);
        NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",(self.frame.size.width*50/100) - (8.0f*2)],@"imageWidth", nil];
        
        [self.wrapper addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self.wrapper attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0]];

        
        NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_icon(imageWidth)]" options:0 metrics:metrics views:views];
        NSArray *subViewH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLbl]-|" options:0 metrics:metrics views:views];
        NSArray *subViewH3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_statusLbl]-|" options:0 metrics:metrics views:views];
        NSArray *subViewV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-60)-[_icon(imageWidth)]-[_titleLbl]-[_statusLbl]" options:0 metrics:metrics views:views];
        
        [self.wrapper addConstraints:subViewH1];
        [self.wrapper addConstraints:subViewH2];
        [self.wrapper addConstraints:subViewH3];
        [self.wrapper addConstraints:subViewV];
    }
    
    HexToRGBConvertor *hexToRGB = [HexToRGBConvertor new];
    [self.contentView setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
    
    return self;
}
-(UIView *)wrapper {
    
    if (!_wrapper) {
        _wrapper = [UIView new];
        [_wrapper setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
    return _wrapper;
}
-(UIImageView *)icon{
    
    if (!_icon) {
        _icon = [UIImageView new];
        [_icon setClipsToBounds:YES];
    }
    return _icon;
}
-(UILabel *)titleLbl {
    
    if (!_titleLbl) {
        _titleLbl = [UILabel new];
        [_titleLbl setFont:[UIFont systemFontOfSize:22.0f weight:(UIFontWeightSemibold)]];
        [_titleLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLbl;
}
-(UILabel *)statusLbl {
    
    if (!_statusLbl) {
        _statusLbl = [UILabel new];
        [_statusLbl setFont:[UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)]];
        [_statusLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _statusLbl;
}
+(NSString*)cellIdentifier{
    return @"entityDetailsreuseIdentifier";
}
-(void)updateConstraints{
    [super updateConstraints];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_icon ,_titleLbl , _statusLbl);
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",(self.frame.size.width*50/100) - (8.0f*2)],@"imageWidth", nil];
    
    [self.wrapper addConstraint:[NSLayoutConstraint constraintWithItem:self.icon attribute:(NSLayoutAttributeCenterX) relatedBy:(NSLayoutRelationEqual) toItem:self.wrapper attribute:(NSLayoutAttributeCenterX) multiplier:1 constant:0]];
    
    NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_icon(imageWidth)]" options:0 metrics:metrics views:views];
    NSArray *subViewH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_titleLbl]-|" options:0 metrics:metrics views:views];
    NSArray *subViewH3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_statusLbl]-|" options:0 metrics:metrics views:views];
    NSArray *subViewV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(-60)-[_icon(imageWidth)]-[_titleLbl]-[_statusLbl]" options:0 metrics:metrics views:views];
    
    [self.wrapper addConstraints:subViewH1];
    [self.wrapper addConstraints:subViewH2];
    [self.wrapper addConstraints:subViewH3];
    [self.wrapper addConstraints:subViewV];
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.icon.layer setCornerRadius:self.icon.frame.size.height/2];
}
@end
