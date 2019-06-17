//
//  AudioTableViewCell.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 12/04/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AudioTableViewCell.h"
@interface AudioTableViewCell()
@property (nonatomic ,retain) UIView *bubble;
@property (nonatomic ,retain) UILabel *senderNameLbl;
@property (nonatomic ,retain) UIButton *audioPlayPause;
@property (nonatomic ,retain) UILabel      *fileName;
@property (nonatomic ,retain) UILabel      *fileSize;
@property (nonatomic ,retain) UILabel *timeLbl;
@property (nonatomic ,retain) UIImageView *readReceipts;
@end
@implementation AudioTableViewCell
{
     HexToRGBConvertor *hexToRGB;
    CGFloat width , height;
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
    width = self.frame.size.width *0.40;
    height = width*0.40;
    hexToRGB = [HexToRGBConvertor new];
    
    [self.contentView addSubview:self.bubble];
    [_bubble setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.timeLbl];
    [_timeLbl setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.contentView addSubview:self.readReceipts];
    [_readReceipts setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *metrics = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",width],@"width",[NSString stringWithFormat:@"%f",height],@"height",[NSString stringWithFormat:@"%f",CELL_ANIMATION_HEIGHT],@"CELL_ANIMATION_HEIGHT" ,nil];
    
    
    switch (tailDirection) {
        case MessageBubbleViewButtonTailDirectionRight:
        {
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_timeLbl]-[_bubble(width)]-(2)-[_readReceipts]-(2)-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble,_timeLbl,_readReceipts)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_bubble(height)]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble)];
            
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
            [_bubble setBackgroundColor:[hexToRGB colorWithHexString:@"#2636BE"]];
            
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.0f, 0.0f,width,height) byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(10.0, 10.0)];
            
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.path  = maskPath.CGPath;
            _bubble.layer.mask = maskLayer;
            
        }
            break;
        case MessageBubbleViewButtonTailDirectionLeft:
        {
            NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_bubble(width)]-[_timeLbl]" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble,_timeLbl)];
            NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bubble(height)]|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_bubble)];
            
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
        default:
            break;
    }
    [_bubble addSubview:self.audioPlayPause];
    [_audioPlayPause setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bubble addSubview:self.fileName];
    [_fileName setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_bubble addSubview:self.fileSize];
    [_fileSize setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_audioPlayPause , _fileName , _fileSize);
    
    NSArray *subViewH1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_audioPlayPause]-[_fileName]-|" options:0 metrics:nil views:views];
    NSArray *subViewH2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_audioPlayPause]-[_fileSize]-|" options:0 metrics:nil views:views];
    NSArray *subViewV1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_audioPlayPause]-|" options:0 metrics:nil views:views];
    NSArray *subViewV2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_fileName][_fileSize(20)]-|" options:0 metrics:nil views:views];
    
    [_bubble addConstraints:subViewH1];
    [_bubble addConstraints:subViewH2];
    [_bubble addConstraints:subViewV1];
    [_bubble addConstraints:subViewV2];
    
    _timeLbl.text       = [[NSString stringWithFormat:@"%ld",(long)[message sentAt]] sentAtToTime];
    _fileName.text      = @"some file name"; //attchement.filename
    _fileSize.text      = @"12MB"; // attechment.size
    
    switch (tailDirection) {
        case MessageBubbleViewButtonTailDirectionRight:
            
            _fileSize.textColor = [UIColor whiteColor];
            _fileName.textColor = [UIColor whiteColor];
            
            if ([message readByMeAt]) {
                [_readReceipts setImage:[UIImage imageNamed:@"round_done_all_black_18pt"]];
            }else if ([message deliveredToMeAt]){
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
            [self.audioPlayPause setTintColor:[UIColor blackColor]];
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
-(UIButton*)audioPlayPause {
    
    if (!_audioPlayPause) {
        _audioPlayPause = [UIButton new];
        
        UIImage *image = [[UIImage imageNamed:@"audioPlay"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_audioPlayPause setImage:image forState:UIControlStateNormal];
        _audioPlayPause.tintColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedImage:)];
        tap.numberOfTapsRequired = 1;
        [_audioPlayPause addGestureRecognizer:tap];
    }
    return _audioPlayPause;
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
    }
    return _readReceipts;
}
-(UIView *)bubble{
    
    if (!_bubble) {
        _bubble = [UIView new];
    }
    return _bubble;
}
-(UILabel *)fileName
{
    if (!_fileName) {
        _fileName = [UILabel new];
        [_fileSize setNumberOfLines:0];
        [_fileName setFont:[UIFont systemFontOfSize:11.0f]];
        _fileName.lineBreakMode = NSLineBreakByTruncatingMiddle;
    }
    return _fileName;
}
-(UILabel *)fileSize
{
    if (!_fileSize) {
        _fileSize = [UILabel new];
        [_fileSize setFont:[UIFont systemFontOfSize:11.0f weight:(UIFontWeightSemibold)]];
    }
    return _fileSize;
}
- (void)tappedImage:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectAudioAtIndexPath:)]) {
        [_delegate didSelectAudioAtIndexPath:self.tag];
    }
}

@end
