//
//  UIButton+MDAdd.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "UIButton+MDAdd.h"

@implementation UIButton (MDAdd)

+ (instancetype)buttonTitle:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                      image:(UIImage *)image
                     image2:(UIImage *)image2
                      state:(UIControlState)state
                     target:(id)target
                     action:(SEL)action {
    return [self buttonTitle:title
                        font:font
                   textColor:textColor
                       image:image
                      image2:image2
                  background:nil
                 background2:nil
                       state:state
                      target:target
                      action:action];
}

+ (instancetype)buttonTitle:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                 background:(UIImage *)background
                background2:(UIImage *)background2
                      state:(UIControlState)state
                     target:(id)target
                     action:(SEL)action {
    return [self buttonTitle:title
                        font:font
                   textColor:textColor
                       image:nil
                      image2:nil
                  background:background
                 background2:background2
                       state:state
                      target:target
                      action:action];
}


+ (instancetype)buttonTitle:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                      image:(UIImage *)image
                     image2:(UIImage *)image2
                 background:(UIImage *)background
                background2:(UIImage *)background2
                      state:(UIControlState)state
                     target:(id)target
                     action:(SEL)action {
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    if (font) button.titleLabel.font = font;
    if (textColor) [button setTitleColor:textColor forState:UIControlStateNormal];
    if (image) [button setBackgroundImage:image forState:UIControlStateNormal];
    if (image2) [button setBackgroundImage:image2 forState:state];
    if (background) [button setImage:background forState:UIControlStateNormal];
    if (background2) [button setImage:background2 forState:state];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return button;
}


@end
