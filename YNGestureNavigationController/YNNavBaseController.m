//
//  YNNavBaseController.m
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/10.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "YNNavBaseController.h"

@interface YNNavBaseController ()

@end

@implementation YNNavBaseController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.gesNavBar];
    
    [self setSubviews];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // 设置navBar一直在前
    [self.view bringSubviewToFront:self.gesNavBar];
    
    if (self.gesNavBar.hidden == NO) {
        
        CGFloat navigationBarY = 0.0f;
        
        if (self.view.bounds.size.width > self.view.bounds.size.height) {// 横屏
            navigationBarY = -20;
        }
        
        self.gesNavBar.frame = CGRectMake(0.0f, navigationBarY, self.view.bounds.size.width, 64);
    }
}

#pragma mark - public

- (void)yn_setStatusBarBgColor:(UIColor *)color {
    if (self.gesNavBar) {
        self.gesNavBar.statusBarBgColor = color;
    }
}

- (void)yn_setNavContentColor:(UIColor *)color {
    if (self.gesNavBar) {
        self.gesNavBar.navContentColor = color;
    }
}

- (void)yn_setNavBgColor:(UIColor *)color {
    if (self.gesNavBar) {
        self.gesNavBar.navBgColor = color;
    }
}

- (void)yn_setNavBgImage:(UIImage *)image {
    if (self.gesNavBar) {
        self.gesNavBar.navBgImage = image;
    }
}

- (void)yn_setTitleView:(UIView *)view {
    if (self.gesNavBar) {
        self.gesNavBar.titleView = view;
    }
}

#pragma mark - private

- (YNGesNavBar *)gesNavBar {
    
    if (!_gesNavBar) {
        _gesNavBar = [[YNGesNavBar alloc] init];
    }
    return _gesNavBar;
}

- (void)setSubviews {
    
    if (self.navigationController.viewControllers.count > 1) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:@"返回"
                forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor]
                     forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor]
                     forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"]
                forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"]
                forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(100, 0, 70, 30);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //改变按钮内容内偏移
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        
        self.gesNavBar.leftItem = button;
    }
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
