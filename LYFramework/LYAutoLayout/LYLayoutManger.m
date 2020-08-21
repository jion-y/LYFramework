//
//  LYLayoutManger.m
//  LYFramework
//
//  Created by anita on 2020/8/21.
//

#import "LYLayoutManger.h"
static LYLayoutManger * layout_manager = nil;

@interface LYLayoutManger ()
@property(nonatomic,assign)CGFloat scale;
@end
@implementation LYLayoutManger
+(instancetype)share
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        layout_manager = [[LYLayoutManger alloc] init];
    });
    return layout_manager;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.enableScale = YES;
    }
    return self;
}
- (void)setEnableScale:(BOOL)enableScale
{
    if (!enableScale) {
        self.scale = 1.0f;
        return ;
    }
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.scale = size.width / self.starndLayoutSize.width;
}
- (CGSize)starndLayoutSize
{
    if (CGSizeEqualToSize(CGSizeZero, _starndLayoutSize)) {
        _starndLayoutSize = CGSizeMake(375, 667);
    }
    return _starndLayoutSize;
}
@end

@implementation LYAutoLayoutModel
@synthesize widthIs = _widthIs;
@synthesize heightIs = _heightIs;
- (MarginToView)marginToViewblockWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(id viewOrViewsArray, CGFloat value) {
        SDAutoLayoutModelItem *item = [SDAutoLayoutModelItem new];
        item.value = @(value * [LYLayoutManger share].scale);
        if ([viewOrViewsArray isKindOfClass:[UIView class]]) {
            item.refView = viewOrViewsArray;
        } else if ([viewOrViewsArray isKindOfClass:[NSArray class]]) {
            item.refViewsArray = [viewOrViewsArray copy];
        }
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (WidthHeight)widthIs
{
    if (!_widthIs) {
        __weak typeof(self) weakSelf = self;
        _widthIs = ^(CGFloat value) {
            weakSelf.needsAutoResizeView.fixedWidth = @(value * [LYLayoutManger share].scale);
            SDAutoLayoutModelItem *widthItem = [SDAutoLayoutModelItem new];
            widthItem.value = @(value * [LYLayoutManger share].scale);
            [weakSelf setValue:widthItem forKey:@"width"];
            return weakSelf;
        };
    }
    return _widthIs;
}

- (WidthHeight)heightIs
{
    if (!_heightIs) {
        __weak typeof(self) weakSelf = self;
        
        _heightIs = ^(CGFloat value) {
            weakSelf.needsAutoResizeView.fixedHeight = @(value * [LYLayoutManger share].scale);
            SDAutoLayoutModelItem *heightItem = [SDAutoLayoutModelItem new];
            heightItem.value = @(value * [LYLayoutManger share].scale);
            [weakSelf setValue:heightItem forKey:@"height"];
            return weakSelf;
        };
    }
    return _heightIs;
}

- (WidthHeight)limitingWidthHeightWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    
    return ^(CGFloat value) {
        [weakSelf setValue:@(value *  [LYLayoutManger share].scale) forKey:key];
        return weakSelf;
    };
}
@end
@implementation UIView (LYLayout)

- (SDAutoLayoutModel *)ly_layout
{
    #ifdef SDDebugWithAssert
        /*
         卡在这里说明你的要自动布局的view在没有添加到父view的情况下就开始设置布局,你需要这样：
         1.  UIView *view = [UIView new];
         2.  [superView addSubview:view];
         3.  view.sd_layout
         .leftEqualToView()...
         */
        NSAssert(self.superview, @">>>>>>>>>在加入父view之后才可以做自动布局设置");
        
    #endif
        
        SDAutoLayoutModel *model = [self ownLayoutModel];
        if (!model) {
            model = [LYAutoLayoutModel new];
            model.needsAutoResizeView = self;
            [self setOwnLayoutModel:model];
            [self.superview.autoLayoutModelsArray addObject:model];
        }
        return model;
}
- (void)ly_fixWithAndHeigtToInt
{
    __weak typeof(self)weakSelf = self;
    [self setDidFinishAutoLayoutBlock:^(CGRect frame) {
        frame.size.width = ceil(CGRectGetWidth(frame));
        frame.size.height = ceil(CGRectGetHeight(frame));
        weakSelf.frame = frame;
    }];
}
- (SDAutoLayoutModel *)ly_resetLayout
{
    /*
     * 方案待定
     [self sd_clearAutoLayoutSettings];
     return [self sd_layout];
     */
    
    SDAutoLayoutModel *model = [self ownLayoutModel];
    LYAutoLayoutModel *newModel = [LYAutoLayoutModel new];
    newModel.needsAutoResizeView = self;
    [self sd_clearViewFrameCache];
    NSInteger index = 0;
    if (model) {
        index = [self.superview.autoLayoutModelsArray indexOfObject:model];
        [self.superview.autoLayoutModelsArray replaceObjectAtIndex:index withObject:newModel];
    } else {
        [self.superview.autoLayoutModelsArray addObject:newModel];
    }
    [self setOwnLayoutModel:newModel];
    [self sd_clearExtraAutoLayoutItems];
    return newModel;
}

- (SDAutoLayoutModel *)ly_resetNewLayout
{
    [self sd_clearAutoLayoutSettings];
    [self sd_clearExtraAutoLayoutItems];
    return [self sd_layout];
}
- (void)sd_clearExtraAutoLayoutItems
{
    if (self.autoHeightRatioValue) {
        self.autoHeightRatioValue = nil;
    }
    self.fixedHeight = nil;
    self.fixedWidth = nil;
}
@end
