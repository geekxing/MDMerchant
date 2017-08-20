//
//  UIBarButtonItem+MDAdd.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "UIBarButtonItem+MDAdd.h"

#define CUSTOM_TAG 10000

@implementation UIBarButtonItem (MDAdd)

+ (instancetype)itemWithTitle:(NSString *)title
                        image:(NSString *)image
                       image2:(NSString *)image2
                        state:(UIControlState)state
                       target:(id)target
                       action:(SEL)action
                          pos:(MDBarItemPositioning)pos {
    UIButton *button = [UIButton buttonTitle:title
                                        font:nil
                                   textColor:nil
                                       image:[UIImage imageNamed:image]
                                      image2:[UIImage imageNamed:image2]
                                       state:state
                                      target:target
                                      action:action];
    UIView *customView = [self makeView:button];
    pos == MDBarItemPositioningLeft ? (button.left = -BARBUTTONITEM_OFFSET) : (button.right = customView.width+BARBUTTONITEM_OFFSET);
    
    UIBarButtonItem *barItem = [[self alloc] initWithCustomView:customView];
    
    return barItem;
}

+ (instancetype)itemWithCustomView:(UIView *)customView {
    UIView *customContainer = [self makeView:customView];
    UIBarButtonItem *barItem = [[self alloc] initWithCustomView:customContainer];
    
    return barItem;
}

- (UIButton *)xsx_customView {
    return [self.customView viewWithTag:CUSTOM_TAG];
}

#pragma mark - Private

+ (UIView *)makeView:(UIView *)respondCtrl {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    respondCtrl.tag = CUSTOM_TAG;
    respondCtrl.centerY = customView.height * .5;
    [customView addSubview:respondCtrl];
    return customView;
}

@end
