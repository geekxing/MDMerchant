//
//  UIButton+MDAdd.h
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MDAdd)


+ (instancetype)buttonTitle:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                      image:(UIImage *)image
                     image2:(UIImage *)image2
                      state:(UIControlState)state
                     target:(id)target
                     action:(SEL)action;

+ (instancetype)buttonTitle:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                 background:(UIImage *)background
                background2:(UIImage *)background2
                      state:(UIControlState)state
                     target:(id)target
                     action:(SEL)action;

/**
 快速创建自定义Button

 @param title title
 @param font font
 @param textColor 字体颜色
 @param image 图片
 @param image2 *状态下图片
 @param background 背景图片
 @param background2 *状态下背景图片
 @param state 对应状态
 @param target target
 @param action 点击事件
 @return 自定义按钮
 */
+ (instancetype)buttonTitle:(NSString *)title
                       font:(UIFont *)font
                  textColor:(UIColor *)textColor
                      image:(UIImage *)image
                     image2:(UIImage *)image2
                 background:(UIImage *)background
                background2:(UIImage *)background2
                      state:(UIControlState)state
                     target:(id)target
                     action:(SEL)action;

@end
