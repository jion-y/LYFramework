//
//  UIButton+timer.m
//  welo
//
//  Created by ak on 2020/3/4.
//  Copyright © 2020 HungryFoolish. All rights reserved.
//

#import "UIButton+timer.h"

/** 倒计时的显示时间 */
static NSInteger secondsCountDown;
/** 记录总共的时间 */
static NSInteger allTime;
@implementation UIButton (timer)
- (void)buttonWithTime:(CGFloat)countDownTime
{
    self.userInteractionEnabled = NO;
    secondsCountDown = countDownTime;
    allTime = countDownTime;
    [self setTitle:[NSString stringWithFormat:@"%lds ", secondsCountDown]
    forState:UIControlStateNormal];

//    [self setTitleColor:NX_UIColorFromRGB(0x999999) forState:UIControlStateNormal];

    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod:) userInfo:nil repeats:YES];
}
- (void)timeFireMethod:(NSTimer *)countDownTimer
{
    //倒计时-1
    secondsCountDown--;
    //修改倒计时标签现实内容
    [self setTitle:[NSString stringWithFormat:@" %lds ", secondsCountDown]
          forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if (secondsCountDown == 0)
    {
        [countDownTimer invalidate];
        [self setTitle:@"发送验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        secondsCountDown = allTime;
        self.userInteractionEnabled = YES;
    }
}
@end
