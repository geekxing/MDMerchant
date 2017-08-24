//
//  MDOtherLoginViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/20.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDOtherLoginViewController.h"
#import "MDLoginView.h"

@interface MDOtherLoginViewController ()<MDRegisterBaseViewDatasource>
@property (nonatomic, strong) MDLoginView *loginView;
@property (nonatomic, strong) NSArray *placeholderArr;
@property (nonatomic, strong) UIButton *countDownButton;
@end

@implementation MDOtherLoginViewController

- (void)dealloc
{
    MDLogFunc
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[MDNetworkTool shared].tasks makeObjectsPerformSelector:@selector(cancel)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _placeholderArr = @[@"请输入手机号码",@"请输入验证码"];
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
}

- (void)sendVerifyCode {
    sleep(.2);
    [_countDownButton createTimerWithEndFormat:@"发送验证码" schedulingFormat:@"倒计时%zds"];
}

- (void)resizeButtonSize {
    CGFloat gap = UIWidthRatio(37);
    CGFloat width = self.view.width - 2*gap;
    CGFloat height = roundf(width * 118 / 855);
    self.countDownButton.size = CGSizeMake(_countDownButton.width + 20, height);
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
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.rightView = self.countDownButton;
        textField.rightViewMode =UITextFieldViewModeAlways;
        [self resizeButtonSize];
        textField.layer.cornerRadius = 6;
        textField.clipsToBounds = YES;
    }
}

#pragma mark - getter

- (UIButton *)countDownButton {
    if (!_countDownButton) {
        _countDownButton = [UIButton buttonTitle:@"发送验证码"
                                            font:UIFontMake(11)
                                       textColor:[UIColor whiteColor]
                                      background:nil
                                     background2:nil
                                           state:UIControlStateHighlighted
                                          target:self
                                          action:@selector(sendVerifyCode)];
        _countDownButton.backgroundColor = [UIColor lightGrayColor];
    }
    return _countDownButton;
}

@end
