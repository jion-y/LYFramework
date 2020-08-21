//
//  UIView+LYExtension.m
//  Pods-LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//

#import "UIView+LYExtension.h"

@implementation UIView (LYExtension)

- (UILabel *)ly_addLabelFont:(CGFloat)font
                        text:(NSString *)text
                   textColor:(UIColor *)textColor
                     bgColor:(UIColor *)bgColor
{
    return [self ly_addLabelWithFont:[UIFont systemFontOfSize:font] text:text textColor:textColor bgColor:bgColor];
}

- (UILabel *)ly_addLabelWithFont:(UIFont *)font
                            text:(NSString *)text
                       textColor:(UIColor *)textColor
                         bgColor:(UIColor *)bgColor
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = font;
    label.text = text;
    label.textColor = textColor;
    label.backgroundColor = bgColor;
    [label sizeToFit];
    [self addSubview:label];
    return label;
}
- (UIImageView *)ly_addImageView:(CGRect)frame image:(UIImage *)img
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = img;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    return imageView;
}

- (UIButton *)ly_addButton:(CGRect)frame
                     title:(NSString *)title
                titleColor:(UIColor *)titleColor
                      font:(CGFloat)font
                      imge:(UIImage *)image
                   bgImage:(UIImage *)img
                    target:(id)target
                    action:(SEL)action
                    events:(UIControlEvents)event
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateHighlighted];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateHighlighted];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    [btn setBackgroundImage:img forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    if (target && action)
    {
        [btn addTarget:target action:action forControlEvents:event];
    }
    [self addSubview:btn];
    return btn;
}

- (UIButton *)ly_addButton:(CGRect)frame
                     image:(UIImage *)image
                    target:(id)target
                    action:(SEL)action
                    events:(UIControlEvents)event
{
    UIButton *btn = [self ly_addButton:frame
                                 title:nil
                            titleColor:nil
                                  font:0
                                  imge:image
                               bgImage:nil
                                target:target
                                action:action
                                events:event];
    //    frame.size = image.size;
    btn.frame = frame;
    return btn;
}

- (UIButton *)ly_addButton:(CGRect)frame
                     title:(NSString *)title
                titleColor:(UIColor *)color
                    target:(id)target
                    action:(SEL)action
                    events:(UIControlEvents)event
{
    return [self ly_addButton:frame
                        title:title
                   titleColor:color
                         font:14
                         imge:nil
                      bgImage:nil
                       target:target
                       action:action
                       events:event];
}

- (void)ly_cornerRadiusSize:(CGSize)size roundingCorners:(UIRectCorner)corners
{
    UIBezierPath *maskPath =
        [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
- (void)wl_cornerRadius:(CGFloat)radius
{
    [self ly_cornerRadiusSize:CGSizeMake(radius, radius) roundingCorners:UIRectCornerAllCorners];
}
- (UITableView *)wl_addTableView:(CGRect)frame delegate:(id)delegate
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    if (@available(iOS 11.0, *))
    {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:tableView];
    return tableView;
}
- (UIView *)ly_addView:(CGRect)frame bgColor:(UIColor *)bgColor
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = bgColor;
    [self addSubview:view];
    return view;
}

#pragma mark - 根据颜色获取图片
+ (UIImage *)ly_createImageWithColor:(UIColor *)color { return [self ly_imageWithColor:color size:CGSizeMake(10, 10)]; }
+ (UIImage *)ly_imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (!color || size.width <= 0 || size.height <= 0) return nil;

    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)stringTag:(NSString *)tag { [self setTag:[tag hash]]; }
- (UIView *)viewWithStringTag:(NSString *)tag { return [self viewWithTag:[tag hash]]; }

- (CAGradientLayer *)ly_createGradientLayerWithFrame:(CGRect)frame
{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);

    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 0);
    gl.colors = @[
        (__bridge id)[UIColor colorWithRed:252 / 255.0 green:62 / 255.0 blue:174 / 255.0 alpha:1.0].CGColor,
        (__bridge id)[UIColor colorWithRed:253 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1.0]
        .CGColor
    ];
    gl.locations = @[ @(0), @(1.0f) ];

    return gl;
}

- (UIImage *)ly_createImageFromLayerWithFrame:(CGRect)frame
{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);

    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 0);
    gl.colors = @[
        (__bridge id)[UIColor colorWithRed:252 / 255.0 green:62 / 255.0 blue:174 / 255.0 alpha:1.0].CGColor,
        (__bridge id)[UIColor colorWithRed:253 / 255.0 green:70 / 255.0 blue:70 / 255.0 alpha:1.0]
        .CGColor
    ];
    gl.locations = @[ @(0), @(1.0f) ];

    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);

    [gl renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return outputImage;
}

- (UIImage *)ly_createImageFromLayerWithFrame:(CGRect)frame
                                    andColors:(NSArray * )colors
{
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);

    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = colors;
    gl.locations = @[ @(0), @(1.0f) ];

    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);

    [gl renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return outputImage;
}

- (UIImage *)ly_viewShootToImage
{
    CGSize size = self.bounds.size;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}
@end
