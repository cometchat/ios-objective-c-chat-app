//
//  AudioVisualizerView.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 13/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppConstants.h"
#import <AVFoundation/AVFoundation.h>
NS_ASSUME_NONNULL_BEGIN
@protocol AudioRecorderDelegate <NSObject>
- (void)applicationdidRecordNewAudioWithURL:(NSURL *)audioPath;
@end
@interface AudioVisualizerView : UIView<AVAudioRecorderDelegate ,AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, weak) id<AudioRecorderDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
