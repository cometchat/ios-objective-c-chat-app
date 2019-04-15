// Generated by Apple Swift version 4.2.1 (swiftlang-1000.11.42 clang-1000.11.45.1)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if __has_feature(modules)
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="CometChatPro",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

enum MessageType : NSInteger;
enum ReceiverType : NSInteger;
enum MessageCategory : NSInteger;
@class User;

SWIFT_CLASS("_TtC12CometChatPro11BaseMessage")
@interface BaseMessage : NSObject
@property (nonatomic) NSInteger id;
@property (nonatomic, copy) NSString * _Nonnull muid;
@property (nonatomic, copy) NSString * _Nonnull senderUid;
@property (nonatomic, copy) NSString * _Nonnull receiverUid;
@property (nonatomic) enum MessageType messageType;
@property (nonatomic) enum ReceiverType receiverType;
@property (nonatomic) double deliveredAt;
@property (nonatomic) double readAt;
@property (nonatomic) NSInteger sentAt;
@property (nonatomic, copy) NSString * _Nonnull status;
@property (nonatomic) enum MessageCategory messageCategory;
@property (nonatomic, strong) User * _Nullable sender;
@property (nonatomic, copy) NSDictionary<NSString *, id> * _Nullable metaData;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid messageType:(enum MessageType)messageType receiverType:(enum ReceiverType)receiverType OBJC_DESIGNATED_INITIALIZER;
@end

@class AppEntity;

SWIFT_CLASS("_TtC12CometChatPro13ActionMessage")
@interface ActionMessage : BaseMessage
@property (nonatomic, strong) AppEntity * _Nullable actionBy;
@property (nonatomic, strong) AppEntity * _Nullable actionFor;
@property (nonatomic, strong) AppEntity * _Nullable actionOn;
@property (nonatomic, copy) NSString * _Nullable message;
@property (nonatomic, copy) NSString * _Nullable rawData;
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid messageType:(enum MessageType)messageType receiverType:(enum ReceiverType)receiverType SWIFT_UNAVAILABLE;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC12CometChatPro9AppEntity")
@interface AppEntity : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC12CometChatPro10Attachment")
@interface Attachment : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

@class BannedGroupMembersRequestBuilder;
@class GroupMember;
@class CometChatException;

SWIFT_CLASS("_TtC12CometChatPro25BannedGroupMembersRequest")
@interface BannedGroupMembersRequest : NSObject
- (nonnull instancetype)initWithBuilder:(BannedGroupMembersRequestBuilder * _Nonnull)builder OBJC_DESIGNATED_INITIALIZER;
- (void)fetchNextOnSuccess:(void (^ _Nonnull)(NSArray<GroupMember *> * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtCC12CometChatPro25BannedGroupMembersRequest32BannedGroupMembersRequestBuilder")
@interface BannedGroupMembersRequestBuilder : NSObject
- (nonnull instancetype)initWithGuid:(NSString * _Nonnull)guid OBJC_DESIGNATED_INITIALIZER;
- (BannedGroupMembersRequestBuilder * _Nonnull)setWithLimit:(NSInteger)limit SWIFT_WARN_UNUSED_RESULT;
- (BannedGroupMembersRequest * _Nonnull)build SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


enum BaseMessageTypes : NSInteger;

@interface BaseMessage (SWIFT_EXTENSION(CometChatPro))
@property (nonatomic, readonly) enum BaseMessageTypes messgeTypeFromBaseMessage;
@end

typedef SWIFT_ENUM(NSInteger, BaseMessageTypes, closed) {
  BaseMessageTypesTextMessage = 0,
  BaseMessageTypesMediaMessage = 1,
  BaseMessageTypesActionMessage = 2,
  BaseMessageTypesCall = 3,
  BaseMessageTypesCustomMessage = 4,
  BaseMessageTypesNone = 5,
};

enum callStatus : NSInteger;
enum CallType : NSInteger;

SWIFT_CLASS("_TtC12CometChatPro4Call")
@interface Call : BaseMessage
@property (nonatomic, copy) NSString * _Nullable sessionID;
@property (nonatomic) enum callStatus callStatus;
@property (nonatomic) enum CallType callType;
@property (nonatomic, copy) NSString * _Nullable action;
@property (nonatomic, copy) NSString * _Nullable rawData;
@property (nonatomic) double initiatedAt;
@property (nonatomic) double joinedAt;
@property (nonatomic, strong) AppEntity * _Nullable callInitiator;
@property (nonatomic, strong) AppEntity * _Nullable callReceiver;
- (nonnull instancetype)initWithReceiverId:(NSString * _Nonnull)receiverId callType:(enum CallType)callType receiverType:(enum ReceiverType)receiverType OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid messageType:(enum MessageType)messageType receiverType:(enum ReceiverType)receiverType SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC12CometChatPro9CometChat")
@interface CometChat : NSObject
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly) BOOL isInitialised;)
+ (BOOL)isInitialised SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
- (nonnull instancetype)initWithAppId:(NSString * _Nonnull)appId onSuccess:(void (^ _Nonnull)(BOOL))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nonnull))onError OBJC_DESIGNATED_INITIALIZER;
@end


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)getUserWithUID:(NSString * _Nonnull)UID onSuccess:(void (^ _Nonnull)(User * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
@end


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, MessageCategory, closed) {
  MessageCategoryMessage = 0,
  MessageCategoryAction = 1,
  MessageCategoryCall = 2,
};




@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, actionType, closed) {
  actionTypeJoined = 0,
  actionTypeLeft = 1,
  actionTypeKicked = 2,
  actionTypeBanned = 3,
  actionTypeUnbanned = 4,
  actionTypeInvited = 5,
  actionTypeScopeChanged = 6,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, GroupMemberScopeType, closed) {
  GroupMemberScopeTypeAdmin = 0,
  GroupMemberScopeTypeModerator = 1,
  GroupMemberScopeTypeParticipant = 2,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, callStatus, closed) {
  callStatusInitiated = 0,
  callStatusOngoing = 1,
  callStatusUnanswered = 2,
  callStatusRejected = 3,
  callStatusBusy = 4,
  callStatusCancelled = 5,
  callStatusEnded = 6,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, UserStatus, closed) {
  UserStatusOnline = 0,
  UserStatusOffline = 1,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, MemberScope, closed) {
  MemberScopeAdmin = 0,
  MemberScopeModerator = 1,
  MemberScopeParticipant = 2,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, groupType, closed) {
  groupTypePublic = 0,
  groupTypePrivate = 1,
  groupTypePassword = 2,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, CallType, closed) {
  CallTypeAudio = 0,
  CallTypeVideo = 1,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, MessageType, closed) {
  MessageTypeText = 0,
  MessageTypeImage = 1,
  MessageTypeVideo = 2,
  MessageTypeAudio = 3,
  MessageTypeFile = 4,
  MessageTypeGroupMember = 5,
  MessageTypeCustom = 6,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)markMessageAsReadWithMessage:(BaseMessage * _Nonnull)message;
@end


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
@end

typedef SWIFT_ENUM(NSInteger, ReceiverType, closed) {
  ReceiverTypeUser = 0,
  ReceiverTypeGroup = 1,
};

typedef SWIFT_ENUM(NSInteger, XMPPMsgType, closed) {
  XMPPMsgTypeChat = 0,
  XMPPMsgTypeGroupChat = 1,
};


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)loginWithUID:(NSString * _Nonnull)UID apiKey:(NSString * _Nonnull)apiKey onSuccess:(void (^ _Nonnull)(User * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nonnull))onError;
+ (void)loginWithAuthToken:(NSString * _Nonnull)authToken onSuccess:(void (^ _Nonnull)(User * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nonnull))onError;
+ (void)logoutOnSuccess:(void (^ _Nonnull)(NSString * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nonnull))onError;
@end

@class TypingIndicator;

@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)startTypingWithIndicator:(TypingIndicator * _Nonnull)indicator;
+ (void)endTypingWithIndicator:(TypingIndicator * _Nonnull)indicator;
@end

@class TextMessage;
@class MediaMessage;
@class CustomMessage;

@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)sendTextMessageWithMessage:(TextMessage * _Nonnull)message onSuccess:(void (^ _Nonnull)(TextMessage * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)sendMediaMessageWithMessage:(MediaMessage * _Nonnull)message onSuccess:(void (^ _Nonnull)(MediaMessage * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)sendCustomMessageWithMessage:(CustomMessage * _Nonnull)message onSuccess:(void (^ _Nonnull)(CustomMessage * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
@end


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)getPreviousMessagesByTimestampWithLimit:(NSInteger)limit timeStamp:(NSInteger)timeStamp onSuccess:(void (^ _Nonnull)(NSArray<BaseMessage *> * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)getPreviousMessagesByIdWithLimit:(NSInteger)limit messageId:(NSInteger)messageId onSuccess:(void (^ _Nonnull)(NSArray<BaseMessage *> * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)getNextMessagesByTimestampWithLimit:(NSInteger)limit timeStamp:(NSInteger)timeStamp onSuccess:(void (^ _Nonnull)(NSArray<BaseMessage *> * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)getNextMessagesByIdWithLimit:(NSInteger)limit messageId:(NSInteger)messageId onSuccess:(void (^ _Nonnull)(NSArray<BaseMessage *> * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
@end


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)kickGroupMemberWithUID:(NSString * _Nonnull)UID GUID:(NSString * _Nonnull)GUID onSuccess:(void (^ _Nonnull)(NSString * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)banGroupMemberWithUID:(NSString * _Nonnull)UID GUID:(NSString * _Nonnull)GUID onSuccess:(void (^ _Nonnull)(NSString * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)unbanGroupMemberWithUID:(NSString * _Nonnull)UID GUID:(NSString * _Nonnull)GUID onSuccess:(void (^ _Nonnull)(NSString * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)updateGroupMemberScopeWithUID:(NSString * _Nonnull)UID GUID:(NSString * _Nonnull)GUID scope:(enum MemberScope)scope onSuccess:(void (^ _Nonnull)(NSString * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
@end



@class Group;

@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)updateGroupWithGroup:(Group * _Nonnull)group onSuccess:(void (^ _Nonnull)(Group * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)deleteGroupWithGUID:(NSString * _Nonnull)GUID onSuccess:(void (^ _Nonnull)(NSString * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)createGroupWithGroup:(Group * _Nonnull)group onSuccess:(void (^ _Nonnull)(Group * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)joinGroupWithGUID:(NSString * _Nonnull)GUID groupType:(enum groupType)groupType password:(NSString * _Nullable)password onSuccess:(void (^ _Nonnull)(Group * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)getGroupWithGUID:(NSString * _Nonnull)GUID onSuccess:(void (^ _Nonnull)(Group * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)leaveGroupWithGUID:(NSString * _Nonnull)GUID onSuccess:(void (^ _Nonnull)(NSString * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
@end

@class UIView;

@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)initiateCallWithCall:(Call * _Nonnull)call onSuccess:(void (^ _Nonnull)(Call * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)acceptCallWithSessionID:(NSString * _Nonnull)sessionID onSuccess:(void (^ _Nonnull)(Call * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)rejectCallWithSessionID:(NSString * _Nonnull)sessionID status:(enum callStatus)status onSuccess:(void (^ _Nonnull)(Call * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)endCallWithSessionID:(NSString * _Nonnull)sessionID onSuccess:(void (^ _Nonnull)(Call * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
+ (void)startCallWithSessionID:(NSString * _Nonnull)sessionID inView:(UIView * _Nonnull)inView userJoined:(void (^ _Nonnull)(User * _Nullable))userJoined userLeft:(void (^ _Nonnull)(User * _Nullable))userLeft onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError callEnded:(void (^ _Nonnull)(Call * _Nullable))callEnded;
@end


@interface CometChat (SWIFT_EXTENSION(CometChatPro))
+ (void)startServices;
+ (void)stopServices;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly) BOOL isCallOngoing;)
+ (BOOL)isCallOngoing SWIFT_WARN_UNUSED_RESULT;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, readonly, strong) Call * _Nullable currentCall;)
+ (Call * _Nullable)currentCall SWIFT_WARN_UNUSED_RESULT;
+ (NSInteger)getLastDeliveredMessageId SWIFT_WARN_UNUSED_RESULT;
+ (User * _Nullable)getLoggedInUser SWIFT_WARN_UNUSED_RESULT;
@end

@protocol CometChatMessageDelegate;
@protocol CometChatCallDelegate;
@protocol CometChatUserDelegate;
@protocol CometChatGroupDelegate;

@interface CometChat (SWIFT_EXTENSION(CometChatPro))
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, weak) id <CometChatMessageDelegate> _Nullable messagedelegate;)
+ (id <CometChatMessageDelegate> _Nullable)messagedelegate SWIFT_WARN_UNUSED_RESULT;
+ (void)setMessagedelegate:(id <CometChatMessageDelegate> _Nullable)value;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, weak) id <CometChatCallDelegate> _Nullable calldelegate;)
+ (id <CometChatCallDelegate> _Nullable)calldelegate SWIFT_WARN_UNUSED_RESULT;
+ (void)setCalldelegate:(id <CometChatCallDelegate> _Nullable)value;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, weak) id <CometChatUserDelegate> _Nullable userdelegate;)
+ (id <CometChatUserDelegate> _Nullable)userdelegate SWIFT_WARN_UNUSED_RESULT;
+ (void)setUserdelegate:(id <CometChatUserDelegate> _Nullable)value;
SWIFT_CLASS_PROPERTY(@property (nonatomic, class, weak) id <CometChatGroupDelegate> _Nullable groupdelegate;)
+ (id <CometChatGroupDelegate> _Nullable)groupdelegate SWIFT_WARN_UNUSED_RESULT;
+ (void)setGroupdelegate:(id <CometChatGroupDelegate> _Nullable)value;
@end


SWIFT_PROTOCOL("_TtP12CometChatPro21CometChatCallDelegate_")
@protocol CometChatCallDelegate
- (void)onIncomingCallReceivedWithIncomingCall:(Call * _Nullable)incomingCall error:(CometChatException * _Nullable)error;
- (void)onOutgoingCallAcceptedWithAcceptedCall:(Call * _Nullable)acceptedCall error:(CometChatException * _Nullable)error;
- (void)onOutgoingCallRejectedWithRejectedCall:(Call * _Nullable)rejectedCall error:(CometChatException * _Nullable)error;
- (void)onIncomingCallCancelledWithCanceledCall:(Call * _Nullable)canceledCall error:(CometChatException * _Nullable)error;
@end


SWIFT_PROTOCOL("_TtP12CometChatPro11CustomError_")
@protocol CustomError
@property (nonatomic, readonly, copy) NSString * _Nonnull errorDescription;
@property (nonatomic, readonly, copy) NSString * _Nonnull errorCode;
@end


SWIFT_CLASS("_TtC12CometChatPro18CometChatException")
@interface CometChatException : NSObject <CustomError>
@property (nonatomic, copy) NSString * _Nonnull errorDescription;
@property (nonatomic, copy) NSString * _Nonnull errorCode;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


SWIFT_PROTOCOL("_TtP12CometChatPro22CometChatGroupDelegate_")
@protocol CometChatGroupDelegate
- (void)onGroupMemberJoinedWithAction:(ActionMessage * _Nonnull)action joinedUser:(User * _Nonnull)joinedUser joinedGroup:(Group * _Nonnull)joinedGroup;
- (void)onGroupMemberLeftWithAction:(ActionMessage * _Nonnull)action leftUser:(User * _Nonnull)leftUser leftGroup:(Group * _Nonnull)leftGroup;
- (void)onGroupMemberKickedWithAction:(ActionMessage * _Nonnull)action kickedUser:(User * _Nonnull)kickedUser kickedBy:(User * _Nonnull)kickedBy kickedFrom:(Group * _Nonnull)kickedFrom;
- (void)onGroupMemberBannedWithAction:(ActionMessage * _Nonnull)action bannedUser:(User * _Nonnull)bannedUser bannedBy:(User * _Nonnull)bannedBy bannedFrom:(Group * _Nonnull)bannedFrom;
- (void)onGroupMemberUnbannedWithAction:(ActionMessage * _Nonnull)action unbannedUser:(User * _Nonnull)unbannedUser unbannedBy:(User * _Nonnull)unbannedBy unbannedFrom:(Group * _Nonnull)unbannedFrom;
- (void)onGroupMemberScopeChangedWithAction:(ActionMessage * _Nonnull)action user:(User * _Nonnull)user scopeChangedTo:(NSString * _Nonnull)scopeChangedTo scopeChangedFrom:(NSString * _Nonnull)scopeChangedFrom group:(Group * _Nonnull)group;
@end

@class MessageReceipt;

SWIFT_PROTOCOL("_TtP12CometChatPro24CometChatMessageDelegate_")
@protocol CometChatMessageDelegate
@optional
- (void)onTextMessageReceivedWithTextMessage:(TextMessage * _Nullable)textMessage error:(CometChatException * _Nullable)error;
- (void)onMediaMessageReceivedWithMediaMessage:(MediaMessage * _Nullable)mediaMessage error:(CometChatException * _Nullable)error;
- (void)onCustomMessageReceivedWithCustomMessage:(CustomMessage * _Nullable)customMessage error:(CometChatException * _Nullable)error;
- (void)onTypingStarted:(TypingIndicator * _Nonnull)typingDetails;
- (void)onTypingEnded:(TypingIndicator * _Nonnull)typingDetails;
- (void)onMessageDeliveredWithReceipt:(MessageReceipt * _Nonnull)receipt;
- (void)onMessageReadWithReceipt:(MessageReceipt * _Nonnull)receipt;
@end


SWIFT_PROTOCOL("_TtP12CometChatPro21CometChatUserDelegate_")
@protocol CometChatUserDelegate
- (void)onUserOnlineWithUser:(User * _Nonnull)user;
- (void)onUserOfflineWithUser:(User * _Nonnull)user;
@end


SWIFT_CLASS("_TtC12CometChatPro4User")
@interface User : AppEntity
@property (nonatomic, copy) NSString * _Nullable uid;
@property (nonatomic, copy) NSString * _Nullable name;
@property (nonatomic, copy) NSString * _Nullable email;
@property (nonatomic, copy) NSString * _Nullable avatar;
@property (nonatomic, copy) NSString * _Nullable link;
@property (nonatomic, copy) NSString * _Nullable role;
@property (nonatomic, copy) NSDictionary<NSString *, id> * _Nullable metadata;
@property (nonatomic) NSInteger credits;
@property (nonatomic) enum UserStatus status;
@property (nonatomic, copy) NSString * _Nullable statusMessage;
@property (nonatomic) NSInteger lastActiveAt;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
- (nonnull instancetype)initWithUid:(NSString * _Nonnull)uid name:(NSString * _Nonnull)name OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithUid:(NSString * _Nonnull)uid name:(NSString * _Nonnull)name email:(NSString * _Nonnull)email avatar:(NSString * _Nonnull)avatar link:(NSString * _Nonnull)link role:(NSString * _Nonnull)role metadata:(NSDictionary<NSString *, NSString *> * _Nonnull)metadata credits:(NSInteger)credits status:(enum UserStatus)status statusMessage:(NSString * _Nonnull)statusMessage lastActiveAt:(NSInteger)lastActiveAt OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC12CometChatPro11CurrentUser")
@interface CurrentUser : User
- (nonnull instancetype)initWithUid:(NSString * _Nonnull)uid name:(NSString * _Nonnull)name OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithUid:(NSString * _Nonnull)uid name:(NSString * _Nonnull)name email:(NSString * _Nonnull)email avatar:(NSString * _Nonnull)avatar link:(NSString * _Nonnull)link role:(NSString * _Nonnull)role metadata:(NSDictionary<NSString *, NSString *> * _Nonnull)metadata credits:(NSInteger)credits status:(enum UserStatus)status statusMessage:(NSString * _Nonnull)statusMessage lastActiveAt:(NSInteger)lastActiveAt OBJC_DESIGNATED_INITIALIZER;
@end



SWIFT_CLASS("_TtC12CometChatPro13CustomMessage")
@interface CustomMessage : BaseMessage
@property (nonatomic, copy) NSDictionary<NSString *, id> * _Nullable customData;
@property (nonatomic, copy) NSString * _Nullable subType;
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid receiverType:(enum ReceiverType)receiverType customData:(NSDictionary<NSString *, id> * _Nonnull)customData OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid messageType:(enum MessageType)messageType receiverType:(enum ReceiverType)receiverType SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC12CometChatPro5Group")
@interface Group : AppEntity
@property (nonatomic, copy) NSString * _Nonnull guid;
@property (nonatomic, copy) NSString * _Nullable name;
@property (nonatomic, copy) NSString * _Nullable icon;
@property (nonatomic, copy) NSString * _Nullable groupDescription;
@property (nonatomic, copy) NSString * _Nullable owner;
@property (nonatomic) enum groupType groupType;
@property (nonatomic, copy) NSString * _Nullable password;
@property (nonatomic, copy) NSDictionary<NSString *, id> * _Nullable metadata;
@property (nonatomic) NSInteger createdAt;
@property (nonatomic) NSInteger updatedAt;
@property (nonatomic) NSInteger joinedAt;
@property (nonatomic) enum GroupMemberScopeType scope;
@property (nonatomic) BOOL hasJoined;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
- (nonnull instancetype)initWithGuid:(NSString * _Nonnull)guid name:(NSString * _Nonnull)name groupType:(enum groupType)groupType password:(NSString * _Nullable)password OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithGuid:(NSString * _Nonnull)guid name:(NSString * _Nonnull)name groupType:(enum groupType)groupType password:(NSString * _Nullable)password icon:(NSString * _Nonnull)icon description:(NSString * _Nonnull)description OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC12CometChatPro11GroupMember")
@interface GroupMember : User
@property (nonatomic) enum GroupMemberScopeType scope;
@property (nonatomic) NSInteger joinedAt;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithUid:(NSString * _Nonnull)uid name:(NSString * _Nonnull)name SWIFT_UNAVAILABLE;
- (nonnull instancetype)initWithUid:(NSString * _Nonnull)uid name:(NSString * _Nonnull)name email:(NSString * _Nonnull)email avatar:(NSString * _Nonnull)avatar link:(NSString * _Nonnull)link role:(NSString * _Nonnull)role metadata:(NSDictionary<NSString *, NSString *> * _Nonnull)metadata credits:(NSInteger)credits status:(enum UserStatus)status statusMessage:(NSString * _Nonnull)statusMessage lastActiveAt:(NSInteger)lastActiveAt SWIFT_UNAVAILABLE;
@end

@class GroupMembersRequestBuilder;

SWIFT_CLASS("_TtC12CometChatPro19GroupMembersRequest")
@interface GroupMembersRequest : NSObject
- (nonnull instancetype)initWithBuilder:(GroupMembersRequestBuilder * _Nonnull)builder OBJC_DESIGNATED_INITIALIZER;
- (void)fetchNextOnSuccess:(void (^ _Nonnull)(NSArray<GroupMember *> * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtCC12CometChatPro19GroupMembersRequest26GroupMembersRequestBuilder")
@interface GroupMembersRequestBuilder : NSObject
- (nonnull instancetype)initWithGuid:(NSString * _Nonnull)guid OBJC_DESIGNATED_INITIALIZER;
- (GroupMembersRequestBuilder * _Nonnull)setWithLimit:(NSInteger)limit SWIFT_WARN_UNUSED_RESULT;
- (GroupMembersRequest * _Nonnull)build SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

@class GroupsRequestBuilder;

SWIFT_CLASS("_TtC12CometChatPro13GroupsRequest")
@interface GroupsRequest : NSObject
- (nonnull instancetype)initWithBuilder:(GroupsRequestBuilder * _Nonnull)builder OBJC_DESIGNATED_INITIALIZER;
- (void)fetchNextOnSuccess:(void (^ _Nonnull)(NSArray<Group *> * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtCC12CometChatPro13GroupsRequest20GroupsRequestBuilder")
@interface GroupsRequestBuilder : NSObject
- (nonnull instancetype)initWithLimit:(NSInteger)limit OBJC_DESIGNATED_INITIALIZER;
- (GroupsRequestBuilder * _Nonnull)setWithLimit:(NSInteger)limit SWIFT_WARN_UNUSED_RESULT;
- (GroupsRequest * _Nonnull)build SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtC12CometChatPro12MediaMessage")
@interface MediaMessage : BaseMessage
@property (nonatomic, copy) NSString * _Nullable url;
@property (nonatomic, copy) NSString * _Nullable caption;
@property (nonatomic, strong) Attachment * _Nullable attachment;
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid fileurl:(NSString * _Nonnull)fileurl messageType:(enum MessageType)messageType receiverType:(enum ReceiverType)receiverType OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid messageType:(enum MessageType)messageType receiverType:(enum ReceiverType)receiverType SWIFT_UNAVAILABLE;
@end

enum ReceiptType : NSInteger;

SWIFT_CLASS("_TtC12CometChatPro14MessageReceipt")
@interface MessageReceipt : NSObject
@property (nonatomic, copy) NSString * _Nonnull receiverId;
@property (nonatomic) enum ReceiverType receiverType;
@property (nonatomic, copy) NSString * _Nonnull messageId;
@property (nonatomic, strong) User * _Nullable sender;
@property (nonatomic) enum ReceiptType receiptType;
@property (nonatomic) NSInteger timeStamp;
- (nonnull instancetype)initWithMessageId:(NSString * _Nonnull)messageId sender:(User * _Nonnull)sender receiverId:(NSString * _Nonnull)receiverId receiverType:(enum ReceiverType)receiverType receiptType:(enum ReceiptType)receiptType timeStamp:(NSInteger)timeStamp OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end

typedef SWIFT_ENUM(NSInteger, ReceiptType, closed) {
  ReceiptTypeDelivered = 0,
  ReceiptTypeRead = 1,
};

@class MessageRequestBuilder;

SWIFT_CLASS("_TtC12CometChatPro15MessagesRequest")
@interface MessagesRequest : NSObject
- (nonnull instancetype)initWithBuilder:(MessageRequestBuilder * _Nonnull)builder OBJC_DESIGNATED_INITIALIZER;
- (void)fetchPreviousOnSuccess:(void (^ _Nonnull)(NSArray<BaseMessage *> * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
- (void)fetchNextOnSuccess:(void (^ _Nonnull)(NSArray<BaseMessage *> * _Nullable))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtCC12CometChatPro15MessagesRequest21MessageRequestBuilder")
@interface MessageRequestBuilder : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (MessageRequestBuilder * _Nonnull)setWithLimit:(NSInteger)limit SWIFT_WARN_UNUSED_RESULT;
- (MessageRequestBuilder * _Nonnull)setWithGUID:(NSString * _Nonnull)GUID SWIFT_WARN_UNUSED_RESULT;
- (MessageRequestBuilder * _Nonnull)setWithUID:(NSString * _Nonnull)UID SWIFT_WARN_UNUSED_RESULT;
- (MessageRequestBuilder * _Nonnull)setWithTimeStamp:(NSInteger)timeStamp SWIFT_WARN_UNUSED_RESULT;
- (MessageRequestBuilder * _Nonnull)setWithMessageID:(NSInteger)messageID SWIFT_WARN_UNUSED_RESULT;
- (MessagesRequest * _Nonnull)build SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC12CometChatPro11TextMessage")
@interface TextMessage : BaseMessage
@property (nonatomic, copy) NSString * _Nonnull text;
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid text:(NSString * _Nonnull)text messageType:(enum MessageType)messageType receiverType:(enum ReceiverType)receiverType OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)initWithReceiverUid:(NSString * _Nonnull)receiverUid messageType:(enum MessageType)messageType receiverType:(enum ReceiverType)receiverType SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC12CometChatPro15TypingIndicator")
@interface TypingIndicator : NSObject
@property (nonatomic, copy) NSString * _Nonnull receiverID;
@property (nonatomic) enum ReceiverType receiverType;
@property (nonatomic, copy) NSDictionary<NSString *, id> * _Nullable metadata;
@property (nonatomic, strong) User * _Nullable sender;
- (nonnull instancetype)initWithReceiverID:(NSString * _Nonnull)receiverID receiverType:(enum ReceiverType)receiverType OBJC_DESIGNATED_INITIALIZER;
- (NSString * _Nonnull)stringValue SWIFT_WARN_UNUSED_RESULT;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end




@class UsersRequestBuilder;

SWIFT_CLASS("_TtC12CometChatPro12UsersRequest")
@interface UsersRequest : NSObject
- (nonnull instancetype)initWithBuilder:(UsersRequestBuilder * _Nonnull)builder OBJC_DESIGNATED_INITIALIZER;
- (void)fetchNextOnSuccess:(void (^ _Nonnull)(NSArray<User *> * _Nonnull))onSuccess onError:(void (^ _Nonnull)(CometChatException * _Nullable))onError;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_DEPRECATED_MSG("-init is unavailable");
@end


SWIFT_CLASS("_TtCC12CometChatPro12UsersRequest19UsersRequestBuilder")
@interface UsersRequestBuilder : NSObject
- (nonnull instancetype)initWithLimit:(NSInteger)limit OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
- (UsersRequestBuilder * _Nonnull)setWithLimit:(NSInteger)limit SWIFT_WARN_UNUSED_RESULT;
- (UsersRequest * _Nonnull)build SWIFT_WARN_UNUSED_RESULT;
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
