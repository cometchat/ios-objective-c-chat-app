//
//  MediaTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 06/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "MediaTableViewCell.h"
@interface MediaTableViewCell()
@property (nonatomic ,retain) UIImageView   *imageHolder;
@property (nonatomic ,retain) UILabel       *senderNameLbl;
@property (nonatomic ,retain) UILabel       *timeLbl;
@property (nonatomic ,retain) UIImageView   *readReceipts;
@end

@implementation MediaTableViewCell
{
    CGFloat width , height;
    MessageBubbleViewButtonTailDirection taildirection;
}
+(NSString*)reuseIdentifier{
    return NSStringFromClass([self class]);
}
-(void)bind:(MediaMessage *)message withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection indexPath:(NSIndexPath *)indexPath {
    
    width = self.frame.size.width *0.50;
    height = width/0.75;
    
    [self.contentView addSubview:self.imageHolder];
    [_imageHolder setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.timeLbl];
    [_timeLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",width],@"width",
                             [NSString stringWithFormat:@"%f",height],@"height",
                             [NSString stringWithFormat:@"%f",CELL_ANIMATION_HEIGHT],@"CELL_ANIMATION_HEIGHT" ,nil];
    
    
    switch (tailDirection) {
        case MessageBubbleViewButtonTailDirectionRight:
        {
            
            [self.contentView addSubview:self.readReceipts];
            [_readReceipts setTranslatesAutoresizingMaskIntoConstraints:NO];
            
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_timeLbl]-[_imageHolder(width)]-(2)-[_readReceipts]-(2)-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder,_timeLbl,_readReceipts)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_imageHolder(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            
            //Bottom
            NSLayoutConstraint *bottom1 =[NSLayoutConstraint
                                          constraintWithItem:_timeLbl
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.contentView
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:-paddingY*3];
            
            NSLayoutConstraint *bottom3 =[NSLayoutConstraint
                                          constraintWithItem:_readReceipts
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.contentView
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:-paddingY*3];
            
            [self.contentView addConstraints:subViewH1];
            [self.contentView addConstraints:subViewV1];
            [self.contentView addConstraint:bottom1];
            [self.contentView addConstraint:bottom3];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f,width,height) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path  = maskPath.CGPath;
            _imageHolder.layer.mask = maskLayer;
            
            
            if ([message readAt]) {
                [_readReceipts setImage:[UIImage imageNamed:@"round_done_all_black_18pt"]];
            }else if ([message deliveredAt]){
                [_readReceipts setImage:[UIImage imageNamed:@"round_done_all_black_18pt"]];
                [_readReceipts setTintColor:[UIColor lightGrayColor]];
            }else {
                [_readReceipts setImage:[UIImage imageNamed:@"round_done_black_18pt"]];
                [_readReceipts setTintColor:[UIColor lightGrayColor]];
            }
            
        }
            break;
        case MessageBubbleViewButtonTailDirectionLeft:
        {
            
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_imageHolder(width)]-[_timeLbl]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder,_timeLbl)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_imageHolder(height)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            
            //Bottom
            NSLayoutConstraint *bottom1 =[NSLayoutConstraint
                                          constraintWithItem:_timeLbl
                                          attribute:NSLayoutAttributeBottom
                                          relatedBy:NSLayoutRelationEqual
                                          toItem:self.contentView
                                          attribute:NSLayoutAttributeBottom
                                          multiplier:1.0f
                                          constant:-paddingY*3];
            
            [self.contentView addConstraints:subViewH1];
            [self.contentView addConstraints:subViewV1];
            [self.contentView addConstraint:bottom1];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f,width,height) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path  = maskPath.CGPath;
            _imageHolder.layer.mask = maskLayer;
            
            
            if ([message receiverType] == ReceiverTypeGroup)
            {
                
                [self.contentView addSubview:self.senderNameLbl];
                [_senderNameLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
                
                [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.senderNameLbl attribute:(NSLayoutAttributeLeading) relatedBy:(NSLayoutRelationEqual) toItem:self.contentView attribute:(NSLayoutAttributeLeading) multiplier:1.0f constant:paddingX*2]];
                [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_senderNameLbl][_imageHolder(height)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder,_senderNameLbl)]];
            }
        }
        default:
            break;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        NSLog(@"[mediaMessage url] %@",[message url]);
        
        if (message.messageType == MessageTypeVideo) {
            
            UIImage *image = [self loadThumbNail:[NSURL URLWithString:[message url]]];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.tag == indexPath.row) {
                        _imageHolder.image = image;
                        [self setNeedsLayout];
                    }
                });
            }
            
        }else if (message.messageType == MessageTypeImage){
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[message url]]];
            
            UIImage* image = [[UIImage alloc] initWithData:imageData];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.tag == indexPath.row) {
                        _imageHolder.image = image;
                        [self setNeedsLayout];
                    }
                });
            }
        }
    });
    _timeLbl.text       = [[NSString stringWithFormat:@"%ld",(long)[message sentAt]] sentAtToTime];
}
-(UIImageView *)imageHolder{
    if (!_imageHolder) {
        _imageHolder = [UIImageView new];
        _imageHolder.contentMode = UIViewContentModeScaleAspectFill;
        _imageHolder.clipsToBounds = YES;
        _imageHolder.userInteractionEnabled = YES;
        _imageHolder.backgroundColor = [UIColor lightGrayColor];
        _imageHolder.image = [UIImage imageNamed:@"place_holder"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedImage:)];
        tap.numberOfTapsRequired = 1;
        [_imageHolder addGestureRecognizer:tap];
    }
    return _imageHolder;
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
- (void)tappedImage:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectMediaAtIndexPath:)]) {
        [_delegate didSelectMediaAtIndexPath:self.tag];
    }
}
//-(void)updateConstraints{
//    [super updateConstraints];
//
//
//    width = self.frame.size.width *0.66;
//    height = width/0.75 + paddingY*2;
//
//    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",width],@"width",[NSString stringWithFormat:@"%f",height],@"height",[NSString stringWithFormat:@"%f",CELL_ANIMATION_HEIGHT],@"CELL_ANIMATION_HEIGHT" ,nil];
//
//    switch (taildirection) {
//        case MessageBubbleViewButtonTailDirectionRight:
//        {
//            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageHolder(width)]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
//            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(CELL_ANIMATION_HEIGHT)-[_imageHolder(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
//
//            [self.contentView addConstraints:subViewH1];
//            [self.contentView addConstraints:subViewV1];
//        }
//            break;
//        case MessageBubbleViewButtonTailDirectionLeft:
//        {
//            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_imageHolder(width)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
//            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(CELL_ANIMATION_HEIGHT)-[_imageHolder(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
//
//            [self.contentView addConstraints:subViewH1];
//            [self.contentView addConstraints:subViewV1];
//
//        }
//            break;
//        default:
//            break;
//    }
//
//    layer.frame = _imageHolder.frame;
//}
-(UIImage *)loadThumbNail:(NSURL *)urlVideo
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:urlVideo options:nil];
    AVAssetImageGenerator *generate = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generate.appliesPreferredTrackTransform=TRUE;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generate copyCGImageAtTime:time actualTime:NULL error:&err];
    NSLog(@"err==%@, imageRef==%@", err, imgRef);
    return [[UIImage alloc] initWithCGImage:imgRef];
}
@end
