//
//  Avatar.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "Avatar.h"

@implementation Avatar

- (instancetype)initWithRect:(CGRect)frame fullName:(NSString *)fullName
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.fullName = fullName;
        self.backgroundColor = [UIColor lightGrayColor];
        self.initialsColor = [UIColor whiteColor];
        self.initialsFont = nil;
    }
    return self;
}

- (NSString *)initials {
    NSMutableString * firstCharacters = [NSMutableString string];
    NSArray * words = [self.fullName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    for (NSString * word in words) {
        if ([word length] > 0) {
            NSString * firstLetter = [word substringWithRange:[word rangeOfComposedCharacterSequenceAtIndex:0]];
            [firstCharacters appendString:[firstLetter uppercaseString]];
        }
    }
    return firstCharacters;
}

- (UIImage *)imageRepresentation
{
    CGRect frame = self.frame;
    
    // General Declarations
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Color Declarations
    UIColor* backgroundColor = self.backgroundColor;
    
    // Variable Declarations
    NSString* initials = self.initials;
    CGFloat fontSize = frame.size.height / 2.2;
    
    // Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame))];
    [backgroundColor setFill];
    [rectanglePath fill];
    
    // Initials String Drawing
    CGRect initialsStringRect = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
    NSMutableParagraphStyle* initialsStringStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    initialsStringStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *font;
    if (!self.initialsFont) {
        font = [UIFont systemFontOfSize:fontSize];
    } else {
        font = self.initialsFont;
    }
    
    NSDictionary* initialsStringFontAttributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: self.initialsColor, NSParagraphStyleAttributeName: initialsStringStyle};
    
    CGFloat initialsStringTextHeight = [initials boundingRectWithSize: CGSizeMake(initialsStringRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: initialsStringFontAttributes context: nil].size.height;
    CGContextSaveGState(context);
    CGContextClipToRect(context, initialsStringRect);
    [initials drawInRect: CGRectMake(CGRectGetMinX(initialsStringRect), CGRectGetMinY(initialsStringRect) + (CGRectGetHeight(initialsStringRect) - initialsStringTextHeight) / 2, CGRectGetWidth(initialsStringRect), initialsStringTextHeight) withAttributes: initialsStringFontAttributes];
    CGContextRestoreGState(context);
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

@end
