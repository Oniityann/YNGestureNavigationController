//
//  YNGestureAnimator.h
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YNGesPushViewEffect) {
    
    YNGesPushViewEffectNone,
    YNGesPushViewEffectShadow,
    YNGesPushViewEffectAlpha,
    YNGesPushViewEffectFrame
};

typedef NS_ENUM(NSUInteger, YNGesPopViewEffect) {
    
    YNGesPopViewEffectNone,
    YNGesPopViewEffectShadow,
    YNGesPopViewEffectAlpha,
    YNGesPopViewEffectFrame
};

@interface YNGestureAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) UINavigationControllerOperation navOperation;
@property (assign, nonatomic) YNGesPushViewEffect pushViewEffect;
@property (assign, nonatomic) YNGesPopViewEffect popViewEffect;

@property (nonatomic, getter=isInteractivelyAnimate) BOOL interactivelyAnimate;

@end
