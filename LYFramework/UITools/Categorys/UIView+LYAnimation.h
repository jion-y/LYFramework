//
//  UIView-LYAnimation.h
//  Pods-LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//

#import <UIKit/UIKit.h>


@interface UIView (LYAnimation)

- (void)scaleAnimation:(CGFloat)min max:(CGFloat)max animationTime:(CGFloat)time;

/// view 抖动动画
- (void)shakeAnimation;

- (void)showAnimationType:(NSString *)type
              withSubType:(NSString *)subType
                 duration:(CFTimeInterval)duration
           timingFunction:(NSString *)timingFunction;
   
#pragma mark - Preset Animation
   
/**
 *  下面是一些常用的动画效果
 */
   
// reveal
- (void)animationRevealFromBottom;
- (void)animationRevealFromTop;
- (void)animationRevealFromLeft;
- (void)animationRevealFromRight;
   
// 渐隐渐消
- (void)animationEaseIn;
- (void)animationEaseOut;
   
// 翻转
- (void)animationFlipFromLeft;
- (void)animationFlipFromRigh;
   
// 翻页
- (void)animationCurlUp;
- (void)animationCurlDown;
   
// push
- (void)animationPushUp;
- (void)animationPushDown;
- (void)animationPushLeft;
- (void)animationPushRight;
   
// move
- (void)animationMoveUpDuration:(CFTimeInterval)duration;
- (void)animationMoveDownDuration:(CFTimeInterval)duration;
- (void)animationMoveLeft;
- (void)animationMoveRight;
   
// 旋转缩放
   
// 各种旋转缩放效果
- (void)animationRotateAndScaleEffects;
   
// 旋转同时缩小放大效果
- (void)animationRotateAndScaleDownUp;
@end
