//
//  ActivityIndicatorView.h
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 13/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActivityIndicatorView : UIActivityIndicatorView
@property (nonatomic, strong) CABasicAnimation * animation;
@property (class, nonatomic, readonly) CGFloat defaultHeight;
@end

NS_ASSUME_NONNULL_END
