//
//  CometChatProRequests.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 12/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "CometChatProRequests.h"

@implementation CometChatProRequests


#pragma mark  -  Login

+(void)loginWithUID:(NSString *)uid andAPIKey:(NSString *)api_key loggedinUser:(void(^)(User *user))aUser andError:(void(^)(CometChatException *error))aError{

    
    [CometChat loginWithUID:uid apiKey:api_key onSuccess:^(User * user) {

        aUser(user);

    } onError:^(CometChatException * error) {

        aError(error);
    }];

}
//
//+(void)loginWithUID:(NSString *)uid andAPIKey:(NSString *)api_key loggedinUser:(void(^)(User *user))aUser andError:(void(^)(CometChatException *error))aError{
//
//    [CometChat login]
//}
#pragma mark  -  Contact List

#pragma mark  -  Group List

#pragma mark  -  Join Group

+(void)joinGroup:(Group *)group withPassword:(NSString *)password in:(id)target onSuccess:(void (^)(Group * _Nonnull))groupJoined{
    
    [CometChat joinGroupWithGUID:[group guid] groupType:[group groupType] password:password onSuccess:^(Group * _Nonnull _joinedGroup ) {
        
        groupJoined(_joinedGroup);
        
    } onError:^(CometChatException * _Nullable _error) {
        
        [Alert showAlertForError:_error in:target];
        
    }];
}
#pragma mark  -  Leave Group

+(void)leaveGroup:(Group *)group in:(nonnull id)target onSuccess:(nonnull void (^)(bool))isLeft{
    
    
    [CometChat leaveGroupWithGUID:[group guid] onSuccess:^(NSString * _Nonnull _isSuccess) {
        
        isLeft(YES);
        
    } onError:^(CometChatException * _Nullable _error) {
        
        [Alert showAlertForError:target in:self];
        
    }];
    
}

#pragma mark  -  Group Members

#pragma mark  -  Ban Members

+(void)banMember:(User *)user fromGroup:(Group *)group in:(id)target onSuccess:(void (^)(bool))isBanned
{
    [CometChat banGroupMemberWithUID:[user uid] GUID:[group guid] onSuccess:^(NSString * _Nonnull isSuccess) {
        
        isBanned(YES);
        
    } onError:^(CometChatException * _Nullable error) {
        
        [Alert showAlertForError:error in:target];
        
    }];
}

#pragma mark  -  UnBan Members

+ (void)unBanMember:(User *)user fromGroup:(Group *)group in:(id)target onSuccess:(void (^)(bool))isUnBanned
{
    [CometChat unbanGroupMemberWithUID:[user uid] GUID:[group guid] onSuccess:^(NSString * _Nonnull isSuccess) {
        
        isUnBanned(YES);
        
    } onError:^(CometChatException * _Nullable error) {
        
        [Alert showAlertForError:error in:target];
        
    }];
}
#pragma mark  -  Block User

+ (void)block:(User *)user in:(id)target onSuccess:(void (^)(bool))isBlocked
{
    [CometChat blockUsers:@[[user uid]] onSuccess:^(NSDictionary<NSString *,id> * _Nonnull isSuccess) {
        
        isBlocked(YES);
        
    } onError:^(CometChatException * _Nullable error) {
        
        [Alert showAlertForError:error in:target];
        
    }];
}
#pragma mark  -  UnBlock User

+ (void)unBlock:(User *)user in:(id)target onSuccess:(void (^)(bool))isUnBlocked
{
    [CometChat unblockUsers:@[[user uid]] onSuccess:^(NSDictionary<NSString *,id> * _Nonnull isSuccess) {
        
        isUnBlocked(YES);
        
    } onError:^(CometChatException * _Nullable error) {
        
        [Alert showAlertForError:error in:target];
        
    }];
}

#pragma mark  -  UnBlock User

+ (void)kick:(User *)user fromGroup:(Group *)group in:(id)target onSuccess:(void (^)(bool))isKicked
{
    
    [CometChat kickGroupMemberWithUID:[user uid] GUID:[group guid] onSuccess:^(NSString * _Nonnull isSuccess) {
        
        isKicked(YES);
        
    } onError:^(CometChatException * _Nullable error) {
        
        [Alert showAlertForError:error in:target];
        
    }];
}

+(void)getUnreadCountForAllUsers:(NSString *)uid  onSuccess:(void(^)(NSDictionary *success))success andError:(void(^)(CometChatException *error))aError{
    
    
    [CometChat getUnreadMessageCountForAllUsersWithHideMessagesFromBlockedUsers:false onSuccess:^(NSDictionary<NSString *,id> * _Nonnull response) {
        
        success(response);
        
    } onError:^(CometChatException * _Nullable error) {
        
        aError(error);
    }];
}


+(void)getUnreadCountForAllGroups:(NSString *)uid  onSuccess:(void(^)(NSDictionary *success))success andError:(void(^)(CometChatException *error))aError{
    
    [CometChat getUnreadMessageCountForAllGroupsWithHideMessagesFromBlockedUsers:false onSuccess:^(NSDictionary<NSString *,id> * _Nonnull response) {
         success(response);
    } onError:^(CometChatException * _Nullable error) {
         aError(error);
    }];

}
@end
