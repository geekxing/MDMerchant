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

- (NSData *)md_compressToDataLength:(CGFloat)maxLength {
    
    CGFloat compress = 1.0;
    NSData *data = UIImageJPEGRepresentation(self, compress);
    //循环条件：数据量 > 100kb ，压缩率 > 0.01
    while (data.length / 10 > powf(maxLength, 2) && compress > 0.01) {
        compress -= 0.08;
        data = UIImageJPEGRepresentation(self, compress);
    }
    return data;
}

- (UIImage *)md_imageForUpload {
    CGSize imageSize =  CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH);
    UIImage *resizedImage = [self md_imageWithScaleToSize:imageSize
                                               contentMode:UIViewContentModeScaleAspectFill];
    CGRect photoRect = (CGRect){CGPointMake((resizedImage.size.width - imageSize.width) / 2, (resizedImage.size.height - imageSize.height) / 2), imageSize};
    return [resizedImage md_imageWithClippedRect:photoRect];
}

- (UIImage *)md_imageWithScaleToSize:(CGSize)size {
    return [self md_imageWithScaleToSize:size contentMode:UIViewContentModeScaleAspectFit];
}

- (UIImage *)md_imageWithScaleToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
    return [self md_imageWithScaleToSize:size contentMode:contentMode scale:self.scale];
}

- (UIImage *)md_imageWithScaleToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode scale:(CGFloat)scale {
    return [self md_imageWithScaleToSize:size contentMode:contentMode scale:scale needCircle:NO];
}

- (UIImage *)md_imageWithScaleToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode scale:(CGFloat)scale needCircle:(BOOL)circle {
    size = CGSizeFlatSpecificScale(size, scale);
    CGContextInspectSize(size);
    CGSize imageSize = self.size;
    CGRect drawingRect = CGRectZero;
    
    if (contentMode == UIViewContentModeScaleToFill) {
        drawingRect = CGRectMake(0, 0, size.width, size.height);
    } else {
        CGFloat horizontalRatio = size.width / imageSize.width;
        CGFloat verticalRatio = size.height / imageSize.height;
        CGFloat ratio = 0;
        if (contentMode == UIViewContentModeScaleAspectFill) {
            ratio = fmaxf(horizontalRatio, verticalRatio);
        } else {
            // 默认按 UIViewContentModeScaleAspectFit
            ratio = fminf(horizontalRatio, verticalRatio);
        }
        drawingRect.size.width = flatSpecificScale(imageSize.width * ratio, scale);
        drawingRect.size.height = flatSpecificScale(imageSize.height * ratio, scale);
    }
    
    UIGraphicsBeginImageContextWithOptions(drawingRect.size, NO, scale);
    if (circle) {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextAddEllipseInRect(ctx, drawingRect);
        CGContextClip(ctx);
    }
    [self drawInRect:drawingRect];
    UIImage *imageOut = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageOut;
}

- (UIImage *)md_imageWithClippedRect:(CGRect)rect {
    CGContextInspectSize(rect.size);
    CGRect imageRect = (CGRect) {CGPointZero, self.size};
    if (CGRectContainsRect(rect, imageRect)) {
        // 要裁剪的区域比自身大，所以不用裁剪直接返回自身即可
        return self;
    }
    // 由于CGImage是以pixel为单位来计算的，而UIImage是以point为单位，所以这里需要将传进来的point转换为pixel
    CGRect scaledRect = CGRectApplyScale(rect, self.scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, scaledRect);
    UIImage *imageOut = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return imageOut;
}

- (UIImage *)md_imageForScreenSizeUpload
{
    CGFloat pixels = SCREEN_WIDTH*SCREEN_HEIGHT;
    UIImage *image = [self md_imageForUpload:pixels];
    return [image md_fixOrientation];
}

#pragma mark - Private

- (UIImage *)md_imageForUpload: (CGFloat)suggestPixels
{
    const CGFloat kMaxPixels = 4000000;
    const CGFloat kMaxRatio  = 3;
    
    CGFloat width = self.size.width;
    CGFloat height= self.size.height;
    
    //对于超过建议像素，且长宽比超过max ratio的图做特殊处理
    if (width * height > suggestPixels &&
        (width / height > kMaxRatio || height / width > kMaxRatio))
    {
        return [self md_scaleWithMaxPixels:kMaxPixels];
    }
    else
    {
        return [self md_scaleWithMaxPixels:suggestPixels];
    }
}
- (UIImage *)md_scaleWithMaxPixels: (CGFloat)maxPixels
{
    CGFloat width = self.size.width;
    CGFloat height= self.size.height;
    if (width * height < maxPixels || maxPixels == 0)
    {
        return self;
    }
    CGFloat ratio = sqrt(width * height / maxPixels);
    if (fabs(ratio - 1) <= 0.01)
    {
        return self;
    }
    CGFloat newSizeWidth = width / ratio;
    CGFloat newSizeHeight= height/ ratio;
    return [self md_scaleToSize:CGSizeMake(newSizeWidth, newSizeHeight)];
}

//内缩放，一条变等于最长边，另外一条小于等于最长边
- (UIImage *)md_scaleToSize:(CGSize)newSize
{
    CGFloat width = self.size.width;
    CGFloat height= self.size.height;
    CGFloat newSizeWidth = newSize.width;
    CGFloat newSizeHeight= newSize.height;
    if (width <= newSizeWidth &&
        height <= newSizeHeight)
    {
        return self;
    }
    
    if (width == 0 || height == 0 || newSizeHeight == 0 || newSizeWidth == 0)
    {
        return nil;
    }
    CGSize size;
    if (width / height > newSizeWidth / newSizeHeight)
    {
        size = CGSizeMake(newSizeWidth, newSizeWidth * height / width);
    }
    else
    {
        size = CGSizeMake(newSizeHeight * width / height, newSizeHeight);
    }
    return [self md_drawImageWithSize:size];
}

- (UIImage *)md_drawImageWithSize: (CGSize)size
{
    CGSize drawSize = CGSizeMake(floor(size.width), floor(size.height));
    UIGraphicsBeginImageContext(drawSize);
    
    [self drawInRect:CGRectMake(0, 0, drawSize.width, drawSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)md_fixOrientation
{
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp)
        return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}



#pragma mark - misc
+ (void)inspectContextSize:(CGSize)size {
    if (size.width < 0 || size.height < 0) {
        NSAssert(NO, @"QMUI CGPostError, %@:%d %s, 非法的size：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, NSStringFromCGSize(size), [NSThread callStackSymbols]);
    }
}
+ (void)inspectContextIfInvalidatedInDebugMode:(CGContextRef)context {
    if (!context) {
        // crash了就找zhoon或者molice
        NSAssert(NO, @"QMUI CGPostError, %@:%d %s, 非法的context：%@\n%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, context, [NSThread callStackSymbols]);
    }
}
+ (BOOL)inspectContextIfInvalidatedInReleaseMode:(CGContextRef)context {
    if (context) {
        return YES;
    }
    return NO;
}

@end
