//
//  MDOrderCellLayout.h
//  MDMerchant
//
//  Created by apple on 2017/8/22.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDOrderCellLayout : NSObject

@property (nonatomic, assign) BOOL isExpand;

@property (nonatomic, assign) CGFloat real_income_big_width;

@property (nonatomic, assign) CGFloat real_income_small_width;

@property (nonatomic, assign) CGFloat origin_income_width;

@property (nonatomic, assign) CGFloat money_service_width;

@property (nonatomic, assign) CGFloat money_discount_width;

@property (nonatomic, strong) NSArray *goods_price_array;

@property (nonatomic, assign) CGFloat cell_height;

- (void)resetLayoutConfig;

@end
