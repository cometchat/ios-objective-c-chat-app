//
//  FilesTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 12/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "FilesTableViewCell.h"

@interface FilesTableViewCell()

@property (nonatomic ,retain) UIView *bubble;
@property (nonatomic ,retain) UILabel *senderNameLbl;
@property (nonatomic ,retain) UIImageView *fileImage;
@property (nonatomic ,retain) UILabel *timeLbl;
@property (nonatomic ,retain) UIImageView *readReceipts;
@end

@implementation FilesTableViewCell
{
    CGFloat width , height;
    CAShapeLayer *layer;
    MessageBubbleViewButtonTailDirection taildirection;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)reuseIdentifier
{
     return NSStringFromClass([self class]);
}
-(void)bind:(MediaMessage *)message withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection indexPath:(NSIndexPath *)indexPath
{
    width = self.frame.size.width *40/100;
    height = width;
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",width],@"width",[NSString stringWithFormat:@"%f",height],@"height",[NSString stringWithFormat:@"%f",CELL_ANIMATION_HEIGHT],@"CELL_ANIMATION_HEIGHT" ,nil];
    
    [self.contentView addSubview:self.bubble];
    [_bubble setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    layer = [CAShapeLayer new];
    
    switch (tailDirection) {
            
        case MessageBubbleViewButtonTailDirectionRight:
        {
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_bubble(width)]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(CELL_ANIMATION_HEIGHT)-[_bubble(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble)];
            
            [self.contentView addConstraints:subViewH1];
            [self.contentView addConstraints:subViewV1];
            
            UIBezierPath *bezierPath = [UIBezierPath new];
            [bezierPath moveToPoint:CGPointMake(width - 22, height)];
            [bezierPath addLineToPoint:CGPointMake(17, height)];
            [bezierPath addCurveToPoint:CGPointMake(0,height -17 ) controlPoint1:CGPointMake( 7.61, height) controlPoint2:CGPointMake(0, height-7.61)];
            [bezierPath addLineToPoint:CGPointMake(0, 17)];
            [bezierPath addCurveToPoint:CGPointMake(17, 0) controlPoint1:CGPointMake(0, 7.61) controlPoint2:CGPointMake(7.61, 0)];
            [bezierPath addLineToPoint:CGPointMake(width -21, 0)];
            [bezierPath addCurveToPoint:CGPointMake(width -4, 17) controlPoint1:CGPointMake(width -11.61, 0) controlPoint2:CGPointMake(width -4, 7.61)];
            [bezierPath addLineToPoint:CGPointMake(width - 4, height - 11)];
            [bezierPath addCurveToPoint:CGPointMake(width, height) controlPoint1:CGPointMake(width -4, height - 1) controlPoint2:CGPointMake(width, height)];
            [bezierPath addLineToPoint:CGPointMake(width +0.05, height - 0.01)];
            [bezierPath addCurveToPoint:CGPointMake(width -11.04, height - 4.04) controlPoint1:CGPointMake(width -4.07, height+0.43) controlPoint2:CGPointMake(width -8.16, height - 1.06)];
            [bezierPath addCurveToPoint:CGPointMake(width - 22, height) controlPoint1:CGPointMake(width -16, height) controlPoint2:CGPointMake(width -19, height)];
            
            layer.path = [bezierPath CGPath];
            layer.fillColor = [[UIColor colorWithRed:0.09 green:0.54 blue:1 alpha:1] CGColor];
            [_bubble.layer addSublayer:layer];
            [self.fileImage setTintColor:[UIColor whiteColor]];
            
        }
            break;
        case MessageBubbleViewButtonTailDirectionLeft:
        {
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bubble(width)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(CELL_ANIMATION_HEIGHT)-[_bubble(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble)];
            
            [self.contentView addConstraints:subViewH1];
            [self.contentView addConstraints:subViewV1];
            
            
            UIBezierPath *bezierPath = [UIBezierPath new];
            [bezierPath moveToPoint:CGPointMake(22, height)];
            [bezierPath addLineToPoint:CGPointMake(width-17, height)];
            [bezierPath addCurveToPoint:CGPointMake(width,height -17 ) controlPoint1:CGPointMake(width - 7.61, height) controlPoint2:CGPointMake(width, height-7.61)];
            [bezierPath addLineToPoint:CGPointMake(width, 17)];
            [bezierPath addCurveToPoint:CGPointMake(width-17, 0) controlPoint1:CGPointMake(width, 7.61) controlPoint2:CGPointMake(width-7.61, 0)];
            [bezierPath addLineToPoint:CGPointMake(21, 0)];
            [bezierPath addCurveToPoint:CGPointMake(4, 17) controlPoint1:CGPointMake(11.61, 0) controlPoint2:CGPointMake(4, 7.61)];
            [bezierPath addLineToPoint:CGPointMake(4, height - 11)];
            [bezierPath addCurveToPoint:CGPointMake(0, height) controlPoint1:CGPointMake(4, height - 1) controlPoint2:CGPointMake(0, height)];
            [bezierPath addLineToPoint:CGPointMake(-0.05, height - 0.01)];
            [bezierPath addCurveToPoint:CGPointMake(11.04, height - 4.04) controlPoint1:CGPointMake(4.07, height+0.43) controlPoint2:CGPointMake(8.16, height - 1.06)];
            [bezierPath addCurveToPoint:CGPointMake(22, height) controlPoint1:CGPointMake(16, height) controlPoint2:CGPointMake(19, height)];
            
            layer.path = [bezierPath CGPath];
            layer.fillColor = [[UIColor colorWithRed:(223.0f/255.0f) green:(222.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f] CGColor];
            [_bubble.layer addSublayer:layer];
            
            [self.fileImage setTintColor:[UIColor blackColor]];
        }
            
            break;
    }
    
    [_bubble addSubview:self.senderNameLbl];
    [_senderNameLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bubble addSubview:self.fileImage];
    [_fileImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bubble addSubview:self.timeLbl];
    [_timeLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bubble addSubview:self.readReceipts];
    [_readReceipts setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    NSDictionary *views = NSDictionaryOfVariableBindings(_senderNameLbl ,_fileImage , _timeLbl , _readReceipts);
    
    NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_senderNameLbl]-|" options:0 metrics:nil views:views];
    NSArray *subViewH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_fileImage]-(16)-|" options:0 metrics:nil views:views];
    NSArray *subViewH3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_timeLbl]-[_readReceipts]-|" options:0 metrics:nil views:views];
    NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_senderNameLbl(20)][_fileImage][_timeLbl(20)]-|" options:0 metrics:nil views:views];
    NSArray *subViewV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_senderNameLbl(20)][_fileImage][_readReceipts(20)]-|" options:0 metrics:nil views:views];
    
    [_bubble addConstraints:subViewH1];
    [_bubble addConstraints:subViewH2];
    [_bubble addConstraints:subViewH3];
    [_bubble addConstraints:subViewV1];
    [_bubble addConstraints:subViewV2];
    
    
    _senderNameLbl.text = [[message sender] name];
    _fileImage.image    = [UIImage imageNamed:@"outline_description_black_36pt"];
    _timeLbl.text       = [[NSString stringWithFormat:@"%ld",(long)[message sentAt]] sentAtToTime];
    
    switch (tailDirection) {
        case MessageBubbleViewButtonTailDirectionRight:
            _senderNameLbl.textColor = [UIColor whiteColor];
            _timeLbl.textColor      = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
}
-(UIView *)bubble{
    
    if (!_bubble) {
        
        _bubble = [UIView new];
    }
    return _bubble;
}
-(UILabel*)senderNameLbl {
    
    if (!_senderNameLbl) {
        _senderNameLbl = [UILabel new];
        _senderNameLbl.numberOfLines = 1;
        _senderNameLbl.lineBreakMode = NSLineBreakByClipping;
        [_senderNameLbl setFont:[UIFont boldSystemFontOfSize:11]];
    }
    return _senderNameLbl;
}
-(UIImageView *)fileImage{
    if (!_fileImage) {
        _fileImage = [UIImageView new];
        _fileImage.contentMode = UIViewContentModeScaleAspectFit;
        _fileImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedImage:)];
        tap.numberOfTapsRequired = 1;
        [_fileImage addGestureRecognizer:tap];
    }
    return _fileImage;
}
- (void)tappedImage:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectFileAtIndexPath:)]) {
        [_delegate didSelectFileAtIndexPath:self.tag];
    }
}
-(UILabel*)timeLbl {
    
    if (!_timeLbl) {
        _timeLbl = [UILabel new];
        [_timeLbl setFont:[UIFont systemFontOfSize:11]];
    }
    return _timeLbl;
}
-(UIImageView *)readReceipts{
    if (!_readReceipts) {
        
        _readReceipts = [UIImageView new];
    }
    return _readReceipts;
}
@end
