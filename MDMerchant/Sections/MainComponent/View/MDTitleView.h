//
//  MDTitleView.h
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MDTitleViewDoneBlock)(NSInteger selectedIndex);

/**
 *  -----------------------MDTitleViewConfiguration-----------------------
 */
@interface MDTitleViewConfiguration : NSObject

@property (nonatomic, assign)CGFloat menuTextMargin;// Default is 6.
@property (nonatomic, assign)CGFloat menuIconMargin;// Default is 6.
@property (nonatomic, assign)CGFloat menuRowHeight;
@property (nonatomic, assign)CGFloat menuWidth;
@property (nonatomic, assign)CGFloat underLineWidth;
@property (nonatomic, strong)UIColor *textColor;
@property (nonatomic, strong)UIColor *selectedTextColor;
@property (nonatomic, strong)UIFont  *textFont;
@property (nonatomic, assign)NSTextAlignment textAlignment;

@end

/**
 *  -----------------------MDTitleCollectionCell-----------------------
 */
@interface MDTitleCollectionCell:UICollectionViewCell
@end
/**
 *  -----------------------MDTitleView-----------------------
 */
@interface MDTitleView : UIView

@property (nonatomic, strong, readonly) MDTitleViewConfiguration *config;
@property (nonatomic, assign, readonly) NSInteger previousIndex;
@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, assign) BOOL isBtnEnaled;

+ (instancetype)showWithConfig:(MDTitleViewConfiguration *)config
                     menuArray:(NSArray<NSString*> *)menuArray
                    imageArray:(NSArray *)imageArray
                     doneBlock:(MDTitleViewDoneBlock)doneBlock;

- (void)refreshWithMenuArray:(NSArray<NSString*> *)menuArray
                  imageArray:(NSArray *)imageArray;

- (void)refreshWithTitle:(NSString *)title
                   image:(UIImage *)image
                 atIndex:(NSInteger)index;

@end
