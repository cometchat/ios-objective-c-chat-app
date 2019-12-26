//
//  Alert.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 31/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface Alert : NSObject
 + (void)showAlertForError:(CometChatException *)error in:(id)target;
@end

NS_ASSUME_NONNULL_END
