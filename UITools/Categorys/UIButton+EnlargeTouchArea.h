//
//  UIButton+EnlargeTouchArea.h
//  welo
//
//  Created by anita on 2020/6/2.
//  Copyright © 2020 HungryFoolish. All rights reserved.
//
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYEnlargeTouchArea)

- (void)ly_setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat) right
                       bottom:(CGFloat) bottom
                         left:(CGFloat) left;
 
- (void)ly_setEnlargeEdge:(CGFloat) size;
@end

NS_ASSUME_NONNULL_END
