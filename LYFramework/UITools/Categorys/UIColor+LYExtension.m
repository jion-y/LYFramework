//
//  UIColor+LYExtension.m
//  LYFramework
//
//  Created by anita on 2020/8/21.
//

#import "UIColor+LYExtension.h"

@implementation UIColor (LYExtension)
+ (UIColor *)colorWithHexColor:(NSString *)hexColor
{
    if ([hexColor hasPrefix:@"#"])
    {
        hexColor = [hexColor substringFromIndex:1];
    }
    if (hexColor.length != 6)
    {
        return nil;
    }

    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red / 255.0f)
                           green:(float)(green / 255.0f)
                            blue:(float)(blue / 255.0f)
                           alpha:1.0f];
}

+ (UIColor *)randomColor
{
    int R = (arc4random() % 256);
    int G = (arc4random() % 256);
    int B = (arc4random() % 256);
    return [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:1];
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue
{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1];
}

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)colorWithRGBValue:(CGFloat)value
{
    return [UIColor colorWithRed:value / 255.0 green:value / 255.0 blue:value / 255.0 alpha:1];
}

+ (UIColor *)colorWithRGBValue:(CGFloat)value alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:value / 255.0 green:value / 255.0 blue:value / 255.0 alpha:alpha];
}
@end
