//
//  Alert.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 31/05/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "Alert.h"


@implementation Alert
 + (void)showAlertForError:(CometChatException *)error in:(id)target
{
    __weak __typeof__(target) weakSelf = target; __typeof__(target) strongSelf = weakSelf;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[error errorCode] message:[error errorDescription] preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *ok = [UIAlertAction actionWithTitle: NSLocalizedString(@"Ok", "") style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
       [strongSelf presentViewController:alert animated:YES completion:nil];
        
    });
    
    
}
@end
