//
//  MDOrderManageViewController.h
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDBaseViewController.h"

typedef enum : NSUInteger {
    MDOrderStatusProcessing,
    MDOrderStatusCompleted,
    MDOrderStatusCanceled,
} MDOrderStatus;

@interface MDOrderManageViewController : MDBaseViewController

@property (nonatomic, assign) MDOrderStatus status;

@end
