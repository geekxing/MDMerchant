//
//  MDLoginViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/20.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDLoginViewController.h"
#import "MDLoginView.h"
#import "MDTabBarController.h"
#import <LEEAlert.h>

@interface MDLoginViewController ()<MDRegisterBaseViewDatasource>
@property (nonatomic, strong) MDLoginView *loginView;
@property (nonatomic, strong) NSArray *placeholderArr;
@end

@implementation MDLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _placeholderArr = @[@"账号",@"密码"];
    _loginView = [MDLoginView new];
    _loginView.dataSource=self;
    [self.view addSubview:_loginView];
    
    [_loginView.doneButton setTitle:@"登录" forState:UIControlStateNormal];
    MDWS
    _loginView.doneButtonClicked = ^(UIButton *btn, NSArray *textArr) {
        [wself doLoginAlertWithTextArr:textArr];
    };
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _loginView.frame = self.view.bounds;
}

#pragma mark - Private

- (void)doLoginAlertWithTextArr:(NSArray *)textArr {
    [self.view endEditing:YES];
    
    NSString *account = [textArr[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!account.length) {
        [LEEAlert alert].config
        .LeeTitle(@"用户名错误")
        .LeeAction(@"确定", nil)
        .LeeShow();
        return;
    }
    
    NSDictionary *params = @{Param_Id:account,
                             Param_Password:textArr[1]};
    [SVProgressHUD show];
    [MDNetworkTool postWithParams:params url:@"login_2/" successCode:200 completeHanlder:^(id response, NSError *err) {
        [SVProgressHUD dismiss];
        if (!err) {
            MDTabBarController *tabBar = [MDTabBarController new];
            [MD_KEYWINDOW restoreRootViewController:tabBar];
        } else {
            [SVProgressHUD showErrorWithStatus:err.localizedDescription];
        }
    }];
}

#pragma mark - <MDRegisterBaseViewDatasource>
- (NSInteger)numberOfTextFields {
    return 2;
}

- (void)textField:(UITextField *)textField atIndex:(NSInteger)index {
    textField.placeholder = _placeholderArr[index];
    if (index == 0) {
        textField.keyboardType = UIKeyboardTypePhonePad;
    } else {
        textField.secureTextEntry = YES;
    }
}
@end
