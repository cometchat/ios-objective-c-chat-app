//
//  CustomTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 19/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "EntityListTableViewCell.h"

@interface EntityListTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailsLabel;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UIView *blockedView;
@property (nonatomic, strong) UILabel *blockedLabel;

@end

@implementation EntityListTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // configure control(s)
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.detailsLabel];
        [self.contentView addSubview:self.blockedView];
        [self.blockedView addSubview:self.blockedLabel];
        
        [_iconView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_detailsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_blockedView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(_iconView,_nameLabel,_detailsLabel,_blockedView);
        
        NSArray *horizontalConstraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_iconView]-(16)-[_nameLabel]"  options:0 metrics:nil views:views];
        NSArray *horizontalConstraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_iconView]-(16)-[_detailsLabel]"  options:0 metrics:nil views:views];
        NSArray *verticalConstraints1   = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_iconView]-|"  options:0 metrics:nil views:views];
        NSArray *verticalConstraints2   = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameLabel]-[_detailsLabel]"  options:0 metrics:nil views:views];
        NSArray *verticalConstraints3   = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-[_detailsLabel]-|"  options:0 metrics:nil views:views];
         NSArray *verticalConstraints4   = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_nameLabel]-[_detailsLabel]-|"  options:0 metrics:nil views:views];
        
        [self.contentView addConstraints:horizontalConstraints1];
        [self.contentView addConstraints:horizontalConstraints2];
        [self.contentView addConstraints:verticalConstraints1];
        [self.contentView addConstraints:verticalConstraints2];
        [self.contentView addConstraints:verticalConstraints3];
        [self.contentView addConstraints:verticalConstraints4];
        
    }
    return self;
}
-(UIImageView *)iconView
{
    if (!_iconView) {
        
        _iconView = [UIImageView new];
        [_iconView setContentMode:UIViewContentModeScaleAspectFill];
        [_iconView.layer setCornerRadius:self.frame.size.height/2];
        _iconView.clipsToBounds = YES;
        [_iconView.layer setBorderColor:[[UIColor grayColor] CGColor]];
        [_iconView.layer setBorderWidth:1.0f];
    }
    return _iconView;
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
         _nameLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    }
    return _nameLabel;
}

-(UILabel *)blockedLabel
{
    if (!_blockedLabel) {
        _blockedLabel = [UILabel new];
        _blockedLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    }
    return _blockedLabel;
}

-(UIView *)blockedView
{
    if (!_blockedView) {
        _blockedView = [UIView new];
        _blockedView.backgroundColor = [UIColor redColor];
    }
    return _blockedView;
}

-(UILabel *)detailsLabel
{
    if (!_detailsLabel) {
        
        _detailsLabel = [UILabel new];
        _detailsLabel.font = [UIFont systemFontOfSize:13.0f];
        _detailsLabel.textColor = [UIColor lightGrayColor];
    }
    return _detailsLabel;
}
-(void)updateConstraints{
    [super updateConstraints];
    
    CGFloat imageHeight = self.frame.size.height - (2*paddingY);
    CGFloat nameWidth   = self.frame.size.width*70/100;
    CGFloat nameHeight  = (self.frame.size.height - (paddingY*2))/2;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_iconView,_nameLabel,_detailsLabel,_blockedView);
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",imageHeight],@"imageHeight",[NSString stringWithFormat:@"%f",nameWidth],@"nameWidth",[NSString stringWithFormat:@"%f",nameHeight],@"nameHeight", nil];
    
    NSArray *horizontalConstraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_iconView(imageHeight)]-(16)-[_nameLabel(nameWidth)]"  options:0 metrics:metrics views:views];
    NSArray *horizontalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_iconView]-(16)-[_detailsLabel(nameWidth)]"  options:0 metrics:metrics views:views];
    
    NSArray *verticalConstraints1 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_iconView(imageHeight)]-|"  options:0 metrics:metrics views:views];
    
    NSArray *verticalConstraints2 =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_nameLabel]-(8)-[_detailsLabel]-|"  options:0 metrics:metrics views:views];
    
    [self.contentView addConstraints:horizontalConstraints1];
    [self.contentView addConstraints:horizontalConstraints2];
    [self.contentView addConstraints:verticalConstraints1];
    [self.contentView addConstraints:verticalConstraints2];
}
-(void)bind:(AppEntity *)entity withIndexPath:(NSIndexPath*)indexPath
{
    
    NSString *link , * letter ;
    
    if ([entity isKindOfClass:User.class]) {
       
        User *person = (User *)entity;
        
        self.nameLabel.text = [person name];
        self.blockedLabel.text = @"Blocked";
        switch ([person status]) {
                
            case UserStatusOnline:
                
                {
                    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                    attachment.image = [UIImage imageNamed:@"user_online"];
                    CGFloat imageOffsetY = -2.0;
                    attachment.bounds = CGRectMake(5, imageOffsetY, attachment.image.size.width, attachment.image.size.height);
                    
                    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                    
                    NSMutableAttributedString *online= [[NSMutableAttributedString alloc] initWithString:@"\tOnline"];
                    
                    NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
                    
                    [attributedString appendAttributedString:attachmentString];
                    [attributedString appendAttributedString:online];
                    
                    self.detailsLabel.attributedText = attributedString;
                }
            
                break;
            case UserStatusOffline:
            
            {
                NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
                attachment.image = [UIImage imageNamed:@"user_offline"];
                CGFloat imageOffsetY = -2.0;
                attachment.bounds = CGRectMake(5, imageOffsetY, attachment.image.size.width, attachment.image.size.height);

                NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
                
                NSMutableAttributedString *offline= [[NSMutableAttributedString alloc] initWithString:@"\tOffline"];
                
                NSMutableAttributedString *attributedString = [NSMutableAttributedString new];
                
                [attributedString appendAttributedString:attachmentString];
                [attributedString appendAttributedString:offline];

                self.detailsLabel.attributedText = attributedString;
            }
                break;
        }
        
        letter = [NSString stringWithFormat:@"%@",[person name]];
        link = [NSString stringWithFormat:@"%@",[person avatar]];
    } else if ([entity isKindOfClass:Group.class]) {
        
        Group *group = (Group *)entity;
        self.nameLabel.text = [group name];
        letter = [NSString stringWithFormat:@"%@",[group name]];
        link = [NSString stringWithFormat:@"%@",[group icon]];
        self.detailsLabel.text = [group groupDescription];
    }
    Avatar *avatar = [[Avatar alloc]initWithRect:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f) fullName:letter];
    [avatar setBackgroundColor:[UIColor grayColor]];
    self.iconView.image = [avatar imageRepresentation];
    self.tag = indexPath.row;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        [DownloadManager link:link completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data) {
                UIImage* image = [[UIImage alloc] initWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (self.tag == indexPath.row) {
                            self.iconView.image = image;
                        }
                    });
                }
            }
        }];
    });
}
@end
