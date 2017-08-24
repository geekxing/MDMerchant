//
//  MDWelcomeViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/21.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDWelcomeViewController.h"
#import "MDLoginViewController.h"
#import "MDNavigationController.h"

@interface MDWelcomeViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mdTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mdLabelTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *label1Top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonBottom;
@property (weak, nonatomic) IBOutlet UIButton *tiyanButton;

@end

@implementation MDWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mdTop.constant = UIHeightRatio(102);
    _mdLabelTop.constant = UIHeightRatio(40);
    _label1Top.constant = UIHeightRatio(57);
    _buttonBottom.constant = UIHeightRatio(99);
}
- (IBAction)gotoLogin:(UIButton *)sender {
    MDLoginViewController *vc = [MDLoginViewController new];
    MDNavigationController *nav = [[MDNavigationController alloc] initWithRootViewController:vc];
    nav.naviStyle = MDNavigationStyleRegister;
    [MD_KEYWINDOW restoreRootViewController: nav];
}

@end
