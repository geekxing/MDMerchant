//
//  MDBaseViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDBaseViewController.h"

@interface MDBaseViewController ()

@end

@implementation MDBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MDDefaultBgColor;
    self.navigationItem.title = [self navTitle];
}

- (NSString *)navTitle {
    return nil;
}


@end
