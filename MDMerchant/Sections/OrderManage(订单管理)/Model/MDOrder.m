//
//  MDOrder.m
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDOrder.h"

#define DOLLAR_STR(str) [NSString stringWithFormat:@"￥%@",str]
#define MINUS_DOLLAR_STR(str) [NSString stringWithFormat:@"-￥%@",str]

@implementation MDOrder

- (instancetype)init
{
    self = [super init];
    if (self) {
        _layout = [MDOrderCellLayout new];
    }
    return self;
}

/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"goods":@"MDGoods"
             };
}

- (void)calcModelAndLayout {
    if (_originInCome && _realInCome);
    else {
        NSInteger originInCome = 0;
        NSInteger realInCome = 0;
        if (_goods) {
            for (MDGoods *goods in _goods) {
                originInCome += goods.money_need.integerValue;
            }
        }
        realInCome = originInCome - _money_service.integerValue-_money_discount.integerValue;
        realInCome = realInCome > 0 ? realInCome : 0;
        _originInCome = DOLLAR_STR(@(originInCome).stringValue);
        _realInCome = DOLLAR_STR(@(realInCome).stringValue);
    }
    if (!_layout.real_income_big_width) {
        NSDictionary *big_attr =@{NSFontAttributeName:UIFontMakeS(13)};
        _layout.real_income_big_width = [_realInCome sizeWithAttributes:big_attr].width;
    }
    CGFloat height =  149 + 10;
    
    if (_layout.isExpand) { //如果展开,则要计算以下属性
        NSDictionary *small_attr = @{NSFontAttributeName:UIFontMakeS(10)};
        _layout.real_income_small_width = [_realInCome sizeWithAttributes:small_attr].width;
        _layout.origin_income_width = [_originInCome sizeWithAttributes:small_attr].width;
        NSDictionary *tiny_attr = @{NSFontAttributeName:UIFontMakeS(8)};
        _layout.money_discount_width = [_money_discount sizeWithAttributes:tiny_attr].width;
        _layout.money_service_width = [_money_service sizeWithAttributes:tiny_attr].width;
        height += 107;
        if (_goods.count) {
            NSMutableArray *arr = [NSMutableArray array];
            CGFloat itemTotalH= 0;
            for (MDGoods *good in _goods) {
                [arr addObject:@([good.money_need sizeWithAttributes:tiny_attr].width)];
                itemTotalH += 40;
            }
            height += roundf(itemTotalH/3);
            _layout.goods_price_array = [arr copy];
        }
    }
    
    _layout.cell_height = height;
}

#pragma mark - setter
- (void)setMoney_discount:(NSString *)money_discount {
    if (![money_discount containsString:@"￥"]) {
        money_discount = MINUS_DOLLAR_STR(money_discount);
    }
    _money_discount = money_discount;
}

- (void)setMoney_service:(NSString *)money_service {
    if (![money_service containsString:@"￥"]) {
        money_service = MINUS_DOLLAR_STR(money_service);
    }
    _money_service = money_service;
}

@end
