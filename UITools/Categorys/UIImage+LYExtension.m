//
//  UIImage+LYExtension.m
//  Pods-LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//

#import "UIImage+LYExtension.h"
#import <Accelerate/Accelerate.h>
@implementation UIImage (LYExtension)

+ (UIImage *)ly_imageWithColor:(UIColor *)color
{
    
    return [self ly_imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)ly_imageWithColor:(UIColor *)color size:(CGSize)size{
    
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  滤镜名字：OriginImage(原图)、CIPhotoEffectNoir(黑白)、CIPhotoEffectInstant(怀旧)、CIPhotoEffectProcess(冲印)、CIPhotoEffectFade(褪色)、CIPhotoEffectTonal(色调)、CIPhotoEffectMono(单色)、CIPhotoEffectChrome(铬黄)
 *
 *  灰色：CIPhotoEffectNoir //黑白
 */
- (UIImage *)ly_addFillter:(NSString *)filterName
{
    if ([filterName isEqualToString:@"OriginImage"]) {
        return self;
    }
    // 将 UIImage 装成 CIImage
    CIImage * ciImage = [[CIImage alloc]initWithImage:self];
    // 创建滤镜
    CIFilter * filter = [CIFilter filterWithName:filterName keysAndValues:kCIInputImageKey,ciImage, nil];
    // 已有值不变，其他的设置为默认值
    [filter setDefaults];
    // 获取绘制上下文
    CIContext * context = [CIContext contextWithOptions:nil];
    // 渲染并输出 CIImage
    CIImage * outputImage = [filter outputImage];
    // 创建 CGImage 句柄
    CGImageRef cgImgaeRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    // 获取图片
    UIImage * image = [UIImage imageWithCGImage:cgImgaeRef];
    // 释放 CGImage 句柄
    CGImageRelease(cgImgaeRef);
    return image;
}
/** 图片透明度 */
- (UIImage *)ly_imageAlpha:(CGFloat)alpha
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, - rect.size.height);
    CGContextSetBlendMode(context, kCGBlendModeMultiply);
    CGContextSetAlpha(context, alpha);
    CGContextDrawImage(context, rect, self.CGImage);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
/** 设置圆角 */
- (UIImage *)ly_imageCornerRadius:(CGFloat)radius
{
    return [self ly_imageCornerRadius:radius borderWidth:0.0f boderColor:nil];
    
}
/** 设置圆角、边框 */
- (UIImage *)ly_imageCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth boderColor:(UIColor *)borderColor
{
    
    return [self ly_imageByRoundCornerRadius:radius
                                     corners:UIRectCornerAllCorners
                                 borderWidth:borderWidth
                                 borderColor:borderColor
                              borderLineJoin:kCGLineJoinMiter];
}

#pragma mark - 设置圆角图片
// corners：需要设置为圆角的角 UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight | UIRectCornerAllCorners
- (UIImage *)ly_imageByRoundCornerRadius:(CGFloat)radius
                                 corners:(UIRectCorner)corners
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor
                          borderLineJoin:(CGLineJoin)borderLineJoin {
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(self.size.width, self.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(radius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, self.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)ly_boxblurImage:(UIImage *)toBlurImage
{
    return [self ly_boxblurImage:toBlurImage blurSize:30];
}
+ (UIImage *)ly_boxblurImage:(UIImage *)toBlurImage blurSize:(int)size
{
    if (!toBlurImage)
       {
           return nil;
       }
       UIImage *newImage =

           [toBlurImage ly_scaleToSize:CGSizeMake(toBlurImage.size.width / 2., toBlurImage.size.height / 2.)];

       NSData *jpgData = UIImageJPEGRepresentation(newImage, 0.01);

       UIImage *image = [UIImage imageWithData:jpgData];
       CGFloat blur = 1.0f;

       int boxSize = (int)(blur * size);
       boxSize = boxSize - (boxSize % 2) + 1;

       CGImageRef img = image.CGImage;
       vImage_Buffer inBuffer, outBuffer;
       vImage_Error error;
       void *pixelBuffer;

       // create vImage_Buffer with data from CGImageRef
       CGDataProviderRef inProvider = CGImageGetDataProvider(img);
       CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);

       inBuffer.width = CGImageGetWidth(img);
       inBuffer.height = CGImageGetHeight(img);
       inBuffer.rowBytes = CGImageGetBytesPerRow(img);

       inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);

       // create vImage_Buffer for output
       pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

       if (pixelBuffer == NULL) NSLog(@"No pixelbuffer");

       outBuffer.data = pixelBuffer;
       outBuffer.width = CGImageGetWidth(img);
       outBuffer.height = CGImageGetHeight(img);
       outBuffer.rowBytes = CGImageGetBytesPerRow(img);

       // perform convolution
       error =
           vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend)
               ?: vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend)
                      ?: vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL,
                                                    kvImageEdgeExtend);

       if (error)
       {
           NSLog(@"error from convolution %ld", error);
       }

       CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
       CGContextRef ctx = CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes,
                                                colorSpace, (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
       CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
       UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

       // clean up
       CGContextRelease(ctx);
       CGColorSpaceRelease(colorSpace);

       free(pixelBuffer);
       CFRelease(inBitmapData);
       CGImageRelease(imageRef);
       
       return returnImage;
}
- (UIImage *)ly_scaleToSize:(CGSize)size
{
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);

    float verticalRadio = size.height * 1.0 / height;
    float horizontalRadio = size.width * 1.0 / width;

    float radio = 1;
    if (verticalRadio > 1 && horizontalRadio > 1)
    {
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    }
    else
    {
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    }

    width = width * radio;
    height = height * radio;

    int xPos = (size.width - width) / 2;
    int yPos = (size.height - height) / 2;

    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);

    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];

    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    // 使当前的context出堆栈
    UIGraphicsEndImageContext();

    // 返回新的改变大小后的图片
    return scaledImage;
}
@end
