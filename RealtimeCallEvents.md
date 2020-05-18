
# Real time events for Calling

Since, swift supports extension for AppDelegate, we have managed it for Swift. But if you're using Objective C then you've to add necessory events manually inside your project.
___

## Step 1: 

- Open `AppDelegate.h` file. 

- Register for `CometChatCallDelegate` in Application class. 


```swift
@interface AppDelegate : UIResponder <UIApplicationDelegate, CometChatCallDelegate>
```
___


## Step 2:

- Open `AppDelegate.m` file. 

- Add below code in App Delegate. 

```swift

- (void)onIncomingCallReceivedWithIncomingCall:(Call *)incomingCall error:(CometChatException *)error{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CometChatIncomingCall *incomingCallScreen = [[CometChatIncomingCall alloc]init];
        [incomingCallScreen setCallWithCall:incomingCall];
        [ROOTVIEW presentViewController:incomingCallScreen animated:YES completion:^{}];
        });
    [CometChatCallManager.incomingCallDelegate onIncomingCallReceivedWithIncomingCall:incomingCall error:error];
}

- (void)onOutgoingCallRejectedWithRejectedCall:(Call *)rejectedCall error:(CometChatException *)error{
    
    [CometChatCallManager.outgoingCallDelegate onOutgoingCallRejectedWithRejectedCall:rejectedCall error:error];
}

- (void)onIncomingCallCancelledWithCanceledCall:(Call *)canceledCall error:(CometChatException *)error{
    
    [CometChatCallManager.incomingCallDelegate onIncomingCallCancelledWithCanceledCall:canceledCall error:error];
    
}

- (void)onOutgoingCallAcceptedWithAcceptedCall:(Call *)acceptedCall error:(CometChatException *)error{
    
    [CometChatCallManager.outgoingCallDelegate onOutgoingCallAcceptedWithAcceptedCall:acceptedCall error:error];
    
}

```

___

