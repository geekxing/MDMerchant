//
//  MDNetworkTool.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDNetworkTool.h"

NSString *const Param_Id            = @"identification";
NSString *const Param_Shop          = @"shop_name";
NSString *const Param_Password      = @"password";

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
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", @"text/javascript", nil];
    }
    return self;
}

/*** 基本操作方法 */

//POST
+ (void)postWithParams:(NSDictionary *)params url:(NSString *)url okCodeList:(NSArray *)codes completeHanlder:(void(^)(id response, NSError *err))handler {
    __block NSError *err;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[MDNetworkTool shared] POST:RequestBaseURL(url) parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSInteger responseCode = [responseObject[RQCODE] integerValue];
        if (![codes containsObject:@(responseCode)])  {
            err = [NSError errorWithDomain:MDErrorDomain code:[responseObject[RQCODE] integerValue]
                                  userInfo:@{NSLocalizedDescriptionKey : responseObject[RQMSG]}];
            if (handler) {
                handler(responseObject, err);
            }
            return ;
        }
        if (handler) {
            handler(responseObject, err);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (handler) {
            handler(nil, error);
        }
    }];
}

+ (void)postWithParams:(NSDictionary *)params url:(NSString *)url successCode:(NSInteger)code completeHanlder:(MDNetCommonBlock)handler {
    [self postWithParams:params url:url okCodeList:@[@(code)] completeHanlder:handler];
}

//GET
+ (void)getWithParams:(NSDictionary *)params url:(NSString *)url okCode:(NSInteger)code completeHanlder:(MDNetCommonBlock)handler {
    __block NSError *err;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[MDNetworkTool shared] GET:RequestBaseURL(url) parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSInteger responseCode = [responseObject[RQCODE] integerValue];
        if (code != responseCode)  {
            err = [NSError errorWithDomain:MDErrorDomain code:[responseObject[RQCODE] integerValue]
                                  userInfo:@{NSLocalizedDescriptionKey : responseObject[RQMSG]}];
            if (handler) {
                handler(responseObject, err);
            }
            return ;
        }
        if (handler) {
            handler(responseObject, err);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (err.code == -999 || err.code == -1001) {
            [SVProgressHUD showWithStatus:@"网络中断，请检查你的网络设置"];
        }
        if (handler) {
            handler([NSNull null], error);
        }
    }];
}
//UPLOAD
+ (void)uploadWithUrl:(NSString *)url images:(NSArray *)images params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError * error))failure {
    MDNetworkTool *manager = [MDNetworkTool manager];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    [manager POST:RequestBaseURL(url) parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSData *imageData;
            if ([obj isKindOfClass:[UIImage class]]) {
                UIImage *compressedImage = [(UIImage *)obj md_imageForScreenSizeUpload];
                imageData = [compressedImage md_compressToDataLength:100];
            } else {
                imageData = obj;
            }
            [formData appendPartWithFileData:imageData
                                        name:@"images"
                                    fileName:[NSString stringWithFormat:@"md-%zd.jpeg",idx]
                                    mimeType:@"image/jpeg"];
        }];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger responseCode = [responseObject[RQCODE] integerValue];
        if (responseCode != NormalSuccessCode)  {
            NSError * err =
            [NSError errorWithDomain:MDErrorDomain
                                code:[responseObject[RQCODE] integerValue]
                            userInfo:@{NSLocalizedDescriptionKey : responseObject[RQMSG]}];
            if (failure) {
                failure(err);
            }
            return;
        }
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
