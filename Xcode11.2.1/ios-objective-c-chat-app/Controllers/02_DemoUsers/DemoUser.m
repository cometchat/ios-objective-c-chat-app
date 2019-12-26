//
//  DemoUser.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 15/03/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "DemoUser.h"

@implementation DemoUser
-(id)initDemoUserWithUserName:(NSString *)userName userUID:(NSString *)uid andImage:(UIImage *)profileImage{
    
    self = [super init];
    if(self)
    {
        self.userName = userName;
        self.uid = uid;
        self.profileImage = profileImage;
    }
    return self;
}
+(void)Present:(UIViewController *)viewController on:(id)target{
    
    [target presentViewController:viewController animated:YES completion:nil];
}
@end
