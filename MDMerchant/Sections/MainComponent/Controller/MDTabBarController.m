//
//  MDTabBarViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDTabBarController.h"
#import "MDNavigationController.h"
#import "MDTabOneContainerViewController.h"
#import "MDTabTwoContainerViewController.h"

@interface MDTabBarController ()

@end

@implementation MDTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setUpViewControllers];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tabBar.height = 53;
    self.tabBar.bottom = self.view.height;
}
#pragma mark - Setup

- (void)setup {
    
    /* 文字属性 */
    UITabBarItem *item = [UITabBarItem appearance];
    
    // 普通状态下文字属性
    NSMutableDictionary *normalAttrs = [[NSMutableDictionary alloc]init];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    [self.tabBar setShadowImage:[UIImage new]];
    self.tabBar.selectionIndicatorImage = [UIImage md_imageWithColor:MDThemeYellow size:CGSizeMake(SCREEN_WIDTH/4, 53)];
    
}

/**
 *  创建子控制器
 */
- (void)setUpViewControllers {
    
    [self addOneChildViewController:[MDTabOneContainerViewController new]
                              title:@"待处理"
                              image:@"tab_1"
                      selectedImage:@"tab_1"
                         badgeValue:0];
    
    [self addOneChildViewController:[MDTabTwoContainerViewController new]
                              title:@"订单管理"
                              image:@"tab_2"
                      selectedImage:@"tab_2"
                         badgeValue:0];
    
    [self addOneChildViewController:[[UIViewController alloc]init]
                              title:@"门店运营"
                              image:@"tab_3"
                      selectedImage:@"tab_3"
                         badgeValue:0];
    
    [self addOneChildViewController:[[UIViewController alloc]init]
                              title:@"我的"
                              image:@"tab_4"
                      selectedImage:@"tab_4"
                         badgeValue:0];
}

/**
 *  初始化一个子控制器
 *
 *  @param vc            自控制器
 *  @param title         标题
 *  @param image         图标
 *  @param selectedImage 选中的图标
 *  @param badge    小红点
 */
- (void)addOneChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage badgeValue:(NSInteger)badge {
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -6);
    MDNavigationController *nav = [[MDNavigationController alloc] initWithRootViewController:vc];
    if (badge) {
        nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
    }
    [self addChildViewController:nav];
}


@end
