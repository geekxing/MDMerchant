//
//  MDTabTwoContainerViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDTabTwoContainerViewController.h"
#import "MDOrderManageViewController.h"

@interface MDTabTwoContainerViewController ()
@property (nonatomic, strong) MDSearchBar *searchBar;
@property (nonatomic, strong) UIButton *preOrderButton;
@end

@implementation MDTabTwoContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPreOrderButton];
    [self setupSearchBar];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat left = 8.5;
    _searchBar.width = _searchBar.superview.width - 2*left;
    _searchBar.left = left;
}

#pragma mark - setup
- (void)setupPreOrderButton {
    _preOrderButton = [UIButton buttonTitle:@"预订单"
                                       font:UIFontMakeS(13)
                                  textColor:[UIColor blackColor]
                                      image:nil
                                     image2:nil
                                      state:UIControlStateNormal
                                     target:self
                                     action:@selector(tapPreOrder:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_preOrderButton];
}

- (void)setupSearchBar {
    _searchBar = [MDSearchBar new];
    UIView *searchContainer = [UIView new];
    [_searchBar sizeToFit];
    searchContainer.size = _searchBar.size;
    _searchBar.placeholder = @"订单序号/订单号/手机号";
    [searchContainer addSubview:_searchBar];
    self.navigationItem.titleView = searchContainer;
}

#pragma mark - Action
- (void)tapPreOrder:(UIButton *)btn {
    
}

#pragma mark - getter
- (NSArray<UIViewController *> *)vcList {
    if (!_vcList) {
        NSMutableArray *vcList = [NSMutableArray array];
        NSArray *statusArr = @[@(MDOrderStatusProcessing),@(MDOrderStatusCompleted),@(MDOrderStatusCanceled)];
        for (NSNumber *status in statusArr) {
            MDOrderManageViewController *order = [MDOrderManageViewController new];
            order.status = [status integerValue];
            [vcList addObject:order];
        }
        _vcList = vcList;
    }
    return _vcList;
}

@end
