//
//  MDSelectedListModel.h
//  MDMerchant
//
//  Created by apple on 2017/8/20.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDSelectedListModel : NSObject

@property (nonatomic , assign ) NSInteger sid;

@property (nonatomic , copy ) NSString *title;

@property (nonatomic , strong ) id context;

- (instancetype)initWithSid:(NSInteger)sid
                      Title:(NSString *)title;

- (instancetype)initWithSid:(NSInteger)sid
                      Title:(NSString *)title
                    Context:(id)context;

@end
