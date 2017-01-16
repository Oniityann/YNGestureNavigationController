# YNGestureNavigationController
全局手势POP, 支持几个简单的效果, 因为时间问题, 后续会完善动画

## Quick usage
### Without YNGesNavBar and BaseController
In this circumstances, you just need to import YNGesNavController in your own project. And if you wanna use some animation in the structure, you need to hide the system bar, top or bottom, for the system bar can not be affected by the custom animation effect.

```objc
YNMainViewController *main = [[YNMainViewController alloc] init];
YNGesNavigationController *navController = [[YNGesNavigationController alloc] initWithRootViewController:main];
navController.animationStyle = YNGesNavAnimationStyleFrame;
[navController yn_enableGestureFullScreenPop:YES];
    
self.window.rootViewController = navController;
```

***

### With YNGesNavBar and BaseController
You should make your own view controller based on the YNNavBaseController
such as:

```objc
#import "YNNavBaseController.h"

@interface YNTest1ViewController : YNNavBaseController

@end
```

and use the public property or function to set the appearance for the custom navigation bar or whatever on it, as:

```objc
[self yn_setNavContentColor:[UIColor redColor]];
[self yn_setStatusBarBgColor:[UIColor greenColor]];
    
UIButton *firstRightItem = [UIButton buttonWithType:UIButtonTypeCustom];
UIButton *secondRightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
firstRightItem.frame = CGRectMake(0, 0, 24, 24);
secondRightItem.frame = CGRectMake(0, 0, 36, 36);
    
[firstRightItem setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
[secondRightItem setImage:[UIImage imageNamed:@"pill"] forState:UIControlStateNormal];
    
self.gesNavBar.rightItems = @[firstRightItem, secondRightItem].mutableCopy;
```



