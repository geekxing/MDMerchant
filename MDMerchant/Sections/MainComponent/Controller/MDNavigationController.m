//
//  MDNavigationController.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDNavigationController.h"

@interface MDNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL differentBarStylePush;
@end

@implementation MDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    attr[NSFontAttributeName] = UIFontMakeS(17);
    [self.navigationBar setTitleTextAttributes:attr];
    
    self.naviStyle = MDNavigationStyleHomePage;
}

#pragma mark - Overrides

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!_differentBarStylePush) [self configNavi];
    else _differentBarStylePush = NO;
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"nav_back_arrow" image2:@"nav_back_arrow" state:UIControlStateNormal target:self action:@selector(tapBackArrow) pos:MDBarItemPositioningLeft];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

//重写pop
- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    if (!_differentBarStylePush) [self configNavi];
    else _differentBarStylePush = NO;
    return [super popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!_differentBarStylePush) [self configNavi];
    else _differentBarStylePush = NO;
    return [super popToViewController:viewController animated:animated];
}

#pragma mark - <UIGestureDelegate>
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.childViewControllers.count > 1;
}

#pragma mark - Private
- (void)tapBackArrow {
    [self popViewControllerAnimated:YES];
}

- (void)configNavi {
    [self.navigationBar setShadowImage:[[UIImage alloc]init]];
    
    UIImage *barImage;
    if (_naviStyle == MDNavigationStyleHomePage) {
        barImage = [UIImage imageWithColor:MDThemeYellow];
    } else {
        barImage = [UIImage new];
    }
    [self.navigationBar setBackgroundImage:barImage forBarMetrics:UIBarMetricsDefault];
}

- (void)setNaviStyle:(MDNavigationStyle)naviStyle {
    _naviStyle = naviStyle;
    _differentBarStylePush = YES;
    [self configNavi];
}



@end
