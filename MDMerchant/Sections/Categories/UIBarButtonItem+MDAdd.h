//
//  UIBarButtonItem+MDAdd.h
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>
#define BARBUTTONITEM_OFFSET 0

typedef NS_ENUM(NSUInteger, MDBarItemPositioning) {
    MDBarItemPositioningLeft,
    MDBarItemPositioningRight
};

@interface UIBarButtonItem (MDAdd)

/**
  快速创建自定义导航栏按钮

 @param title 标题
 @param image 图片
 @param image2 图片2
 @param state 对应状态
 @param target target
 @param action 事件
 @param pos 放置的位置（左、右）
 @return 自定义导航栏
 */
+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
                       image2:(NSString *)image2
                        state:(UIControlState)state
                       target:(id)target
                       action:(SEL)action
                          pos:(MDBarItemPositioning)pos;

/**
 快速创建自定义导航栏按钮
 
 @param customView 自定义的view
 @return UIBarButtonItem
 */
+ (instancetype)itemWithCustomView:(UIView *)customView;

- (UIButton *)xsx_customView;

@end
