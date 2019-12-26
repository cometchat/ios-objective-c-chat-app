//
//  UIColor+SystemColor.m
//  ios-objective-c-chat-app
//
//  Created by Budhabhooshan Patil on 20/02/19.
//  Copyright © 2019 Inscripts.com. All rights reserved.
//

#import "UIColor+SystemColor.h"
#import "AppConstants.h"

@implementation UIColor (SystemColor)

+(UIColor *)NAVIGATION_BAR_COLOR{
    
    AppTheme *appTheme = [AppTheme new];
    HexToRGBConvertor *hexToRgb = [HexToRGBConvertor new];
    return [hexToRgb colorWithHexString:[[appTheme uiAppearanceColor] objectForKey:@"NAVIGATION_BAR_COLOR"]];
}
+(UIColor *)NAVIGATION_BAR_TITLE_COLOR{
    
    AppTheme *appTheme = [AppTheme new];
    HexToRGBConvertor *hexToRgb = [HexToRGBConvertor new];
    return [hexToRgb colorWithHexString:[[appTheme uiAppearanceColor] objectForKey:@"NAVIGATION_BAR_TITLE_COLOR"]];
}
+(UIColor *)NAVIGATION_BAR_BUTTON_TINT_COLOR{
    
    AppTheme *appTheme = [AppTheme new];
    HexToRGBConvertor *hexToRgb = [HexToRGBConvertor new];
    return [hexToRgb colorWithHexString:[[appTheme uiAppearanceColor] objectForKey:@"NAVIGATION_BAR_BUTTON_TINT_COLOR"]];
}
+(UIColor *)BACKGROUND_COLOR{
    
    AppTheme *appTheme = [AppTheme new];
    HexToRGBConvertor *hexToRgb = [HexToRGBConvertor new];
    return [hexToRgb colorWithHexString:[[appTheme uiAppearanceColor] objectForKey:@"BACKGROUND_COLOR"]];
}
+(UIColor *)LOGIN_BUTTON_TINT_COLOR{
    
    AppTheme *appTheme = [AppTheme new];
    HexToRGBConvertor *hexToRgb = [HexToRGBConvertor new];
    return [hexToRgb colorWithHexString:[[appTheme uiAppearanceColor] objectForKey:@"LOGIN_BUTTON_TINT_COLOR"]];
}
+(UIColor *)LOGO_TINT_COLOR{
    
    AppTheme *appTheme = [AppTheme new];
    HexToRGBConvertor *hexToRgb = [HexToRGBConvertor new];
    return [hexToRgb colorWithHexString:[[appTheme uiAppearanceColor] objectForKey:@"LOGO_TINT_COLOR"]];
}
+(UIColor *)RIGHT_BUBBLE_BACKGROUND_COLOR{
    
    AppTheme *appTheme = [AppTheme new];
    HexToRGBConvertor *hexToRgb = [HexToRGBConvertor new];
    return [hexToRgb colorWithHexString:[[appTheme uiAppearanceColor] objectForKey:@"RIGHT_BUBBLE_BACKGROUND_COLOR"]];
}

@end
