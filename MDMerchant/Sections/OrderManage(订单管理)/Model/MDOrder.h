//
//  MDOrder.h
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDOrder : NSObject

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *time_arrive;
@property (nonatomic, copy) NSString *money_discount;
@property (nonatomic, copy) NSString *money_service;
@property (nonatomic, assign) NSInteger status;

@end
