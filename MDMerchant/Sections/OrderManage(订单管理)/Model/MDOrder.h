//
//  MDOrder.h
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDGoods.h"
#import "MDOrderCellLayout.h"

typedef enum : NSUInteger {
    MDOrderStatusProcessing,
    MDOrderStatusCompleted,
    MDOrderStatusCanceled,
} MDOrderStatus;

@interface MDOrder : NSObject

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *time_arrive;
@property (nonatomic, copy) NSString *money_discount;
@property (nonatomic, copy) NSString *money_service;
@property (nonatomic, assign) MDOrderStatus status;
@property (nonatomic, strong) NSArray *goods;

///辅助属性
@property (nonatomic, copy) NSString *originInCome;
@property (nonatomic, copy) NSString *realInCome;
@property (nonatomic, strong, readonly) MDOrderCellLayout *layout;


- (void)calcModelAndLayout;

@end
