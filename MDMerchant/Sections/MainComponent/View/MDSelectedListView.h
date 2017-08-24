//
//  MDSelectedListView.h
//  MDMerchant
//
//  Created by apple on 2017/8/20.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MDSelectedListModel.h"

@interface MDSelectedListView : UITableView


@property (nonatomic , strong ) NSArray<MDSelectedListModel *>* array;

/**
 已选中Block
 */
@property (nonatomic , copy ) void (^selectedBlock)(NSArray <MDSelectedListModel *>*);

/**
 选择改变Block (多选情况 当选择改变时调用)
 */
@property (nonatomic , copy ) void (^changedBlock)(NSArray <MDSelectedListModel *>*);

/**
 是否单选
 */
@property (nonatomic , assign ) BOOL isSingle;

/**
 完成选择 (多选会调用selectedBlock回调所选结果)
 */
- (void)finish;

@end
