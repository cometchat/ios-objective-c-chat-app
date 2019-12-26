//
//  DownloadManager.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "DownloadManager.h"

@implementation DownloadManager

+ (void)link:(NSString *)link completion:(void (^)(NSData * _Nullable data,
                                                   NSURLResponse * _Nullable response,
                                                   NSError * _Nullable error))completionHandler{
    NSURL *url = [NSURL URLWithString:link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session =
    [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                  delegate:nil
                             delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:completionHandler ];
    [task resume];
}
@end
