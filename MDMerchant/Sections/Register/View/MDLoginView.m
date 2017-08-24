//
//  MDLoginView.m
//  MDMerchant
//
//  Created by apple on 2017/8/20.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDLoginView.h"
#import "MDRegisterViewController.h"
#import "MDSelectedListView.h"
#import "MDOtherLoginViewController.h"
#import <LEEAlert.h>

@interface MDLoginView()
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *hasProblemLoginButton;
@end

@implementation MDLoginView

- (void)setup {
    [super setup];
    
    _registerButton = [UIButton buttonTitle:@"注册"
                                       font:UIFontMake(11)
                                  textColor:[UIColor blackColor]
                                      image:nil
                                     image2:nil
                                      state:UIControlStateNormal
                                     target:self
                                     action:@selector(tapRegister)];
    _hasProblemLoginButton = [UIButton buttonTitle:@"无法登录？"
                                              font:UIFontMake(11)
                                         textColor:[UIColor blackColor]
                                             image:nil
                                            image2:nil
                                             state:UIControlStateNormal
                                            target:self
                                            action:@selector(tapHasProblemLogin)];
    [self md_addSubviews:@[_registerButton, _hasProblemLoginButton]];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _hasProblemLoginButton.left = self.doneButton.left;
    _hasProblemLoginButton.bottom = self.height - UIHeightRatio(30);
    _registerButton.right = self.doneButton.right;
    _registerButton.bottom = self.height - UIHeightRatio(30);
}

#pragma mark - Private
- (void)tapHasProblemLogin {
    MDSelectedListView *view = [[MDSelectedListView alloc] initWithFrame:CGRectMake(0, 0, 280, 0) style:UITableViewStylePlain];
    
    view.isSingle = YES;
    
    view.array = @[[[MDSelectedListModel alloc] initWithSid:1 Title:@"短信验证码登录"]];
    
    MDWS
    view.selectedBlock = ^(NSArray<MDSelectedListModel *> *array) {
        
        MDOtherLoginViewController *vc = [MDOtherLoginViewController new];
        [wself.viewController.navigationController pushViewController:vc animated:YES];
        
        [LEEAlert closeWithCompletionBlock:^{
            
            NSLog(@"选中的%@" , array);
        }];
        
    };
    
    [LEEAlert alert].config
    .LeeTitle(@"忘记密码？")
    .LeeItemInsets(UIEdgeInsetsMake(20, 0, 20, 0))
    .LeeCustomView(view)
    .LeeItemInsets(UIEdgeInsetsMake(0, 0, 0, 0))
    .LeeHeaderInsets(UIEdgeInsetsMake(10, 0, 0, 0))
    .LeeClickBackgroundClose(YES)
    .LeeShow();
}

- (void)tapRegister {
    MDRegisterViewController *vc = [MDRegisterViewController new];
    MDWS
    vc.registerDidSuccess = ^(NSArray *textArr) {
        if (textArr[0]) {  //账号
            wself.textfieldArr[0].text = textArr[0];
        }
        if (textArr[2]) { //密码
            wself.textfieldArr[1].text = textArr[2];
        }
        wself.doneButton.enabled = (textArr[0]&&textArr[2]);
    };
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
