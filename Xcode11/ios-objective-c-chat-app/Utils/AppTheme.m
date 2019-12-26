//
//  AppTheme.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 21/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "AppTheme.h"

@implementation AppTheme

-(NSDictionary *)plistData{
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *finalPath = [path stringByAppendingPathComponent:@"CometChat-info.plist"];
    NSDictionary *plistData = [NSDictionary dictionaryWithContentsOfFile:finalPath];
    return plistData;
}
-(NSDictionary *)authentication{
    return [[ self plistData] objectForKey:@"Authentication"];
}
-(NSDictionary *)uiAppearanceColor{
     return [[ self plistData] objectForKey:@"UIAppearanceColor"];
}
-(NSDictionary *)uiAppearanceFont{
     return [[ self plistData] objectForKey:@"UIAppearanceFont"];
}
@end
