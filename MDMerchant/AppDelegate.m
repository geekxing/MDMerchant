//
//  AppDelegate.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "AppDelegate.h"

#import "MDLoginViewController.h"
#import "MDTabBarController.h"
#import "MDWelcomeViewController.h"
#import "MDNavigationController.h"
#import <FHHFPSIndicator.h>
#import <IQKeyboardManager.h>

#define MD_FIRST_LOAD @"first_load"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    
    [self prepareLogin];
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setMinimumDismissTimeInterval:1.f];
    [SVProgressHUD setMaximumDismissTimeInterval:1.f];
    
    //设置键盘管理者
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.enableAutoToolbar = NO;
    // add the follwing code after the window become keyAndVisible
#if defined(DEBUG) || defined(_DEBUG)
    [[FHHFPSIndicator sharedFPSIndicator] show];
#endif
    
    return YES;
}

#pragma mark - Private
- (void)prepareLogin {
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    
    if([userDefaults objectForKey:MD_FIRST_LOAD] == nil) {
        
        [userDefaults setBool:NO forKey:MD_FIRST_LOAD];
        
        //显示引导页
        MDWelcomeViewController *vc =[[MDWelcomeViewController alloc] init];
        self.window.rootViewController = vc;
        
    } else [self login];
}

- (void)login {
    MDTabBarController *vc =[[MDTabBarController alloc] init];
    MDNavigationController *nav = [[MDNavigationController alloc] initWithRootViewController:vc];
    nav.naviStyle = MDNavigationStyleRegister;
    _window.rootViewController = vc;
}

@end
