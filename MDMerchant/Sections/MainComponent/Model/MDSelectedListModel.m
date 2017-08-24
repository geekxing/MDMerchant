//
//  MDSelectedListModel.m
//  MDMerchant
//
//  Created by apple on 2017/8/20.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDSelectedListModel.h"

@implementation MDSelectedListModel


- (instancetype)initWithSid:(NSInteger)sid
                      Title:(NSString *)title{
    
    return [[MDSelectedListModel alloc] initWithSid:sid Title:title Context:nil];
}

- (instancetype)initWithSid:(NSInteger)sid
                      Title:(NSString *)title
                    Context:(id)context{
    
    self = [super init];
    
    if (self) {
        
        _sid = sid;
        
        _title = title;
        
        _context = context;
    }
    
    return self;
}

@end
