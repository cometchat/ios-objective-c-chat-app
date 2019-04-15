//
//  MediaTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 06/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "MediaTableViewCell.h"
@interface MediaTableViewCell()
@property (nonatomic ,retain) UIImageView* imageHolder;
@end

@implementation MediaTableViewCell
{
    CGFloat width , height;
    CAShapeLayer *layer;
    MessageBubbleViewButtonTailDirection taildirection;
}
+(NSString*)reuseIdentifier{
    return @"mediareuseIdentifier";
}
-(void)bind:(MediaMessage *)message withTailDirection:(MessageBubbleViewButtonTailDirection)tailDirection indexPath:(NSIndexPath *)indexPath {
    
    width = self.frame.size.width *0.66;
    height = width/0.75 + paddingY*2;
    
    layer = [CAShapeLayer new];
    
    [self.contentView addSubview:self.imageHolder];
    [_imageHolder setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",width],@"width",[NSString stringWithFormat:@"%f",height],@"height",[NSString stringWithFormat:@"%f",CELL_ANIMATION_HEIGHT],@"CELL_ANIMATION_HEIGHT" ,nil];
    
    
    switch (tailDirection) {
        case MessageBubbleViewButtonTailDirectionRight:
        {
            
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageHolder(width)]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(CELL_ANIMATION_HEIGHT)-[_imageHolder(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            
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
            [bezierPath closePath];
            
            CAShapeLayer *incomingMessageLayer = [CAShapeLayer new];
            incomingMessageLayer.path = bezierPath.CGPath;
            _imageHolder.layer.mask = incomingMessageLayer;
        }
            break;
        case MessageBubbleViewButtonTailDirectionLeft:
        {
            
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_imageHolder(width)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(CELL_ANIMATION_HEIGHT)-[_imageHolder(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            
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
            
            [bezierPath closePath];
            
            CAShapeLayer *incomingMessageLayer = [CAShapeLayer new];
            incomingMessageLayer.path = bezierPath.CGPath;
            _imageHolder.layer.mask = incomingMessageLayer;
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
}
-(UIImageView *)imageHolder{
    if (!_imageHolder) {
        _imageHolder = [UIImageView new];
        _imageHolder.contentMode = UIViewContentModeScaleAspectFill;
        _imageHolder.clipsToBounds = YES;
        _imageHolder.userInteractionEnabled = YES;
    }
    return _imageHolder;
}
-(void)updateConstraints{
    [super updateConstraints];
    
    
    width = self.frame.size.width *0.66;
    height = width/0.75 + paddingY*2;
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",width],@"width",[NSString stringWithFormat:@"%f",height],@"height",[NSString stringWithFormat:@"%f",CELL_ANIMATION_HEIGHT],@"CELL_ANIMATION_HEIGHT" ,nil];
    
    switch (taildirection) {
        case MessageBubbleViewButtonTailDirectionRight:
        {
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageHolder(width)]-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(CELL_ANIMATION_HEIGHT)-[_imageHolder(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            
            [self.contentView addConstraints:subViewH1];
            [self.contentView addConstraints:subViewV1];
        }
            break;
        case MessageBubbleViewButtonTailDirectionLeft:
        {
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_imageHolder(width)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(CELL_ANIMATION_HEIGHT)-[_imageHolder(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_imageHolder)];
            
            [self.contentView addConstraints:subViewH1];
            [self.contentView addConstraints:subViewV1];
            
        }
            break;
        default:
            break;
    }
    
    layer.frame = _imageHolder.frame;
}
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
