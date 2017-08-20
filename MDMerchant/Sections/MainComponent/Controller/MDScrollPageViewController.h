//
//  MDScrollPageViewController.h
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDScrollPageViewController : UIViewController
{
    NSArray <__kindof UIViewController *>*_vcList;
}

@property (nonatomic, strong) NSArray <__kindof UIViewController *>*vcList;

@end
