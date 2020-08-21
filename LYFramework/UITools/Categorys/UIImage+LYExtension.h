//
//  UIImage+LYExtension.h
//  Pods-LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LYExtension)
/** 颜色返回一张图片 */
+ (UIImage *)ly_imageWithColor:(UIColor *)color;

/** 颜色返回一张图片(图片大小) */
+ (UIImage *)ly_imageWithColor:(UIColor *)color size:(CGSize)size;

/** 图片滤镜效果 */
- (UIImage *)ly_addFillter:(NSString *)filterName;

/** 图片不透明度 */
- (UIImage *)ly_imageAlpha:(CGFloat)alpha;

/** 设置图片圆角 */
- (UIImage *)ly_imageCornerRadius:(CGFloat)radius;

/**
 *  @brief  图片圆角、边框、边框颜色
 *
 *  @param  radius      圆角半径
 *  @param  borderWidth 边框宽度
 *  @param  borderColor 边框颜色
 */
- (UIImage *)ly_imageCornerRadius:(CGFloat)radius
                               borderWidth:(CGFloat)borderWidth
                                boderColor:(nullable UIColor *)borderColor;

+ (UIImage *)ly_boxblurImage:(UIImage *)toBlurImage;


+ (UIImage *)ly_boxblurImage:(UIImage *)toBlurImage blurSize:(int)size;
@end

NS_ASSUME_NONNULL_END
