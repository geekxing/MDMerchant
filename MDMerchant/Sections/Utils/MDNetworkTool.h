//
//  MDNetworkTool.h
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface MDNetworkTool : AFHTTPSessionManager
+ (MDNetworkTool *)shared;
@end
