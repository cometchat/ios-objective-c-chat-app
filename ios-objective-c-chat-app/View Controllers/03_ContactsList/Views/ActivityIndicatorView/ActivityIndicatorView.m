//
//  ActivityIndicatorView.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 13/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "ActivityIndicatorView.h"

@implementation ActivityIndicatorView

static CGFloat _defaultHeight = 60.0;

+ (CGFloat)defaultHeight{
    return _defaultHeight;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self _init];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self _init];
    }
    
    return self;
}

- (id)initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyle)style
{
    self = [super initWithActivityIndicatorStyle:style];
    
    if (self)
    {
        [self _init];
    }
    
    return self;
}
- (void)_init
{
    self.animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.animation.fromValue = [NSNumber numberWithFloat:0.0f];
    self.animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
    self.animation.duration = 1.0f;
    self.animation.repeatCount = HUGE_VAL;
    
}
@end
