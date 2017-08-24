//
//  MDRegisterBaseView.m
//  MDMerchant
//
//  Created by apple on 2017/8/20.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDRegisterBaseView.h"
#import "MDRoundCornerTextField.h"
#import "NSArray+MDAdd.h"

@interface MDRegisterBaseView()
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIImageView *background;
@property (nonatomic, strong) UIImageView *logo;
@end

@implementation MDRegisterBaseView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self setup];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.dataSource && !_textfieldArr) {
        [self setup];
    }
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [self addSubview:_background];
    
    _logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"md"]];
    [self addSubview:_logo];
    
    NSInteger tfCnt = [_dataSource numberOfTextFields];
    _textfieldArr = [NSMutableArray arrayWithCapacity:tfCnt];
    for (NSInteger i = 0; i < tfCnt; i++) {
        MDRoundCornerTextField *field = [MDRoundCornerTextField new];
        field.clearButtonMode = UITextFieldViewModeWhileEditing;
        [field addTarget:self action:@selector(onTextChanged) forControlEvents:UIControlEventEditingChanged];
        [_dataSource textField:field atIndex:i];
        [_textfieldArr addObject:field];
    }
    [self md_addSubviews:_textfieldArr];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = UIFontMake(11);
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"register_round_button"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tapDoneBtn:) forControlEvents:UIControlEventTouchUpInside];
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

    [_textfieldArr enumerateObjectsUsingBlock:^(MDRoundCornerTextField *field, NSUInteger idx, BOOL * stop) {
        CGFloat top = UIHeightRatio(312);
        field.size = CGSizeMake(width, height);
        field.left = gap;
        field.top = top + idx*(height + UIHeightRatio(7));
    }];
    
    _doneButton.frame = CGRectMake(gap, _textfieldArr.lastObject.bottom + UIHeightRatio(38), width, height);
}

#pragma mark - Private

- (void)onTextChanged {
    BOOL isFullFilled = YES;
    for (UITextField *field in _textfieldArr) {
        isFullFilled &= (field.text && field.text.length);
    }
    _doneButton.enabled = isFullFilled;
}

- (void) tapDoneBtn:(UIButton *)btn {
    if (_doneButtonClicked) {
        NSMutableArray *textArr = [NSMutableArray array];
        for (UITextField *tf in _textfieldArr) {
            [textArr addObject:tf.text ? tf.text : @""];
        }
        _doneButtonClicked(btn, textArr);
    }
}

@end
