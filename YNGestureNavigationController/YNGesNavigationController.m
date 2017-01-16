//
//  YNGesNavigationController.m
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "YNGesNavigationController.h"
#import "YNGestureAnimator.h"

@interface YNGesNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, getter=isInteractive) BOOL interactive;

@property (strong, nonatomic) UIPanGestureRecognizer *fullScreenPanGesRec;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactiveTrans;
@property (strong, nonatomic) YNGestureAnimator *gestureAnimator;

@end

@implementation YNGesNavigationController

#pragma mark - lazy loading
- (YNGestureAnimator *)gestureAnimator {
    if (!_gestureAnimator) {
        _gestureAnimator = [YNGestureAnimator new];
        
        switch (self.animationStyle) {
            case YNGesNavAnimationStyleNone:
                break;
                
            case YNGesNavAnimationStyleShadow:
            {
                _gestureAnimator.pushViewEffect = YNGesPushViewEffectShadow;
                _gestureAnimator.popViewEffect = YNGesPushViewEffectShadow;
            }
                break;
                
            case YNGesNavAnimationStyleAlpha:
            {
                _gestureAnimator.pushViewEffect = YNGesPushViewEffectAlpha;
                _gestureAnimator.popViewEffect = YNGesPushViewEffectAlpha;
            }
                break;
                
            case YNGesNavAnimationStyleFrame:
            {
                _gestureAnimator.pushViewEffect = YNGesPushViewEffectFrame;
                _gestureAnimator.popViewEffect = YNGesPushViewEffectFrame;
            }
                break;
                
            default:
                break;
        }
    }
    return _gestureAnimator;
}

- (UIPanGestureRecognizer *)fullScreenPanGesRec {
    if (!_fullScreenPanGesRec) {
        _fullScreenPanGesRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        _fullScreenPanGesRec.delegate = self;
    }
    return _fullScreenPanGesRec;
}

- (UIPercentDrivenInteractiveTransition *)interactiveTrans {
    if (!_interactiveTrans) {
        _interactiveTrans = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return _interactiveTrans;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public function

- (void)yn_enableGestureFullScreenPop:(BOOL)enable {
    
    if (enable) {
        
        // 在系统手势识别 view 上添加手势
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fullScreenPanGesRec];
        // 禁用系统手势
        self.interactivePopGestureRecognizer.enabled = NO;
        // 设置带来
        self.delegate = self;
        // 因为系统的 navigation bar 是连在一起的, 影响动画效果, 所以必须隐藏
        self.navigationBarHidden = YES;
    } else {
        self.delegate = nil;
        self.interactivePopGestureRecognizer.enabled = YES;
        self.fullScreenPanGesRec = nil;
    }
}

#pragma mark - private function

#pragma mark gesture recognizer delegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.fullScreenPanGesRec) {
        
        CGPoint velocity = [self.fullScreenPanGesRec velocityInView:self.fullScreenPanGesRec.view];
        
        if (velocity.x > 0 && self.viewControllers.count > 1) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark navigation controller delegate

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // todo
    [super pushViewController:viewController animated:animated];
}

// 非交互动画, 返回动画执行对象, 对象必须是强引用
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    self.gestureAnimator.navOperation = operation;
    return self.gestureAnimator;
}

// 交互动画代理方法
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    // 使用自定义动画需要返回自定义交互
    if ([animationController isKindOfClass:[YNGestureAnimator class]] && [self isInteractive]) {
        
        self.gestureAnimator.interactivelyAnimate = YES;
        return self.interactiveTrans;
    } else {
        self.gestureAnimator.interactivelyAnimate = NO;
        
        // 系统会优先调用交互代理方法, 如果返回的不是nil, 就不会调用非交互性代理方法了
        return nil;
    }
}

#pragma mark - target/action
- (void)pan:(UIPanGestureRecognizer *)pan {
    
    CGPoint translation = [pan translationInView:pan.view];
    CGFloat rate = translation.x / pan.view.bounds.size.width;
    rate = MIN(1.0f, MAX(rate, 0.0f));
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.interactive = YES;
            if (self.viewControllers.count > 1) { // 不是第一个界面
                [self popViewControllerAnimated:YES];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [pan translationInView:pan.view];
            CGFloat rate = translation.x / pan.view.bounds.size.width;
            rate = MIN(1.0f, MAX(rate, 0.0f));
            [self.interactiveTrans updateInteractiveTransition:rate];
        }
             break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            if (rate > 0.35) {
                [self.interactiveTrans finishInteractiveTransition];
            } else {
                CGPoint velocity = [pan velocityInView:pan.view];
                
                if (velocity.x > ([UIScreen mainScreen].bounds.size.width / 2)) {
                    [self.interactiveTrans finishInteractiveTransition];
                } else {
                    [self.interactiveTrans cancelInteractiveTransition];
                }
            }
            
            self.interactive = NO;
        }
            break;
            
        default:
            self.interactive = NO;
            break;
    }
}

@end
