//
//  YNTest1ViewController.m
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "YNTest1ViewController.h"
#import "YNTest2ViewController.h"

@interface YNTest1ViewController ()

@end

@implementation YNTest1ViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self yn_setNavBgImage:[UIImage imageNamed:@"navbg"]];
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 64)];
    titleView.image = [UIImage imageNamed:@"titleView"];
    [self yn_setTitleView:(UIImageView *)titleView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setTitle:@"返回"
            forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor]
                 forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(goBackTolastVC) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(100, 0, 70, 30);
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.gesNavBar.leftItem = button;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushPushPush {
    
    YNTest2ViewController *test2 = [[YNTest2ViewController alloc] init];
    [self.navigationController pushViewController:test2 animated:YES];
}

- (void)goBackTolastVC {
    [self.navigationController popViewControllerAnimated:YES];
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
