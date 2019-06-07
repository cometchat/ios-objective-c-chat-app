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


/**
 join a particular group

 @param group group to be joined
 @param target error
 @param groupJoined joined group
 */
+(void)joinGroup:(Group *)group withPassword:(NSString *)password in:(id)target onSuccess:(void(^)(Group* groupJoined))groupJoined;


/**
 leave a particular group

 @param group to be left
 @param isLeft succesfullt left a group
 */
+(void)leaveGroup:(Group *)group in:(id)target onSuccess:(void(^)(bool left))isLeft;
/**
 Ban paticular User / Group Member from Particular group

 @param user GroupMember to be ban
 @param group Group from which GroupMember needs to Ban
 @param isBanned is Successfully banned GroupMember from Group
 @param target Error in ban
 */
+ (void)banMember:(User *)user fromGroup:(Group *)group  in:(id)target onSuccess:(void(^)(bool banned))isBanned;



/**
 Un Ban paticular User / Group Member from Particular group

 @param user GroupMember to be Unban
 @param group Group from which GroupMember needs to UnBan
 @param isUnBanned is Successfully Unbanned GroupMember from Group
 @param target Error in Unban
 */
+ (void)unBanMember:(User *)user fromGroup:(Group *)group   in:(id)target onSuccess:(void(^)(bool unBanned))isUnBanned;



/**
 Block User from from contact for loggedin user

 @param user paticular user to be blocked
 @param isBlocked is Successfully blocked user
 @param target error in blocking user
 */
+ (void)block:(User *)user  in:(id)target onSuccess:(void (^)(bool isBlocked))isBlocked;



/**
 Unblock the blocked user from contacts for loggedin user

 @param user particular user to unBlock
 @param isUnBlocked is Successfully unBlocked user
 @param target error in unblocking user
 */
+ (void)unBlock:(User *)user  in:(id)target onSuccess:(void (^)(bool isUnBlocked))isUnBlocked;



/**
 Kick the Group Member out from particular group

 @param user GroupMember to be kicked
 @param group Group from GroupMember needs to kick
 @param target error
 @param isKicked is Successfully kicked GroupMember
 */
+ (void)kick:(User*)user fromGroup:(Group *)group in:(id)target onSuccess:(void (^)(bool kicked))isKicked;
@end

NS_ASSUME_NONNULL_END
