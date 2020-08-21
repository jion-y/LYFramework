//
//  UIButton+timer.h
//  welo
//
//  Created by ak on 2020/3/4.
//  Copyright © 2020 HungryFoolish. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (timer)
/**
按钮倒计时的问题
@param countDownTime 倒计时的时间(分钟)
*/
- (void)buttonWithTime:(CGFloat)countDownTime;
@end

NS_ASSUME_NONNULL_END
