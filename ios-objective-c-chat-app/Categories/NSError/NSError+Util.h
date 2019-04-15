//
//  NSError+Util.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSError (Util)
+ (NSError *)description:(NSString *)description code:(NSInteger)code;

- (NSString *)description;
@end

NS_ASSUME_NONNULL_END
