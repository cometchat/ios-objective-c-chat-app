//
//  CallViewController.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 14/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "CallViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface CallViewController ()
@property (nonatomic ,retain) Call *current_call;
@end

@implementation CallViewController
{
    AVAudioPlayer *audioPlayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self playSound];
    [self blink];
    [self connectCall];
    
    self.profileImage.layer.masksToBounds = YES;
    [self.profileImage.layer setCornerRadius:self.profileImage.frame.size.height/2];
    
}
-(void)connectCall
{
    if ([self.entity isKindOfClass:[User class]]) {
        
        User *user = (User *)_entity;
        _current_call = [[Call alloc]initWithReceiverId:[user uid] callType:[self callType] receiverType:ReceiverTypeUser];
        
    } else {
        Group *group = (Group *)_entity;
        _current_call = [[Call alloc]initWithReceiverId:[group guid] callType:[self callType] receiverType:ReceiverTypeGroup];
    }
    
    [CometChat initiateCallWithCall:_current_call onSuccess:^(Call * _Nullable outgoing_call) {
        
        [[CallManager sharedInstance] reportOutGoingCall:self->_current_call forEntity:self->_entity];
        
    } onError:^(CometChatException * _Nullable error) {
        
        NSLog(@"%@",[error errorDescription]);
    }];
}
- (IBAction)hangupBtn:(UIButton *)sender {
    
    if (_current_call) {
        
        [CometChat rejectCallWithSessionID:[_current_call sessionID] status:callStatusCancelled onSuccess:^(Call * _Nullable rejectedCall) {
            
            NSLog(@"REJECTED CALL %@",[rejectedCall stringValue]);
            
        } onError:^(CometChatException * _Nullable error) {
            
            NSLog(@"ERROR %@",[error errorDescription]);
            
        }];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        [[CallManager sharedInstance] endCall];
    }];
}

-(void)playSound
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"call_ringback" ofType:@".wav"];
    NSURL *url = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    [audioPlayer setNumberOfLoops:-1];
    audioPlayer.volume = 1;
    [audioPlayer play];
}
-(void)blink{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setFromValue:[NSNumber numberWithFloat:1.0]];
    [animation setToValue:[NSNumber numberWithFloat:0.0]];
    [animation setDuration:0.5f];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionLinear]];
    [animation setAutoreverses:YES];
    [animation setRepeatCount:20000];
    [[self.status layer] addAnimation:animation forKey:@"opacity"];
}
-(void)setUp
{
    NSString *_entityURL;
    if ([self.entity isKindOfClass:[User class]]) {
        
        User *user = (User *)_entity;
        [self.calleeName setText:[user name]];
        _entityURL = [user avatar];
    } else {
        Group *group = (Group *)_entity;
        [self.calleeName setText:[group name]];
        _entityURL = [group icon];
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^(void) {
        
        [DownloadManager link:_entityURL completion:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (data) {
                UIImage* image = [[UIImage alloc] initWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.profileImage.image = image;
                    });
                }
            }
        }];
    });
    
}
@end
