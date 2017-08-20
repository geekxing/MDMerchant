//
//  MDRegisterView.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDRegisterView.h"
#import "MDRoundCornerTextField.h"
#import "NSArray+MDAdd.h"

@interface MDRegisterView ()
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) NSMutableArray <MDRoundCornerTextField *>*textfieldArr;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *logo;
@end

@implementation MDRegisterView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self addSubview:_background];
    
    _logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"md"]];
    [self addSubview:_logo];
    
    NSArray *placeholderArr = @[@"请输入手机号", @"请输入商店名称", @"请输入密码", @"请再次输入密码"];
    _textfieldArr = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        MDRoundCornerTextField *field = [MDRoundCornerTextField new];
        field.placeholder = placeholderArr[i];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        [field addTarget:self action:@selector(onTextChanged) forControlEvents:UIControlEventEditingChanged];
        [_textfieldArr addObject:field];
    }
    _textfieldArr[0].keyboardType = UIKeyboardTypePhonePad;
    _textfieldArr[2].secureTextEntry = _textfieldArr[3].secureTextEntry = YES;
    [self md_addSubviews:_textfieldArr];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = UIFontMake(11);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"注册" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"register_round_button"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapRegistBtn) forControlEvents:UIControlEventTouchUpInside];
    btn.enabled = NO;
    _doneButton = btn;
    [self addSubview:_doneButton];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _background.frame = self.bounds;
    _logo.top = UIHeightRatio(83);
    _logo.centerX = self.width * .5;
    
    CGFloat gap = UIWidthRatio(37);
    CGFloat width = self.width - 2*gap;
    CGFloat height = roundf(width * 118 / 855);
    _doneButton.frame = CGRectMake(gap, self.height - UIHeightRatio(130)-height, width, height);
    
    NSMutableArray *fieldArr = [_textfieldArr mutableCopy];
    [fieldArr reverse];
    [fieldArr enumerateObjectsUsingBlock:^(MDRoundCornerTextField *field, NSUInteger idx, BOOL * stop) {
        CGFloat bottom = _doneButton.top - UIHeightRatio(38);
        field.size = CGSizeMake(width, height);
        field.left = gap;
        field.bottom = bottom - idx*(height + UIHeightRatio(7));
    }];
}

#pragma mark - Private

- (void)onTextChanged {
    BOOL isFullFilled = YES;
    for (UITextField *field in _textfieldArr) {
        isFullFilled &= (field.text && field.text.length);
    }
    _doneButton.enabled = isFullFilled;
}

- (void) tapRegistBtn {
    
}

@end
