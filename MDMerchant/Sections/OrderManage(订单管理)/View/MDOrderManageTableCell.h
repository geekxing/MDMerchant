//
//  MDOrderManageTableCell.h
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDOrder.h"

@interface MDOrderManageTableCell : UITableViewCell

@property (nonatomic, strong) MDOrder *order;
@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) void (^didClickExpandButton)();

@end
