//
//  UIView+LYExtension.h
//  Pods-LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYExtension)

/// 往当前视图中添加一个 Label
/// @param font 字体大小
/// @param text 文本
/// @param textColor 文本颜色
/// @param bgColor label 背景颜色
- (UILabel *)ly_addLabelFont:(CGFloat)font
                     text:(NSString *)text
                textColor:(UIColor *)textColor
                  bgColor:(UIColor *)bgColor;


/// 往当前视图添加一个 Label
/// @param font 字体
/// @param text 文本
/// @param textColor 文本颜色
/// @param bgColor 背景颜色
- (UILabel *)ly_addLabelWithFont:(UIFont *)font
                            text:(NSString *)text
                       textColor:(UIColor *)textColor
                         bgColor:(UIColor *)bgColor;

/// 往当前视图中添加一个 imageView
/// @param frame imageView 坐标
/// @param img 显示图片
- (UIImageView *)ly_addImageView:(CGRect)frame image:(UIImage*)img;


/// 给当前 view 添加一个按钮
/// @param frame 按钮 frame
/// @param title 按钮 title
/// @param titleColor 标题颜色
/// @param font 标题字号
/// @param image 图片
/// @param img 背景图片
/// @param target 事件响应 target
/// @param action 事件响应方法
/// @param event 事件
- (UIButton *)ly_addButton:(CGRect)frame
                     title:(NSString *)title
                    titleColor:(UIColor *)titleColor
                      font:(CGFloat)font
                      imge:(UIImage *)image
                   bgImage:(UIImage *)img
                    target:(id)target
                    action:(SEL)action
                    events:(UIControlEvents)event;


/// 给当前视图添加 一个图片类型的按钮
/// @param frame 按钮坐标
/// @param image 图片
/// @param target 事件响应 target
/// @param action 事件响应方法
/// @param event 事件
- (UIButton *)ly_addButton:(CGRect)frame
                     image:(UIImage *)image
                    target:(id)target
                    action:(SEL)action
                    events:(UIControlEvents)event;


/// 给当前视图添加一个文本类型的按钮
/// @param frame 按钮坐标
/// @param title 文本
/// @param color 文本颜色
/// @param target 事件响应 target
/// @param action 事件响应方法
/// @param event 事件
- (UIButton *)ly_addButton:(CGRect)frame
                     title:(NSString *)title
                titleColor:(UIColor *)color
                    target:(id)target
                    action:(SEL)action
                    events:(UIControlEvents)event;

/// 设置当前视图圆角属性
/// @param size 圆角大小
/// @param corners 圆角位置
- (void)ly_cornerRadiusSize:(CGSize)size roundingCorners:(UIRectCorner)corners;

/// 给当前视图四个角统一添加圆角
/// @param radius 圆角值
- (void)ly_cornerRadius:(CGFloat)radius;

/// 添加一个 tableView到当前的视图
/// @param frame tableViewFrame
/// @param delegate delegate对象
- (UITableView *)ly_addTableView:(CGRect)frame delegate:(id)delegate;

/// 添加一个 UIView 到当前视图上
/// @param frame 位置大小 frame
/// @param bgColor 背景颜色
- (UIView *)ly_addView:(CGRect)frame bgColor:(UIColor *)bgColor;


/// 根据色值创建 image
/// @param color 色值
+ (UIImage *)ly_createImageWithColor:(UIColor *)color;
 
 

/// 根据色值创建 image
/// @param color 色值
/// @param size 图片大小
+ (UIImage *)ly_imageWithColor:(UIColor *)color size:(CGSize)size;

 
 // add by ak 使用 string tag
-(void) stringTag:(NSString*) tag;
-(UIView*) viewWithStringTag:(NSString*)tag;


//生成渐变色 layer 我们项目自定义的
- (CAGradientLayer *)ly_createGradientLayerWithFrame:(CGRect)frame;

//生成渐变色 uiimage 我们项目自定义的
- (UIImage *)ly_createImageFromLayerWithFrame:(CGRect)frame;

- (UIImage *)ly_createImageFromLayerWithFrame:(CGRect)frame
                                    andColors:(NSArray * )colors;


/// 当前 view 截图
- (UIImage *)ly_viewShootToImage;

@end

NS_ASSUME_NONNULL_END
