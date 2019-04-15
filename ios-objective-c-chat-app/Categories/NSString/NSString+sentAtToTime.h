//
//  NSString+sentAtToTime.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 21/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (sentAtToTime)
-(NSDate*)sentAtDate;
-(NSString*)sentAtToTime;
@end

NS_ASSUME_NONNULL_END
