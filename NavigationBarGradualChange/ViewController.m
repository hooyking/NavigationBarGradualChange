//
//  ViewController.m
//  NavigationBarGradualChange
//
//  Created by hooyking on 2020/6/9.
//  Copyright © 2020 hooyking. All rights reserved.
//

#import "ViewController.h"
#import "OtherViewController.h"

#define kScreenW                        [[UIScreen mainScreen] bounds].size.width
#define kScreenH                        [[UIScreen mainScreen] bounds].size.height
#define kNavConH                        self.navigationController.navigationBar.frame.size.height
#define kStatusBarH \
\
^(){ \
    CGFloat statusBarH = 0; \
    if (@available(iOS 13.0, *)) { \
        UIWindowScene *windowScene = (UIWindowScene *)[UIApplication sharedApplication].connectedScenes.allObjects.lastObject; \
        statusBarH = windowScene.statusBarManager.statusBarFrame.size.height; \
    } else { \
       statusBarH = [[UIApplication sharedApplication] statusBarFrame].size.height; \
    } \
    return statusBarH; \
}()

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *navTopView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"导航栏动态渐变";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(pushToOtherVC)];
    
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

//恢复导航栏
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat minAlphaOffset = - kNavConH - kStatusBarH;
    CGFloat maxAlphaOffset = 150;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    //这儿使用colorWithAlphaComponent也可以调节本视图的透明度，且子视图的透明度不受影响，用view.alpha不只本视图透明度改变了，他的所有的子视图的透明度也受影响
    self.navTopView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:alpha];
}

- (void)pushToOtherVC {
    OtherViewController *vc = [OtherViewController new];
    vc.title = @"另一个VC";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
