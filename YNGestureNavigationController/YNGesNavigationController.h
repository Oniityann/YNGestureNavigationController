//
//  YNGesNavigationController.h
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YNGesNavAnimationStyle) {
    YNGesNavAnimationStyleNone,
    YNGesNavAnimationStyleShadow,
    YNGesNavAnimationStyleAlpha,
    YNGesNavAnimationStyleFrame
};

@class YNGestureAnimator;

@interface YNGesNavigationController : UINavigationController

@property (assign, nonatomic) YNGesNavAnimationStyle animationStyle;

- (void)yn_enableGestureFullScreenPop:(BOOL)enable;

@end
