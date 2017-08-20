//
//  MDSearchBar.m
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDSearchBar.h"

@implementation MDSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self md_config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self md_config];
    }
    return self;
}

- (void)md_config {
    self.placeholder = @"";
    // 样式
    [self setImage:[UIImage imageNamed:@"icon_search"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    //Default icon x may be 8pt
    [self setPositionAdjustment:UIOffsetMake(5, 0) forSearchBarIcon:UISearchBarIconSearch];
    self.backgroundImage = [UIImage new];
    // ** 自定义searchBar的样式 **
    UITextField* searchField = [self textfieldInSearchBar];
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.backgroundColor = MDThemeYellow;
    // 设置圆角
    searchField.layer.borderColor = [UIColor blackColor].CGColor;
    searchField.layer.borderWidth = .34;
    searchField.layer.cornerRadius = 5;
    searchField.layer.masksToBounds = YES;
}

- (UITextField *)textfieldInSearchBar {
    UITextField *textfield = nil;
    // 注意searchBar的textField处于孙图层中
    for (UIView* subview  in [self.subviews firstObject].subviews) {
        // 打印出两个结果:
        /*
         UISearchBarBackground
         UISearchBarTextField
         */
        
        if ([subview isKindOfClass:[UITextField class]]) {
            textfield = (UITextField *)subview;
            break;
        }
    }
    return textfield;
}

#pragma mark - overrides
- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    UITextField *field = [self textfieldInSearchBar];
    field.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName:field.font, NSForegroundColorAttributeName:[UIColor colorWithWhite:0 alpha:.5]}];
}


@end
