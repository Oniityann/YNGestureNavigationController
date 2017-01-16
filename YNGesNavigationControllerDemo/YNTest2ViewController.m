//
//  YNTest2ViewController.m
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "YNTest2ViewController.h"

@interface YNTest2ViewController ()

@end

@implementation YNTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yn_setNavContentColor:[UIColor redColor]];
    [self yn_setStatusBarBgColor:[UIColor greenColor]];
    
    UIButton *firstRightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *secondRightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    
    firstRightItem.frame = CGRectMake(0, 0, 24, 24);
    secondRightItem.frame = CGRectMake(0, 0, 36, 36);
    
    [firstRightItem setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    [secondRightItem setImage:[UIImage imageNamed:@"pill"] forState:UIControlStateNormal];
    
    self.gesNavBar.rightItems = @[firstRightItem, secondRightItem].mutableCopy;
    
//    self.gesNavBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
