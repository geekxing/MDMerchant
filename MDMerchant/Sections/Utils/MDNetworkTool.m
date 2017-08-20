//
//  MDNetworkTool.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDNetworkTool.h"

@implementation MDNetworkTool

static MDNetworkTool *_mgr;

+ (MDNetworkTool *)shared

{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _mgr = [MDNetworkTool manager];
        
        [_mgr.requestSerializer setTimeoutInterval:15];  //15秒超时
        
    });
    
    return _mgr;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

@end
