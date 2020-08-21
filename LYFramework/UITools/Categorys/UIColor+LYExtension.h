//
//  UIColor+LYExtension.h
//  LYFramework
//
//  Created by anita on 2020/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LYExtension)
/**
 十六进制颜色值生成颜色
 
 @param hexColor 十六进制字符串  6位 || 7位（#开头）
 @return color
 */
+(UIColor *)colorWithHexColor:(NSString *)hexColor;

/**
 生成随机颜色
 
 @return color
 */
+(UIColor *)randomColor;

/// rgb色值生成颜色
+(UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue;

/// rgba色值生成颜色
+(UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;

/// rgb相同色值生成颜色
+(UIColor *)colorWithRGBValue:(CGFloat)value;

/// rgb相同色值生成颜色
+(UIColor *)colorWithRGBValue:(CGFloat)value alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
