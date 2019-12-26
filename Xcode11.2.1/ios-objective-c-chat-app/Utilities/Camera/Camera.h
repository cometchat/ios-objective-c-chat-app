//
//  Camera.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 18/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConstants.h"

NS_ASSUME_NONNULL_BEGIN

@interface Camera : NSObject

+(BOOL)PresentMultiCamera:(id)target canEdit:(BOOL)canEdit;
+(BOOL)PresentPhotoLibrary:(id)target canEdit:(BOOL)canEdit;
@end

NS_ASSUME_NONNULL_END
