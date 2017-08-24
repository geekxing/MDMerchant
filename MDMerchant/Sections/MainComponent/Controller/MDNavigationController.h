//
//  MDNavigationController.h
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MDNavigationStyleRegister,
    MDNavigationStyleHomePage
} MDNavigationStyle;

@interface MDNavigationController : UINavigationController

@property (nonatomic, assign) MDNavigationStyle naviStyle;

@end
