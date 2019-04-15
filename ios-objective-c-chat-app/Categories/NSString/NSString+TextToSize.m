//
//  NSString+TextToSize.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 21/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "NSString+TextToSize.h"

#import <UIKit/UIKit.h>

@implementation NSString (TextToSize)

-(CGSize)getSizeForTextForView:(UIView*)view{
    
    CGFloat messageMaxWidth = view.frame.size.width*66/100;
    
    CGSize constraint = CGSizeMake(messageMaxWidth, CGFLOAT_MAX);
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:FONT_SIZE], NSFontAttributeName, nil];
    
    CGRect paraRect = [self boundingRectWithSize:constraint options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil];
    
    CGSize size = paraRect.size;
    
    return size;
}
@end
