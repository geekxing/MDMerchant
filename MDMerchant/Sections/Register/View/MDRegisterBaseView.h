//
//  MDRegisterBaseView.h
//  MDMerchant
//
//  Created by apple on 2017/8/20.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRoundCornerTextField.h"

@protocol MDRegisterBaseViewDatasource <NSObject>
- (NSInteger)numberOfTextFields;
- (void)textField:(UITextField *)textField atIndex:(NSInteger)index;
@end

@interface MDRegisterBaseView : UIView

@property (nonatomic, strong, readonly) NSMutableArray <MDRoundCornerTextField *>*textfieldArr;
@property (nonatomic, weak) id<MDRegisterBaseViewDatasource> dataSource;
@property (nonatomic, strong, readonly) UIButton *doneButton;
@property (nonatomic, strong) void (^doneButtonClicked)(UIButton *btn, NSArray *textArr);

//子类重写该初始化方法
- (void)setup NS_REQUIRES_SUPER;

@end
