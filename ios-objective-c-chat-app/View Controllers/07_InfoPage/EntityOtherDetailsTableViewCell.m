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
        
        NSArray *lblH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_alabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_alabel)];
        NSArray *lblV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_alabel]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_alabel)];
        
        [self.contentView addConstraints:lblH];
        [self.contentView addConstraints:lblV];
        
    }
    return self;
}
-(UILabel *)alabel {
    
    if (!_alabel) {
        _alabel = [UILabel new];
        [_alabel setFont:[UIFont systemFontOfSize:14.0f weight:(UIFontWeightSemibold)]];
    }
    return _alabel;
}
+(NSString*)cellIdentifier{
    return @"entityOthersDetailsreuseIdentifier";
}
@end
