//
//  CometChatProRequests.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 12/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface CometChatProRequests : NSObject
/**
 This simple authentication procedure is useful when you are in development or if you do not require additional security.

 @param uid the `UID` of the user that you would like to login
 @param api_key `CometChat API KEY`
 @param aUser the user object containing all the information of the logged in user.
 @param aError error in while login
 */
+(void)loginWithUID:(NSString *)uid andAPIKey:(NSString *)api_key loggedinUser:(void(^)(User *user))aUser andError:(void(^)(CometChatException *error))aError;
@end

NS_ASSUME_NONNULL_END
