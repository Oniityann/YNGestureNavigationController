//
//  YNGesNavBar.h
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNGesNavBar : UIView

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) UIView *titleView;

@property (strong, nonatomic) UIButton *leftItem;

@property (strong, nonatomic) UIColor *statusBarBgColor;
@property (strong, nonatomic) UIColor *navContentColor;
@property (strong, nonatomic) UIColor *navBgColor;
@property (strong, nonatomic) UIColor *titleColor;

@property (strong, nonatomic) UIImage *navBgImage;

@property (strong, nonatomic) NSMutableArray *rightItems;

@end
