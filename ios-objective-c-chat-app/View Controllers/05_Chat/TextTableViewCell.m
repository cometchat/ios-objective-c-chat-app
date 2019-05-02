//
//  TextTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 25/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "TextTableViewCell.h"

@interface TextTableViewCell()

@property (nonatomic ,retain) UIView        *bubble;
@property (nonatomic ,retain) UILabel       *senderNameLbl;
@property (nonatomic ,retain) UILabel       *messageLbl;
@property (nonatomic ,retain) UILabel       *timeLbl;
@property (nonatomic ,retain) UIImageView   *readReceipts;

@end

@implementation TextTableViewCell
{
    
    CGFloat width , height;
    CAShapeLayer *layer;
}
+(NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}

-(void)bind:(TextMessage *)messsage withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection
{
    
    CGSize senderNameSize  = [[[messsage sender] name] getSize];
    CGSize messageSize     = [[messsage text] getSize];
    CGSize timeSize        = [[[NSString stringWithFormat:@"%ld",(long)[messsage sentAt]] sentAtToTime] getSize];
    
    if (senderNameSize.width > messageSize.width) {
        width = senderNameSize.width;
    }else{
        width = messageSize.width;
    }
    if (timeSize.width > width) {
        width = timeSize.width;
    }
    width = width + 28.0f;
    height = paddingY
    + senderNameSize.height + paddingY
    + messageSize.height + paddingY
    + [@"00:00" getSize].height
    + paddingY;
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",width],@"width",[NSString stringWithFormat:@"%f",height],@"height",[NSString stringWithFormat:@"%f",CELL_ANIMATION_HEIGHT],@"CELL_ANIMATION_HEIGHT" ,nil];
    
    layer = [CAShapeLayer new];
    
    
    [self.contentView addSubview:self.bubble];
    [_bubble setTranslatesAutoresizingMaskIntoConstraints:NO];
    
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
            
            
        }
            
            break;
    }
    
    [_bubble addSubview:self.senderNameLbl];
    [_senderNameLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bubble addSubview:self.messageLbl];
    [_messageLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bubble addSubview:self.timeLbl];
    [_timeLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bubble addSubview:self.readReceipts];
    [_readReceipts setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_senderNameLbl ,_messageLbl , _timeLbl , _readReceipts);
    
    NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_senderNameLbl]-|" options:0 metrics:nil views:views];
    NSArray *subViewH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_messageLbl]-|" options:0 metrics:nil views:views];
    NSArray *subViewH3 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(16)-[_timeLbl]-[_readReceipts]-|" options:0 metrics:nil views:views];
    NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_senderNameLbl]-[_messageLbl]-[_timeLbl]|" options:0 metrics:nil views:views];
    NSArray *subViewV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_senderNameLbl]-[_messageLbl]-[_readReceipts]|" options:0 metrics:nil views:views];
    
    [_bubble addConstraints:subViewH1];
    [_bubble addConstraints:subViewH2];
    [_bubble addConstraints:subViewH3];
    [_bubble addConstraints:subViewV1];
    [_bubble addConstraints:subViewV2];
    
    
    _messageLbl.text    = [messsage text];
    _timeLbl.text       = [[NSString stringWithFormat:@"%ld",(long)[messsage sentAt]] sentAtToTime];
    
    switch (tailDirection) {
        case MessageBubbleViewButtonTailDirectionRight:
            _senderNameLbl.textColor = [UIColor whiteColor];
            _messageLbl.textColor   = [UIColor whiteColor];
            _timeLbl.textColor      = [UIColor whiteColor];
            
            break;
        case MessageBubbleViewButtonTailDirectionLeft:
            
            if ([messsage receiverType] == ReceiverTypeGroup) {
                 _senderNameLbl.text = [[messsage sender] name];
            }           
            break;
        default:
            break;
    }
    
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
-(UILabel*)messageLbl {
    
    if (!_messageLbl) {
        _messageLbl = [UILabel new];
        [_messageLbl setFont:[UIFont systemFontOfSize:14]];
        [_messageLbl setNumberOfLines:0];
        [_messageLbl setLineBreakMode:NSLineBreakByWordWrapping];
        [_messageLbl setBackgroundColor:[UIColor clearColor]];
        _messageLbl.userInteractionEnabled = YES;
    }
    return _messageLbl;
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
-(UIView *)bubble{
    
    if (!_bubble) {
        
        _bubble = [UIView new];
    }
    return _bubble;
}
-(void)updateConstraints{
    [super updateConstraints];
    
    layer.frame = _bubble.frame;
    
}
@end
