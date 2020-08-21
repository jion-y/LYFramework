//
//  ViewController.m
//  LYFrameworkDemo
//
//  Created by anita on 2020/8/21.
//  Copyright © 2020 liuming. All rights reserved.
//

#import "ViewController.h"
#import <NSString+LYExtention.h>
#import <LYLayoutManger.h>
#import <UIView+LYExtension.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString * str = @"77";
    [NSString checkPhoneNumber:str];
    
    UIView * v = [self.view ly_addView:CGRectZero bgColor:[UIColor redColor]];
    v.ly_layout.leftSpaceToView(self.view, 100)
    .topSpaceToView(self.view, 100)
    .widthIs(100)
    .heightIs(100);
}


@end
