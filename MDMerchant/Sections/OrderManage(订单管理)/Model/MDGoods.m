//
//  MDGoods.m
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDGoods.h"

#define DOLLAR_STR(str) [NSString stringWithFormat:@"￥%@",str]

@implementation MDGoods

- (void)setMoney_need:(NSString *)money_need {
    if (![money_need containsString:@"￥"]) {
        money_need = DOLLAR_STR(money_need);
    }
    _money_need = money_need;
}

@end
