//
//  MDRegisterViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDRegisterViewController.h"
#import "MDRegisterBaseView.h"
#import <LEEAlert.h>

@interface MDRegisterViewController ()<MDRegisterBaseViewDatasource>
@property (nonatomic, strong) MDRegisterBaseView *registView;
@property (nonatomic, strong) NSArray *placeholderArr;
@end

@implementation MDRegisterViewController

- (void)dealloc
{
    MDLogFunc
    [[MDNetworkTool shared].operationQueue cancelAllOperations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _placeholderArr = @[@"请输入手机号", @"请输入商店名称", @"请输入密码", @"请再次输入密码"];
    _registView = [MDRegisterBaseView new];
    _registView.dataSource=self;
    [self.view addSubview:_registView];
    
    [_registView.doneButton setTitle:@"注册" forState:UIControlStateNormal];
    MDWS
    _registView.doneButtonClicked = ^(UIButton *btn, NSArray *textArr) {
        MDLog(@"注册...");
        [wself doRegisterWithTextArr:textArr];
    };
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _registView.frame = self.view.bounds;
}

#pragma mark - Private
- (void)doRegisterWithTextArr:(NSArray *)textArr {
    if (![textArr[2] isEqualToString:textArr[3]]) {
        [LEEAlert alert].config
        .LeeTitle(@"两次输入密码不一致")
        .LeeAction(@"确定", nil)
        .LeeShow();
        return;
    }
    
    [self.view endEditing:YES];
    
    NSString *account = [textArr[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!account.length) {
        [LEEAlert alert].config
        .LeeTitle(@"非法用户名")
        .LeeAction(@"确定", nil)
        .LeeShow();
        return;
    }
    NSDictionary *params = @{Param_Id:account,
                             Param_Shop:textArr[1],
                             Param_Password:textArr[2]};
    [SVProgressHUD show];
    [MDNetworkTool postWithParams:params url:@"register_2/" successCode:200 completeHanlder:^(id response, NSError *err) {
        [SVProgressHUD dismiss];
        if (!err) {
            MDWS
            [LEEAlert alert].config
            .LeeTitle(@"注册成功，欢迎加入！")
            .LeeAction(@"进入", ^{
                [wself.navigationController popViewControllerAnimated:YES];
                if (wself.registerDidSuccess) {
                    wself.registerDidSuccess(textArr);
                }
            })
            .LeeShow();
        } else {
            [SVProgressHUD showErrorWithStatus:err.localizedDescription];
        }
    }];
}

#pragma mark - <MDRegisterBaseViewDatasource>
- (NSInteger)numberOfTextFields {
    return 4;
}

- (void)textField:(UITextField *)textField atIndex:(NSInteger)index {
    textField.placeholder = _placeholderArr[index];
    if (index == 0) {
        textField.keyboardType = UIKeyboardTypePhonePad;
    } else if (index == 2 || index == 3) {
        textField.secureTextEntry = YES;
    }
}

@end
