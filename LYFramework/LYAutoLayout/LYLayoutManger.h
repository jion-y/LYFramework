//
//  LYLayoutManger.h
//  LYFramework
//
//  Created by anita on 2020/8/21.
//

#import <Foundation/Foundation.h>
#import <SDAutoLayout/SDAutoLayout.h>
NS_ASSUME_NONNULL_BEGIN

@interface LYLayoutManger : NSObject
+ (instancetype) share;
/// 布局标准屏的大小,默认 375 * 664
@property(nonatomic,assign)CGSize starndLayoutSize;
/// 布局距离是否需要进行 等比 scale,默认开启
@property(nonatomic,assign)BOOL enableScale;

@end

@interface LYAutoLayoutModel : SDAutoLayoutModel

@end

@interface UIView(LYLayout)

- (SDAutoLayoutModel *)ly_layout;
- (SDAutoLayoutModel *)ly_resetLayout;
- (SDAutoLayoutModel *)ly_resetNewLayout;
///布局完成后将 view 宽高置为整数
- (void)ly_fixWithAndHeigtToInt;
@end
NS_ASSUME_NONNULL_END
