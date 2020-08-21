//
//  UIView+LYAnimation.h
//  Pods-LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//

#import <UIKit/UIKit.h>


@interface UIView (LYAnimation)

- (void)scaleAnimation:(CGFloat)min max:(CGFloat)max animationTime:(CGFloat)time;

/// view 抖动动画
- (void)shakeAnimation;

// 位移
- (void)ly_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)ly_moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)ly_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)ly_raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// 形变
/**
 *   旋转
 */
- (void)ly_rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
/**
 *  缩放
 */
- (void)ly_scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;

/**
 *  顺时针旋转
 *
 *  @param secs 动画执行时间
 */
- (void)ly_spinClockwise:(float)secs;

/**
 *  逆时针旋转
 *
 *  @param secs 动画执行时间
 */
- (void)ly_spinCounterClockwise:(float)secs;


/**
 *  反翻页效果
 *
 *  @param secs 动画执行时间
 */
- (void)ly_curlDown:(float)secs;

/**
 *  视图翻页后消失
 *
 *  @param secs 动画执行时间
 */
- (void)ly_curlUpAndAway:(float)secs;

/**
 *  旋转缩放到一点后消失
 *
 *  @param secs 动画执行时间
 */
- (void)ly_drainAway:(float)secs;

/**
 *  将视图改变到一定透明度
 *
 *  @param newAlpha alpha
 *  @param secs     动画执行时间
 */
- (void)ly_changeAlpha:(float)newAlpha secs:(float)secs;


/**
 *  改变透明度结束动画后还原
 *
 *  @param secs         alpha
 *  @param continuously 是否循环
 */
- (void)ly_pulse:(float)secs continuously:(BOOL)continuously;


/**
 *  以渐变方式添加子控件
 *
 *  @param subview 需要添加的子控件
 */
- (void)ly_addSubviewWithFadeAnimation:(UIView *)subview;
@end
