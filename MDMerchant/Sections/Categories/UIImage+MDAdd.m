//
//  UIImage+MDAdd.m
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "UIImage+MDAdd.h"

@implementation UIImage (MDAdd)

+ (instancetype)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    return [self md_imageWithColor:color size:rect.size];
}

+ (UIImage *)md_imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = (CGRect){CGPointZero, size};
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextFillRect(ctx, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

@end
