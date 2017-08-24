//
//  MDOrderManageViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDOrderManageViewController.h"
#import "MDOrderManageTableCell.h"
#import "MDTabTwoContainerViewController.h"
#import <MJRefresh.h>

static NSString *const reuseId = @"OrderCellId";

@interface MDOrderManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) NSMutableArray *group;
@property (nonatomic, strong) MJRefreshNormalHeader *mj_header;
@end

@implementation MDOrderManageViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    MDLogFunc
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 22)];
    l.font = UIFontMakeS(10);
    l.textAlignment = NSTextAlignmentCenter;
    l.textColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    l.text = [NSString stringWithFormat:@"%@--单",self.navTitle];
    _statusLabel = l;
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = MDDefaultBgColor;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableHeaderView = l;
    [_tableView registerClass:[MDOrderManageTableCell class] forCellReuseIdentifier:reuseId];
    _tableView.mj_header = self.mj_header;
    [self.view addSubview:_tableView];
    
    extern NSString *const MDOrderListDataDidReceivedNotification;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveData:) name:MDOrderListDataDidReceivedNotification object:nil];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.group.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDOrderManageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    cell.order = _group[indexPath.row];
    cell.index = indexPath.row;
    cell.didClickExpandButton = ^{
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((MDOrder *)_group[indexPath.row]).layout.cell_height;
}

#pragma mark - Notification
- (void)didReceiveData:(NSNotification *)aNote {
    NSArray *dataArray = aNote.userInfo[@"content"];
    [self.tableView.mj_header endRefreshing];
    NSPredicate *predict = [NSPredicate predicateWithBlock:^BOOL(MDOrder *evaluatedObject, NSDictionary<NSString *,id> * bindings) {
        return evaluatedObject.status == self.status;
    }];
    self.group = [[dataArray filteredArrayUsingPredicate:predict] mutableCopy];
    [self refreshUI];
}

#pragma mark - Private
- (void)refreshUI {
    [self.tableView reloadData];
    self.statusLabel.text = [NSString stringWithFormat:@"%@%zd单",self.navTitle, _group.count];
}

#pragma mark - getter

- (NSMutableArray *)group {
    if (!_group) {
        _group = [NSMutableArray array];
    }
    return _group;
}

- (NSString *)navTitle {
    NSString *navTitle;
    switch (self.status) {
        case MDOrderStatusProcessing:
            navTitle = @"进行中";
            break;
        case MDOrderStatusCompleted:
            navTitle = @"已完成";
            break;
        case MDOrderStatusCanceled:
            navTitle = @"已取消";
            break;
    }
    return navTitle;
}

- (MJRefreshNormalHeader *)mj_header {
    if (!_mj_header) {
        MDWS
        _mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [(MDTabTwoContainerViewController *)wself.parentViewController performSelectorOnMainThread:NSSelectorFromString(@"makeData") withObject:nil waitUntilDone:YES];
        }];
    }
    return _mj_header;
}

@end
