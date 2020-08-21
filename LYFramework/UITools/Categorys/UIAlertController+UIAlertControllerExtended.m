//
//  UIAlertController+UIAlertControllerExtended.m
//  welo
//
//  Created by anita on 2020/7/30.
//  Copyright © 2020 HungryFoolish. All rights reserved.
//

#import "UIAlertController+UIAlertControllerExtended.h"

@implementation WLAlertController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.preferredStyle == UIAlertControllerStyleAlert) {
        __weak UIAlertController *pSelf = self;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect screenRect = [[UIScreen mainScreen] bounds];
            CGFloat screenWidth = screenRect.size.width;
            CGFloat screenHeight = screenRect.size.height;
            
            [pSelf.view setCenter:CGPointMake(screenWidth / 2.0, screenHeight / 2.0)];
            [pSelf.view setNeedsDisplay];
        });
    }
}
@end
