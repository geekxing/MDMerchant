//
//  MDRegisterViewController.h
//  MDMerchant
//
//  Created by apple on 2017/8/6.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDRegisterViewController : UIViewController

@property (nonatomic, strong) void (^registerDidSuccess)(NSArray *textArr);

@end
