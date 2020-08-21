//
//  UIView+LYAnimation.h
//  Pods-LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYAnimation)

- (void)scaleAnimation:(CGFloat)min max:(CGFloat)max animationTime:(CGFloat)time;

/// view 抖动动画
- (void)shakeAnimation;
@end

NS_ASSUME_NONNULL_END
