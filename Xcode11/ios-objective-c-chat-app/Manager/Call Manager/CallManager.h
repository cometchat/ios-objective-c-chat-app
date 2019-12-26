//
//  CalllManager.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 22/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"
NS_ASSUME_NONNULL_BEGIN

@protocol CallManagerDelegate <NSObject>

- (void)callDidAnswer:(Call*)answeredCall;
- (void)callDidReject:(Call*)rejectedCall;
- (void)callDidFail:(Call*)failedCall;

@end

@interface CallManager : NSObject
+ (CallManager*)sharedInstance;
- (void)reportIncomingCall:(Call *)call;
-(void)reportOutGoingCall:(Call *)call forEntity:(AppEntity*)entity;
- (void)endCall;
@property (nonatomic ,strong ,nullable ) Call *currentCall;
@property (nonatomic, weak) id<CallManagerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
