//
//  MDRegisterViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDRegisterViewController.h"
#import "MDRegisterView.h"

@interface MDRegisterViewController ()
@property (nonatomic, strong) MDRegisterView *registView;
@end

@implementation MDRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _registView = [MDRegisterView new];
    [self.view addSubview:_registView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _registView.frame = self.view.bounds;
}

@end
