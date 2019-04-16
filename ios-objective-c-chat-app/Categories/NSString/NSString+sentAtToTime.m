//
//  NSString+sentAtToTime.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 21/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "NSString+sentAtToTime.h"

@implementation NSString (sentAtToTime)

-(NSDate*)sentAtDate{
    
    NSTimeInterval _interval = [self doubleValue];
    NSDate * intervalDate = [NSDate dateWithTimeIntervalSince1970:_interval];
    return intervalDate;
}

-(NSString*)sentAtToTime{
    
    
    double timeInterval = [self doubleValue];
    
    if (self.length > 10) {
       timeInterval = timeInterval/1000;
    }
    NSDate * intervalDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *time = [intervalDate formattedAsTimeAgo];
    return time;
}
@end
