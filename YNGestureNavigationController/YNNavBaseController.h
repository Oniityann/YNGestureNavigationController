//
//  YNNavBaseController.h
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/10.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YNGesNavBar.h"

@interface YNNavBaseController : UIViewController

@property (strong, nonatomic) YNGesNavBar *gesNavBar;

- (void)yn_setStatusBarBgColor:(UIColor *)color;
- (void)yn_setNavContentColor:(UIColor *)color;
- (void)yn_setNavBgColor:(UIColor *)color;

- (void)yn_setNavBgImage:(UIImage *)image;
- (void)yn_setTitleView:(UIView *)view;

@end
