//
//  AudioVisualizerView.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 13/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AudioVisualizerView.h"

@interface AudioVisualizerView()
@property (nonatomic, strong) UIButton *_recordAudioBtn;
@property (nonatomic, strong) UIButton *_playAudioBtn;
@property (nonatomic, strong) UIButton *_sendAudioBtn;
@property (nonatomic, strong) UILabel  *_timerLbl;
@property (nonatomic, strong) UILabel  *_infoLbl;
@property (nonatomic, strong) AudioVisualizer *_audioVisualizer;
@property(nonatomic) NSUInteger gap;
@property(nonatomic) NSTimeInterval interval;
@end
@implementation AudioVisualizerView{

    double lowPassReslts;
    double lowPassReslts1;
    NSTimer *visualizerTimer;
    NSTimer *timer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self configureRecorder];
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker error: nil];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    [self configureInfolbl];
    
    [self configureTimerLabel];
    [self configureaAudioVisualizer];
    [self configureAudioButtons];
}

-(void)configureInfolbl
{
    
    __infoLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width*0.66, self.frame.size.height/4)];
    [__infoLbl setText:@"Record audio"];
    [__infoLbl setTextAlignment:NSTextAlignmentLeft];
    [self addSubview:__infoLbl];
}
-(void)configureTimerLabel
{
    
    __timerLbl = [[UILabel alloc]initWithFrame:CGRectMake(__infoLbl.frame.size.width, 0.0f, self.frame.size.width*0.33, self.frame.size.height/4)];
    [__timerLbl setText:@"00:00"];
    [__timerLbl setTextAlignment:NSTextAlignmentRight];
    [self addSubview:__timerLbl];
}
-(void)initTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(startTimer)
                                           userInfo:nil repeats:YES];
}
-(void)stopTimer
{
    [timer invalidate];
    self.interval = 0;
    timer = nil;
}
-(void)configureaAudioVisualizer
{
    __audioVisualizer = [[AudioVisualizer alloc]initWithBarsNumber:60.0f frame:CGRectMake(0.0f, __timerLbl.frame.size.height, self.frame.size.width, self.frame.size.height/2) andColor: [UIColor colorWithRed:0 green:(122.0f/255.0f) blue:1.0f alpha:1.0f]];
    [self addSubview:__audioVisualizer];
}

-(void)configureAudioButtons
{
    __recordAudioBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    __playAudioBtn   = [UIButton buttonWithType:(UIButtonTypeSystem)];
    __sendAudioBtn   = [UIButton buttonWithType:(UIButtonTypeSystem)];
    
    
    __playAudioBtn.frame = CGRectMake(0.0f, __audioVisualizer.frame.size.height + __timerLbl.frame.size.height, self.frame.size.width/3, 30.0f);
    
    __recordAudioBtn.frame = CGRectMake(__playAudioBtn.frame.size.width, __audioVisualizer.frame.size.height + __timerLbl.frame.size.height, self.frame.size.width/3, 30.0f);
    
    __sendAudioBtn.frame = CGRectMake(self.frame.size.width - self.frame.size.width*0.33, __audioVisualizer.frame.size.height + __timerLbl.frame.size.height, self.frame.size.width/3, 30.0f);

    [__recordAudioBtn setTitle:@"Record" forState:UIControlStateNormal];
    [__playAudioBtn setTitle:@"Play" forState:UIControlStateNormal];
    [__sendAudioBtn setTitle:@"Send" forState:UIControlStateNormal];
    
    [__recordAudioBtn addTarget:self action:@selector(playPauseButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [__playAudioBtn addTarget:self action:@selector(playTapped:) forControlEvents:UIControlEventTouchUpInside];
    [__sendAudioBtn addTarget:self action:@selector(sendTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:__recordAudioBtn];
    [self addSubview:__playAudioBtn];
    [self addSubview:__sendAudioBtn];
    [__playAudioBtn setHidden:YES];
    [__sendAudioBtn setHidden:YES];
}
#pragma mark -
- (IBAction)playPauseButtonPressed:(UIButton *)sender
{
    if (sender.isSelected)
    {
        [sender setTitle:@"Record" forState:UIControlStateNormal];
        [sender setSelected:NO];
        [self stopAudioVisualizer];
        
        [_audioRecorder stop];
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setActive:NO error:nil];

        [self stopTimer];
        [__playAudioBtn setHidden:NO];
        [__sendAudioBtn setHidden:NO];
        [__infoLbl setText:@"Recording stopped.."];
    }
    else
    {
        [sender setTitle:@"Stop" forState:UIControlStateNormal]; //  r e c o r d i n g   s t a r t e d //
        [sender setSelected:YES];
        [self startAudioVisualizer];

        if (!_audioRecorder.recording) {

            AVAudioSession *session = [AVAudioSession sharedInstance];
            [session setActive:YES error:nil];
            [_audioRecorder record];
        }
        [self initTimer];
        [__playAudioBtn setHidden:YES];
        [__sendAudioBtn setHidden:YES];
        [__infoLbl setText:@"Record audio.."];
    }
}
- (void) stopAudioVisualizer
{
    [visualizerTimer invalidate];
    visualizerTimer = nil;
    [__audioVisualizer stopAudioVisualizer];
}

- (void) startAudioVisualizer
{
    [visualizerTimer invalidate];
    visualizerTimer = nil;
    visualizerTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(visualizerTimer:) userInfo:nil repeats:YES];
}
-(void)configureRecorder
{
    NSArray *pathComponents = [NSArray arrayWithObjects:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                                                             NSUserDomainMask,
                                                                                             YES)lastObject],
                               @"audioMeno.m4a",
                               nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    
    
    // Define the recorder setting
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:outputFileURL
                                            settings:recordSetting
                                               error:NULL];
    _audioRecorder.delegate = self;
    _audioRecorder.meteringEnabled = YES;
    [_audioRecorder prepareToRecord];
}
#pragma mark - Visualizer Methods
- (void) visualizerTimer:(CADisplayLink *)timer
{
    [_audioPlayer updateMeters];
    
    const double ALPHA = 1.05;
    
    double averagePowerForChannel = pow(10, (0.05 * [_audioPlayer averagePowerForChannel:0]));
    lowPassReslts = ALPHA * averagePowerForChannel + (1.0 - ALPHA) * lowPassReslts;
    
    double averagePowerForChannel1 = pow(10, (0.05 * [_audioPlayer averagePowerForChannel:1]));
    lowPassReslts1 = ALPHA * averagePowerForChannel1 + (1.0 - ALPHA) * lowPassReslts1;
    
    [__audioVisualizer animateAudioVisualizerWithChannel0Level:lowPassReslts andChannel1Level:lowPassReslts1];
    
}
- (IBAction)playTapped:(id)sender {
    
    if (!_audioRecorder.recording) {
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_audioRecorder.url error:nil];
        [_audioPlayer setDelegate:self];
        [_audioPlayer play];
        __infoLbl.text = @"Playing..";
    }
}
- (IBAction)sendTapped:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(applicationdidRecordNewAudioWithURL:)]) {
        
        [_delegate applicationdidRecordNewAudioWithURL:_audioRecorder.url];
        
    }
}
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    NSLog(@"audioRecorderDidFinish_Recording");
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    NSLog(@"audioPlayerDidFinish_Playing");
    [__infoLbl setText:@"Playing finished.."];
}

-(void)startTimer{
    
    self.interval += 1;
    NSUInteger seconds = (int)self.interval;
    NSUInteger minutes = seconds/60;
    NSUInteger hours = minutes/60;
    
    NSString *timeValue = [NSString stringWithFormat:@"%lu:%lu:%lu",(unsigned long)hours, minutes%60, seconds%60];
    __timerLbl.text = timeValue;
    
    if (seconds/2 == 0) {
        __infoLbl.text = @"Recording..";
    }
}

@end
