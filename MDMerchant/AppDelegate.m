//
//  AppDelegate.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "AppDelegate.h"

#import "MDRegisterViewController.h"
#import "MDTabBarController.h"
#import <FHHFPSIndicator.h>
#import <IQKeyboardManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    
    MDTabBarController *vc =[[MDTabBarController alloc] init];
    _window.rootViewController = vc;
    
    
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


@end
