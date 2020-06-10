//
//  ViewController.m
//  NavigationBarGradualChange
//
//  Created by hooyking on 2020/6/9.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "ViewController.h"

#define kScreenW                        [[UIScreen mainScreen] bounds].size.width
#define kScreenH                        [[UIScreen mainScreen] bounds].size.height
#define kNavConH                        self.navigationController.navigationBar.frame.size.height

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *navTopView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏动态渐变";
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]};
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(kScreenW, 3*kScreenH);
    self.scrollView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];

    UILabel *la = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, kScreenW, 20)];
    la.text = @"上下滚动可看到导航栏动态变化颜色";
    la.textColor = [UIColor whiteColor];
    la.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:la];

    self.navTopView = self.navigationController.navigationBar.subviews.firstObject;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat minAlphaOffset = - kNavConH;
    CGFloat maxAlphaOffset = 150;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    self.navTopView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:alpha];
}

@end
