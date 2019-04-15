//
//  DownloadManager.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface DownloadManager : NSObject
+ (void)link:(NSString *)link completion:(void (^)(NSData * _Nullable data,
                                                   NSURLResponse * _Nullable response,
                                                   NSError * _Nullable error))completionHandler;
@end

NS_ASSUME_NONNULL_END
