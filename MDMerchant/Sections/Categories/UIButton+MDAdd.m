//
//  UIButton+MDAdd.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "UIButton+MDAdd.h"
#import <objc/runtime.h>
static char TIME_COMPLETE_BLOCK;

@implementation UIButton (MDAdd)

#pragma mark - Properties

- (void)setTimerBtnComplete:(void (^)(UIButton *))timerBtnComplete {
    objc_setAssociatedObject(self, &TIME_COMPLETE_BLOCK, timerBtnComplete, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(UIButton *))timerBtnComplete {
    return objc_getAssociatedObject(self, &TIME_COMPLETE_BLOCK);
}

#pragma mark - Functions

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

- (void)createTimerWithEndFormat:(NSString *)fmt1 schedulingFormat:(NSString *)fmt2,... {
    __block int timeout = 61;
    //获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    // 设置触发的间隔时间
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    MDWS
    //设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        //倒计时  刷新button上的title ，当倒计时时间为0时，结束倒计时
        //1. 每调用一次 时间-1s
        timeout --;
        //2.对timeout进行判断时间是停止倒计时，还是修改button的title
        if (timeout <= 0) {
            //停止倒计时，button打开交互，背景颜色还原，title还原
            //关闭定时器
            dispatch_source_cancel(timer);
            //button上的相关设置
            //注意: button是属于UI，在iOS中多线程处理时，UI控件的操作必须是交给主线程(主队列)
            //在主线程中对button进行修改操作
            dispatch_async(dispatch_get_main_queue(), ^{
                wself.userInteractionEnabled = YES;
                [wself setTitle:fmt1 forState:UIControlStateNormal];
                if (wself.timerBtnComplete) {
                    wself.timerBtnComplete(wself);
                }
            });
        }else {
            //处于正在倒计时，在主线程中刷新button上的title，时间-1秒
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * title = [NSString stringWithFormat:fmt2, timeout];
                [wself setTitle:title forState:UIControlStateNormal];
            });
        }
    });
    
    dispatch_resume(timer);
}

@end
