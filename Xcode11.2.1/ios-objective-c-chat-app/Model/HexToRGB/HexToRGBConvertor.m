//
//  HexToRGBConvertor.m
//  SparkChat
//
//  Created by Inscripts on 30/10/15.
//  Copyright © 2015 inscripts. All rights reserved.
//

#import "HexToRGBConvertor.h"

@implementation HexToRGBConvertor


- (UIColor *)colorWithHexString:(NSString *)str {
    
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:(UInt32)x];
    
}

- (UIColor *)colorWithHex:(UInt32)col {
    
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
    
}

@end
