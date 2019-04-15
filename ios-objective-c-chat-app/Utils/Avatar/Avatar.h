//
//  Avatar.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 27/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Avatar : NSObject

@property (readwrite, assign) CGRect frame;


@property (readwrite, copy) NSString *fullName;


@property (readwrite, strong) UIColor *backgroundColor;


@property (readwrite, strong) UIColor *initialsColor;


@property (readwrite, strong) UIFont *initialsFont;


@property (readonly, strong, nonatomic) UIImage *imageRepresentation;


@property (readonly, copy, nonatomic) NSString *initials;

- (instancetype)initWithRect:(CGRect)frame fullName:(NSString *)fullName;
@end

NS_ASSUME_NONNULL_END
