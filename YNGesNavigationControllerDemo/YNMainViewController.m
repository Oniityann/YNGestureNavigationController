//
//  YNMainViewController.m
//  YNGesNavigationControllerDemo
//
//  Created by 郑一楠 on 2017/1/9.
//  Copyright © 2017年 zyn. All rights reserved.
//

#import "YNMainViewController.h"
#import "YNTest1ViewController.h"

@interface YNMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation YNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.gesNavBar.title = @"YNGesNavBar";
    self.gesNavBar.titleColor = [UIColor colorWithRed:0.18 green:0.69 blue:0.53 alpha:1];
    [self yn_setNavBgColor:[UIColor colorWithRed:0.56 green:0.45 blue:0.357 alpha:1]];
    
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 30, 30);
    [leftItem setImage:[UIImage imageNamed:@"weather"] forState:UIControlStateNormal];
    self.gesNavBar.leftItem = leftItem;
    
    UIButton *rightItem = [UIButton buttonWithType:UIButtonTypeCustom];
    rightItem.frame = CGRectMake(0, 0, 30, 30);
    [rightItem setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    NSMutableArray *rightItems = [@[rightItem] mutableCopy];
    self.gesNavBar.rightItems = rightItems;
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aaa"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pushPushPush {
    YNTest1ViewController *test1 = [[YNTest1ViewController alloc] init];
    [self.navigationController pushViewController:test1 animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
    cell.textLabel.text = [NSString stringWithFormat:@"这是一个cell%lu", (unsigned long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YNTest1ViewController *test1 = [[YNTest1ViewController alloc] init];
    [self.navigationController pushViewController:test1 animated:YES];
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
