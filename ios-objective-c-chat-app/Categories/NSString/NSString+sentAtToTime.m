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
    
    NSString *time;
    NSTimeInterval _currInterval = [[NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]] doubleValue];
    double timeInterval = [self doubleValue];
    
    if (self.length > 10) {
       timeInterval = timeInterval/1000;
    }
    
    NSDate * intervalDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    time = [intervalDate formattedAsTimeAgo];
    
    /*
    if((_currInterval - timeInterval) < 60.0) {
        if ((_currInterval - timeInterval) < 2.0) {
            time = [NSString stringWithFormat:@"%d sec ago",(int)(_currInterval - timeInterval)];
        }else
            time = [NSString stringWithFormat:@"%d secs ago",(int)(_currInterval - timeInterval)];
        
    }else if ((_currInterval - timeInterval) >= 60.0 && (_currInterval - timeInterval) <= 60.0*60.0) {
        
        NSDate *dateClass = [[NSDate alloc] init];
        if ([dateClass minutesAfterDate:intervalDate] < 2.0) {
            time = [NSString stringWithFormat:@"%ld min ago",(long)[dateClass minutesAfterDate:intervalDate]];
        }else
            time= [NSString stringWithFormat:@"%ld mins ago",(long)[dateClass minutesAfterDate:intervalDate]];
        
    }else if ((_currInterval - timeInterval) > 60.0 * 60.0 && [intervalDate isToday]) {
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"h:mm a";
        time = [timeFormatter stringFromDate: intervalDate];
        
    }else if([intervalDate isYesterday]) {
        
        NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
        timeFormatter.dateFormat = @"h:mm a";
        time = [NSString stringWithFormat:@"Yesterday %@",[timeFormatter stringFromDate: intervalDate]];
        
    }else {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"dd MMM HH:mm:ss";
        time = [dateFormatter stringFromDate: intervalDate];
        
    }
    */
    return time;
}
@end
