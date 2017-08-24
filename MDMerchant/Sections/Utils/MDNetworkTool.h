//
//  MDNetworkTool.h
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

#define MDErrorDomain @"com.company.mdapp.ErrorDomain"
/*** 网络请求 */
#define RequestBaseURL(category) [@"http://101.132.41.114:8080/miandui/" stringByAppendingString:category]
#define RQCODE    @"code"
#define RQMSG     @"msg"
#define RQCONTENT @"content"

/*** 返回码 */
#define NormalSuccessCode  200
typedef void(^MDNetCommonBlock)(id response, NSError *err);

extern NSString *const Param_Id;
extern NSString *const Param_Shop;
extern NSString *const Param_Password;

@interface MDNetworkTool : AFHTTPSessionManager
+ (MDNetworkTool *)shared;

//POST
+ (void)postWithParams:(NSDictionary *)params url:(NSString *)url okCodeList:(NSArray *)codes completeHanlder:(void(^)(id response, NSError *err))handler;
+ (void)postWithParams:(NSDictionary *)params url:(NSString *)url successCode:(NSInteger)code completeHanlder:(MDNetCommonBlock)handler;
//GET
+ (void)getWithParams:(NSDictionary *)params url:(NSString *)url okCode:(NSInteger)code completeHanlder:(MDNetCommonBlock)handler;
//UPLOAD
+ (void)uploadWithUrl:(NSString *)url images:(NSArray *)images params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure;
@end
