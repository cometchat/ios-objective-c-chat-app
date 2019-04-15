//
//  CometChatProRequests.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 12/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "CometChatProRequests.h"

@implementation CometChatProRequests


+(void)loginWithUID:(NSString *)uid andAPIKey:(NSString *)api_key loggedinUser:(void(^)(User *user))aUser andError:(void(^)(CometChatException *error))aError{
    
    [CometChat loginWithUID:uid apiKey:api_key onSuccess:^(User * user) {
        
        aUser(user);
        
    } onError:^(CometChatException * error) {
        
        aError(error);
    }];
    
}
@end
