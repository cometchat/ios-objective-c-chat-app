//
//  ViewController.m
//  ios-objective-c-chat-app
//
//  Created by Pushpsen on 31/03/20.
//  Copyright © 2020 Pushpsen. All rights reserved.
//

#import "ViewController.h"
#import "AppConstants.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize unifiedUI;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [CometChat loginWithUID:@"superhero1" apiKey:AUTH_KEY onSuccess:^(User * user) {
        
        NSLog(@"login successful");
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            CometChatUnified *unifiedUI = [[CometChatUnified alloc]init];
            [unifiedUI setupWithStyle: UIModalPresentationPopover];
            [self presentViewController:unifiedUI animated:true completion:nil];
            
        });
        
    } onError:^(CometChatException * error) {
        
        NSLog(@"login failed");
    }];
    
    // Do any additional setup after loading the view.
}


@end
