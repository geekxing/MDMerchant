//
//  MDOrderManageViewController.m
//  MDMerchant
//
//  Created by apple on 2017/8/12.
//  Copyright © 2017年 Wuxi Kaishang Internet. All rights reserved.
//

#import "MDOrderManageViewController.h"

@interface MDOrderManageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) NSMutableArray *group;
@end

@implementation MDOrderManageViewController

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
    [self.view addSubview:_tableView];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
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

@end
