//
//  MDTabOneContainerViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDTabOneContainerViewController.h"
#import "MDNewOrderViewController.h"
#import "MDRefundViewController.h"
#import "MDCompensateViewController.h"

@interface MDTabOneContainerViewController ()
@end

@implementation MDTabOneContainerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商店名称";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"nav_md" image2:nil state:UIControlStateHighlighted target:nil action:nil pos:MDBarItemPositioningLeft];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:nil image:@"nav_scan" image2:nil state:UIControlStateHighlighted target:self action:@selector(qrScan) pos:MDBarItemPositioningRight];
}

#pragma mark - Private
- (void)qrScan {
    
}

#pragma mark - getter
- (NSArray<UIViewController *> *)vcList {
    if (!_vcList) {
        MDNewOrderViewController *newOrder = [[MDNewOrderViewController alloc] init];
        MDRefundViewController *refund = [MDRefundViewController new];
        MDCompensateViewController *compensate = [MDCompensateViewController new];
        _vcList = @[newOrder, refund, compensate];
    }
    return _vcList;
}

@end
