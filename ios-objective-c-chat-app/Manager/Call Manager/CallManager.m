//
//  CalllManager.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 22/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "CallManager.h"
#import <CallKit/CallKit.h>
#import <UIKit/UIKit.h>

@interface CallManager()<CXProviderDelegate>
@property (nonatomic ,strong) NSUUID *currentCallID;
@property (nonatomic, strong) CXCallController *callController;
@end
@implementation CallManager

+ (CallManager *)sharedInstance {
    static CallManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void)reportIncomingCall:(Call *)call
{
    
    NSString *caller = [(User*)[call callInitiator] name];
    _currentCall = call;
    _currentCallID = [NSUUID new];
    BOOL hasVideo;
    if ([call callType] == CallTypeAudio) {
        hasVideo = NO;
    } else {
        hasVideo = YES;
    }
    
    CXProviderConfiguration *config = [[CXProviderConfiguration alloc]initWithLocalizedName:@"CometChatPro"];
    config.ringtoneSound = @"ringtone.caf";
    config.supportsVideo = YES;
    if (@available(iOS 11.0, *)) {
        config.includesCallsInRecents = false;
    } else {
        // Fallback on earlier versions
    }
    CXProvider *provider = [[CXProvider alloc]initWithConfiguration:config];
    [provider setDelegate:self queue:nil];
    
    CXCallUpdate *update= [CXCallUpdate new];
    update.remoteHandle = [[CXHandle alloc]initWithType:(CXHandleTypeGeneric) value:caller];
    update.hasVideo = hasVideo;
    
    [provider reportNewIncomingCallWithUUID:_currentCallID update:update completion:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            if (self.delegate && [self.delegate respondsToSelector:@selector(callDidFail:)]) {
                [self.delegate callDidFail:self->_currentCall];
            }
        }
    }];
}
-(void)reportOutGoingCall:(Call *)call forEntity:(AppEntity*)entity{

    NSString *name;
    _currentCall = call;
    _currentCallID = [NSUUID new];
    if ([entity isKindOfClass:User.class]) {
        
        name = [(User*)entity name];
        
    } else if ([entity isKindOfClass:Group.class]){
        name = [(Group*)entity name];
    }
    
    CXProviderConfiguration *config = [[CXProviderConfiguration alloc]initWithLocalizedName:@"CometChatPro"];
    config.iconTemplateImageData = UIImagePNGRepresentation([UIImage imageNamed:@"pizza"]);
    CXProvider *provider = [[CXProvider alloc]initWithConfiguration:config];
    [provider setDelegate:self queue:nil];
    CXCallController *controller = [[CXCallController alloc]init];
    CXHandle *handle = [[CXHandle alloc]initWithType:(CXHandleTypeGeneric) value:name];
    
    CXStartCallAction *action  = [[CXStartCallAction alloc]initWithCallUUID:_currentCallID handle:handle];
    
    CXTransaction *transaction = [[CXTransaction alloc]initWithAction:action];
    
    [controller requestTransaction:transaction completion:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            if (self.delegate && [self.delegate respondsToSelector:@selector(callDidFail:)]) {
                [self.delegate callDidFail:self->_currentCall];
            }
        }
    }];
    double delayInSeconds = 0.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [provider reportOutgoingCallWithUUID:self->_currentCallID connectedAtDate:nil];
        
    });
    
}
- (void)endCall {
    
    CXEndCallAction *endCallAction = [[CXEndCallAction alloc] initWithCallUUID:_currentCallID];
    CXTransaction *transaction = [[CXTransaction alloc] initWithAction:endCallAction];
    
    [self.callController requestTransaction:transaction completion:^(NSError *error) {
        if (error) {
            NSLog(@"Failed to submit end-call transaction request: %@", error);
        } else {
            NSLog(@"End-call transaction successfully done");
        }
    }];
}
- (void)requestTransaction:(CXTransaction*)transaction {
    [self.callController requestTransaction:transaction completion:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            if (self.delegate && [self.delegate respondsToSelector:@selector(callDidFail:)]) {
                [self.delegate callDidFail:self->_currentCall];
            }
        }
    }];
}
- (CXCallController*)callController {
    if (!_callController) {
        _callController = [[CXCallController alloc] init];
    }
    return _callController;
}
-(void)providerDidReset:(CXProvider *)provider
{
    NSLog(@"providerDidReset");
}
-(void)provider:(CXProvider *)provider performEndCallAction:(CXEndCallAction *)action
{
    //todo: stop audio
    //todo: end network call
    self.currentCallID = nil;
    self.currentCall = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(callDidReject:)]) {
        [self.delegate callDidReject:_currentCall];
    }
    [action fulfill];
}

- (void)provider:(CXProvider *)provider performAnswerCallAction:(CXAnswerCallAction *)action{
    //todo: configure audio session
    //todo: answer network call
    if (self.delegate && [self.delegate respondsToSelector:@selector(callDidAnswer:)]) {
        [self.delegate callDidAnswer:_currentCall];
    }
    [action fulfill];
}
@end
//__weak typeof(self) weakSelf = self;
