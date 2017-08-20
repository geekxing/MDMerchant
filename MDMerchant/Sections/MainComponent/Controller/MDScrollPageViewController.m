//
//  MDScrollPageViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDScrollPageViewController.h"
#import "MDTitleView.h"
#import "MDBaseViewController.h"

@interface MDScrollPageViewController ()
@property (nonatomic, strong) NSArray *vcTitles;
@property (nonatomic, strong) MDTitleView *titleView;
@end

@implementation MDScrollPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewControllers];
    [self setupUI];
}

#pragma mark - Private
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    MDTitleViewConfiguration *config = [MDTitleViewConfiguration new];
    if (self.childViewControllers.count) {
        config.menuWidth = SCREEN_WIDTH/self.childViewControllers.count;
        config.underLineWidth = config.menuWidth;
    }
    config.menuRowHeight = 46;
    config.textFont = [UIFont boldSystemFontOfSize:13];
    
    MDWS
    MDTitleView *titleView =
    [MDTitleView showWithConfig:config
                      menuArray:_vcTitles
                     imageArray:nil
                      doneBlock:^(NSInteger selectedIndex) {
                          [wself clickTitleAtIndex:selectedIndex];
                      }];
    titleView.isBtnEnaled = YES;
    titleView.backgroundColor = MDThemeYellow;
    titleView.frame = CGRectMake(0, 0, config.menuWidth * [_vcList count], config.menuRowHeight);
    _titleView = titleView;
    [self.view addSubview:titleView];
}

- (void)clickTitleAtIndex:(NSInteger)index {
    for (UIViewController *vc in _vcList) {
        [vc.view removeFromSuperview];
    }
    UIView *childView = self.childViewControllers[index].view;
    CGFloat y =  46;
    childView.frame = CGRectMake(0, y, self.view.width, self.view.height - y);
    [self.view addSubview:childView];
}

- (void)setupChildViewControllers {
    [self.view removeAllSubviews];
    [self.childViewControllers makeObjectsPerformSelector:@selector(removeFromParentViewController)];
    
    NSMutableArray *titles = [NSMutableArray array];
    for (UIViewController *vc in self.vcList) {
        [self addChildViewController:vc];
        NSString *title = [(MDBaseViewController *)vc navTitle];
        [titles addObject:title ? title : @""];
    }
    _vcTitles = [titles copy];
    [self clickTitleAtIndex:0];
}

#pragma mark-  setter

@end
