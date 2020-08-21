//
//  UIView+LYAnimation.m
//  Pods-LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//

#import "UIView+LYAnimation.h"

@implementation UIView (LYAnimation)

- (void)scaleAnimation:(CGFloat)min max:(CGFloat)max animationTime:(CGFloat)time;
{
    [self.layer removeAllAnimations];
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = time;
    scaleAnimation.repeatCount = HUGE_VALF;
    scaleAnimation.autoreverses = YES;
    //removedOnCompletion为NO保证app切换到后台动画再切回来时动画依然执行
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.fromValue = @(min);
    scaleAnimation.toValue = @(max);
    [self.layer addAnimation:scaleAnimation forKey:@"scale-layer"];
}
- (void)shakeAnimation
{
    // 获取到当前的View
    CALayer *viewLayer = self.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:3];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}
@end
