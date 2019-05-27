//
//  EntityOtherDetailsTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "EntityOtherDetailsTableViewCell.h"

@implementation EntityOtherDetailsTableViewCell

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
        [self.contentView addSubview:self.alabel];
        [_alabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.aImageView];
        [_aImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        CGFloat imageHeight = self.frame.size.height;
        
        NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",imageHeight] ,@"imageHeight", nil];
        
        NSArray *lblH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_aImageView(imageHeight)]-(16)-[_alabel]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_alabel,_aImageView)];
        NSArray *lblV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_alabel]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_alabel,_aImageView)];
        NSArray *lblV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_aImageView(imageHeight)]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_alabel,_aImageView)];
        
        [self.contentView addConstraints:lblH];
        [self.contentView addConstraints:lblV1];
        [self.contentView addConstraints:lblV2];
        
    }
    return self;
}
-(UILabel *)alabel {
    
    if (!_alabel) {
        _alabel = [UILabel new];
        [_alabel setFont:[UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)]];
        [_alabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _alabel;
}
-(UIImageView *)aImageView
{
    if (!_aImageView) {
        _aImageView = [UIImageView new];
        [_aImageView setContentMode:(UIViewContentModeCenter)];
        _aImageView.layer.cornerRadius = self.frame.size.height/2;
        _aImageView.clipsToBounds = YES;
        [_aImageView.layer setBorderColor:[[UIColor grayColor] CGColor]];
        [_aImageView.layer setBorderWidth:1.0f];
    }
    return _aImageView;
}
+(NSString*)cellIdentifier{
    return @"entityOthersDetailsreuseIdentifier";
}
-(void)updateConstraints{
    [super updateConstraints];
    
    CGFloat imageHeight = self.frame.size.height;
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",imageHeight] ,@"imageHeight", nil];
    
    NSArray *lblH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_aImageView(imageHeight)]-(16)-[_alabel]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_alabel,_aImageView)];
    NSArray *lblV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_alabel]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_alabel,_aImageView)];
    NSArray *lblV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_aImageView(imageHeight)]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_alabel,_aImageView)];
    
    [self.contentView addConstraints:lblH];
    [self.contentView addConstraints:lblV1];
    [self.contentView addConstraints:lblV2];
    
}
@end
