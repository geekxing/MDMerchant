//
//  MDTabTwoContainerViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDTabTwoContainerViewController.h"
#import "MDOrderManageViewController.h"

NSString *const MDOrderListDataDidReceivedNotification = @"MDOrderListDataDidReceivedNotification";

@interface MDTabTwoContainerViewController ()
@property (nonatomic, strong) MDSearchBar *searchBar;
@property (nonatomic, strong) UIButton *preOrderButton;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation MDTabTwoContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPreOrderButton];
    [self setupSearchBar];
    [self makeData];
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

- (void)makeData {
    [[MDNetworkTool shared].tasks makeObjectsPerformSelector:@selector(cancel)];
    MDWS
    [MDNetworkTool postWithParams:@{Param_Id:@"18261536730"} url:@"order_list_get_2/" successCode:200 completeHanlder:^(id response, NSError *err) {
        if (!err) {
            MDLog(@"%@",response);
            wself.dataArray = [MDOrder mj_objectArrayWithKeyValuesArray:response[RQCONTENT]];
            [wself.dataArray makeObjectsPerformSelector:@selector(calcModelAndLayout)];
        } else {
            if (err.code == NSURLErrorCancelled) { /*取消了任务*/ }
            else [SVProgressHUD showErrorWithStatus:err.localizedDescription];
        }
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:wself.dataArray,@"content",err,@"err", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:MDOrderListDataDidReceivedNotification object:nil userInfo:userInfo];
    }];
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
