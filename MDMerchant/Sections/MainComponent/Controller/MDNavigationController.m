//
//  MDNavigationController.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDNavigationController.h"

@interface MDNavigationController ()

@end

@implementation MDNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor blackColor];
    attr[NSFontAttributeName] = UIFontMakeS(17);
    [self.navigationBar setTitleTextAttributes:attr];
    
    [self.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:MDThemeYellow] forBarMetrics:UIBarMetricsDefault];
}

@end
