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
}
+(NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}

-(void)bind:(TextMessage *)message withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection
{
    
    width = [[message text] getSize].width + 24.0f;
    height = [[message text] getSize].height + paddingY * 2;
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSString stringWithFormat:@"%f",width],@"width",
                             [NSString stringWithFormat:@"%f",height],@"height"
                             ,nil];
    
    
    [self.contentView addSubview:self.bubble];
    [_bubble setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.timeLbl];
    [_timeLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    switch (tailDirection) {
            
        case MessageBubbleViewButtonTailDirectionRight:
        {
            
            [self.contentView addSubview:self.readReceipts];
            [_readReceipts setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_timeLbl]-[_bubble(width)]-(2)-[_readReceipts]-(2)-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble,_timeLbl,_readReceipts)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_bubble(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble,_timeLbl)];
            
            //Bottom
            NSLayoutConstraint *bottom1 =[NSLayoutConstraint
                                          constraintWithItem:_timeLbl
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.contentView
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:-5.0f];
            //Bottom
            NSLayoutConstraint *bottom2 =[NSLayoutConstraint
                                          constraintWithItem:_bubble
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.contentView
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:-5.0f];
            NSLayoutConstraint *bottom3 =[NSLayoutConstraint
                                          constraintWithItem:_readReceipts
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.contentView
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:-5.0f];
            
            [self.contentView addConstraints:subViewH1];
            [self.contentView addConstraints:subViewV1];
            [self.contentView addConstraint:bottom1];
            [self.contentView addConstraint:bottom2];
            [self.contentView addConstraint:bottom3];
            
            [_bubble setBackgroundColor:[UIColor colorWithRed:0.09 green:0.54 blue:1 alpha:1]];
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f,width,height) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path  = maskPath.CGPath;
            _bubble.layer.mask = maskLayer;
        }
            break;
        case MessageBubbleViewButtonTailDirectionLeft:
        {
            
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bubble(width)]-[_timeLbl]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble,_timeLbl)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bubble(height)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble,_timeLbl)];
            
            //Bottom
            NSLayoutConstraint *bottom1 =[NSLayoutConstraint
                                          constraintWithItem:_timeLbl
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.contentView
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:-5.0f];
            //Bottom
            NSLayoutConstraint *bottom2 =[NSLayoutConstraint
                                          constraintWithItem:_bubble
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.contentView
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:-5.0f];
            
            [self.contentView addConstraints:subViewH1];
            [self.contentView addConstraints:subViewV1];
            [self.contentView addConstraint:bottom1];
            [self.contentView addConstraint:bottom2];
            
            [_bubble setBackgroundColor:[UIColor colorWithRed:(223.0f/255.0f) green:(222.0f/255.0f) blue:(229.0f/255.0f) alpha:1.0f]];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f,width,height) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path  = maskPath.CGPath;
            _bubble.layer.mask = maskLayer;
            
            if ([message receiverType] == ReceiverTypeGroup)
            {
                
                [self.contentView addSubview:self.senderNameLbl];
                [_senderNameLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
                
                [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.senderNameLbl attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeading) multiplier:1.0f constant:paddingX*2]];
                [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_senderNameLbl][_bubble(height)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble,_senderNameLbl)]];
            }
        }
            
            break;
    }
    
    [_bubble addSubview:self.messageLbl];
    [_messageLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_messageLbl);
    
    NSArray *subViewH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_messageLbl]-|" options:0 metrics:nil views:views];
    NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_messageLbl]-|" options:0 metrics:nil views:views];
    
    [_bubble addConstraints:subViewH2];
    [_bubble addConstraints:subViewV1];
   
    switch (tailDirection) {
        case MessageBubbleViewButtonTailDirectionRight:
            
            _messageLbl.textColor   = [UIColor whiteColor];
            
            if ([message readAt]) {
                [_readReceipts setImage:[UIImage imageNamed:@"round_done_all_black_18pt"]];
            }else if ([message deliveredAt]){
                [_readReceipts setImage:[UIImage imageNamed:@"round_done_all_black_18pt"]];
                [_readReceipts setTintColor:[UIColor lightGrayColor]];
            }else {
                [_readReceipts setImage:[UIImage imageNamed:@"round_done_black_18pt"]];
                [_readReceipts setTintColor:[UIColor lightGrayColor]];
            }
            break;
        case MessageBubbleViewButtonTailDirectionLeft:
            
            if ([message receiverType] == ReceiverTypeGroup) {
                _senderNameLbl.text = [[message sender] name];
            }
            break;
        default:
            break;
    }
    _messageLbl.text    = [message text];
    _timeLbl.text       = [[NSString stringWithFormat:@"%ld",(long)[message sentAt]] sentAtToTime];
    
}
-(UILabel*)senderNameLbl {
    
    if (!_senderNameLbl) {
        _senderNameLbl = [UILabel new];
        _senderNameLbl.numberOfLines = 1;
        _senderNameLbl.lineBreakMode = NSLineBreakByClipping;
        [_senderNameLbl setFont:[UIFont boldSystemFontOfSize:11]];
        [_senderNameLbl setTextColor:[UIColor lightGrayColor]];
    }
    return _senderNameLbl;
}
-(UILabel*)messageLbl {
    
    if (!_messageLbl) {
        _messageLbl = [UILabel new];
        [_messageLbl setFont:[UIFont systemFontOfSize:14]];
        [_messageLbl setNumberOfLines:0];
        [_messageLbl setBackgroundColor:[UIColor clearColor]];
        _messageLbl.userInteractionEnabled = YES;
    }
    return _messageLbl;
}
-(UILabel*)timeLbl {
    
    if (!_timeLbl) {
        _timeLbl = [UILabel new];
        [_timeLbl setFont:[UIFont systemFontOfSize:11]];
        _timeLbl.textColor      = [UIColor lightGrayColor];
    }
    return _timeLbl;
}
-(UIImageView *)readReceipts{
    if (!_readReceipts) {
        
        _readReceipts = [UIImageView new];
        [_readReceipts setImage:[UIImage imageNamed:@"round_schedule_black_18pt"]];
        [_readReceipts setImage:[[_readReceipts image] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)]];
        
    }
    return _readReceipts;
}
-(UIView *)bubble{
    
    if (!_bubble) {
        _bubble = [UIView new];
    }
    return _bubble;
}

@end
