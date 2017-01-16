//
//  YNGestureAnimator.m
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "YNGestureAnimator.h"

static const NSTimeInterval kTransitionInterval = 0.5f;

@implementation YNGestureAnimator

/**
 处理动画时间

 @param transitionContext 转换上下文
 @return 动画间隔时间
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kTransitionInterval;
}

/**
 重写需要的动画
 
 全局手势返回需要对 fromVC 和 toVC 的 View 的 frame 做动画

 @param transitionContext 转换上下文, 简单理解包含了从视图和去视图控制器
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    // 将要消失的控制器
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    // 将要推入的控制器
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 获取两个控制器的 view
    UIView *fromV;
    UIView *toV;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) { // 精确获取 fV 和 tV
        fromV = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toV = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromV = fromVC.view;
        toV = toVC.view;
    }
    
    // 设置容器 view
    UIView *containerV = [transitionContext containerView];
    
    // 最终呈现的视图的 frame
    CGRect ultimateF = [UIScreen mainScreen].bounds;
    // 左边的 frame
    CGRect leftF = ultimateF;
    leftF.origin.x = -ultimateF.size.width;
    // 右边的 frame
    CGRect rightF = ultimateF;
    rightF.origin.x = ultimateF.size.width;
    
    /**
     UIViewAnimationOptionCurveLinear: 一个线性的曲线动画, 动画在它的间隔上均匀的产生
     UIViewAnimationOptionCurveEaseInOut: 淡入淡出曲线动画, 一开始慢, 中间快, 要结束了再慢
     */
    
    // 如果是手势交互则选择 linear 效果, 比较平稳
    UIViewAnimationOptions option = [self isInteractivelyAnimate] ? UIViewAnimationOptionCurveLinear : UIViewAnimationOptionCurveEaseInOut;
    
    CGRect oFrame = CGRectMake(-20, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 40);
    
    // 重写 push 动画
    if (self.navOperation == UINavigationControllerOperationPush) {
        
        // 将要出现的 view 的初始位置
        toV.frame = rightF;
        
        [containerV insertSubview:toV aboveSubview:fromV];
        
        switch (self.pushViewEffect) {
            case YNGesPushViewEffectNone:
                break;
                
            case YNGesPushViewEffectShadow:
                [self setShadowForView:toV];
                break;
                
            case YNGesPushViewEffectAlpha:
                [self setAlphaForView:fromV withOriginAlpha:1.0f andUltimateAlpha:0.5f];
                break;
                
            case YNGesPushViewEffectFrame:
            {
                [self setFrameForView:fromV
                      withOriginFrame:ultimateF
                        ultimateFrame:oFrame
                           andOptions:option];
                [self setAlphaForView:fromV withOriginAlpha:1.0f andUltimateAlpha:0.5f];
            }
                break;
                
            default:
                break;
        }
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:option animations:^{
            
            // 修改 from view 的 frame, 推入左边
            if (self.pushViewEffect != YNGesPushViewEffectFrame) {
                fromV.frame = leftF;
            }
            
            // 使 to view 呈现在屏幕正中间
            toV.frame = ultimateF;
            
        } completion:^(BOOL finished) {
            
            BOOL canceled = [transitionContext transitionWasCancelled];
            
            if (canceled) {
                [toV removeFromSuperview];
            }
            
            // 告诉系统动画已执行完成, 必须调用方法
            [transitionContext completeTransition:!canceled];
        }];
    }
    
    // 重写 pop 动画
    if (self.navOperation == UINavigationControllerOperationPop) {
        
        toV.frame = leftF;
        [containerV insertSubview:toV belowSubview:fromV];
        
        switch (self.popViewEffect) {
            case YNGesPopViewEffectNone:
                break;
                
            case YNGesPopViewEffectShadow:
                [self setShadowForView:fromV];
                break;
                
            case YNGesPopViewEffectAlpha:
                [self setAlphaForView:toV withOriginAlpha:0.5f andUltimateAlpha:1.0f];
                break;
                
            case YNGesPopViewEffectFrame:
            {
                [self setFrameForView:toV
                      withOriginFrame:oFrame
                        ultimateFrame:ultimateF
                           andOptions:option];
                [self setAlphaForView:toV withOriginAlpha:0.5f andUltimateAlpha:1.0f];
            }
                break;
                
            default:
                break;
        }
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0.0f options:option animations:^{
            
            fromV.frame = rightF;
            toV.frame = ultimateF;
        } completion:^(BOOL finished) {
            
            BOOL canceled = [transitionContext transitionWasCancelled];
            if (canceled) {
                [toV removeFromSuperview];
            }
            
            [transitionContext completeTransition:!canceled];
        }];
    }
}


/**
 给 toView 边界添加 阴影

 @param view toView
 */
- (void)setShadowForView:(UIView *)view {
    
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowRadius = 3.0f;
    view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:view.bounds] CGPath];
    view.layer.shadowOffset = CGSizeZero;
    view.layer.shadowOpacity = 0.3f;
}


/**
 设置视图动画 Alpha 属性

 @param view toView/fromView
 @param oValue 原始值, 0~1
 @param uValue 最终值, 0~1
 */
- (void)setAlphaForView:(UIView *)view withOriginAlpha:(CGFloat)oValue andUltimateAlpha:(CGFloat)uValue {
    view.alpha = oValue;
    [UIView animateWithDuration:kTransitionInterval animations:^{
        view.alpha = uValue;
    }];
}


/**
 设置视图动画 frame 属性

 @param view toView/fromView
 @param oFrame 原始 frame
 @param uFrame 最终 frame
 */
#if 1
- (void)setFrameForView:(UIView *)view
          withOriginFrame:(CGRect)oFrame
          ultimateFrame:(CGRect)uFrame
             andOptions:(UIViewAnimationOptions)options {
    
    view.frame = oFrame;
    
    [UIView animateWithDuration:kTransitionInterval delay:0.0f options:options animations:^{
        for (UIView *tableView in view.subviews) {
            if ([tableView isKindOfClass:[UITableView class]]||[tableView isKindOfClass:[UICollectionView class]]) {
                tableView.frame = CGRectMake(0, 64, uFrame.size.width, uFrame.size.height - 104);
                NSLog(@"%f", tableView.frame.size.height);
            }
        }
        view.frame = uFrame;
    } completion:^(BOOL finished) {
        view.frame = [UIScreen mainScreen].bounds;
        for (UIView *tableView in view.subviews) {
            if ([tableView isKindOfClass:[UITableView class]]||[tableView isKindOfClass:[UICollectionView class]]) {
                tableView.frame = CGRectMake(0, 64, uFrame.size.width, uFrame.size.height - 64);
            }
        }
    }];
    
}
#endif

@end
