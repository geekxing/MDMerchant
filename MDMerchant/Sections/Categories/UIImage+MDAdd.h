//
//  UIImage+MDAdd.h
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CGContextInspectSize(size) [UIImage inspectContextSize:size]

#ifdef DEBUG
#define CGContextInspectContext(context) [UIImage inspectContextIfInvalidatedInDebugMode:context]
#else
#define CGContextInspectContext(context) if(![UIImage inspectContextIfInvalidatedInReleaseMode:context]){return nil;}
#endif

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */
CG_INLINE CGFloat
flatSpecificScale(CGFloat floatValue, CGFloat scale) {
    scale = scale == 0 ? [UIScreen mainScreen].scale : scale;
    CGFloat flattedValue = ceil(floatValue * scale) / scale;
    return flattedValue;
}

CG_INLINE CGSize
CGSizeFlatSpecificScale(CGSize size, float scale) {
    return CGSizeMake(flatSpecificScale(size.width, scale), flatSpecificScale(size.height, scale));
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */
CG_INLINE CGFloat
flat(CGFloat floatValue) {
    return flatSpecificScale(floatValue, 0);
}

/// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
CG_INLINE CGRect
CGRectFlatted(CGRect rect) {
    return CGRectMake(flat(rect.origin.x), flat(rect.origin.y), flat(rect.size.width), flat(rect.size.height));
}

/// 为一个CGRect叠加scale计算
CG_INLINE CGRect
CGRectApplyScale(CGRect rect, CGFloat scale) {
    return CGRectFlatted(CGRectMake(CGRectGetMinX(rect) * scale, CGRectGetMinY(rect) * scale, CGRectGetWidth(rect) * scale, CGRectGetHeight(rect) * scale));
}


@interface UIImage (MDAdd)

+ (instancetype)imageWithColor:(UIColor *)color;
+ (UIImage *)md_imageWithColor:(UIColor *)color size:(CGSize)size;
- (UIImage *)md_imageForUpload;
- (UIImage *)md_imageWithScaleToSize:(CGSize)size;
- (UIImage *)md_imageWithScaleToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;
- (UIImage *)md_imageWithScaleToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode scale:(CGFloat)scale;
- (UIImage *)md_imageWithScaleToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode scale:(CGFloat)scale needCircle:(BOOL)circle;
- (UIImage *)md_imageWithClippedRect:(CGRect)rect;
- (UIImage *)md_imageForScreenSizeUpload;


- (NSData *)md_compressToDataLength:(CGFloat)maxLength;

@end
