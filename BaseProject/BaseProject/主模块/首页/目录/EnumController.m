//
//  EnumController.m
//  BaseProject
//
//  Created by 曹老师 on 2019/2/26.
//  Copyright © 2019 众利创投. All rights reserved.
//

#import "EnumController.h"
#import "ShowController.h"
#import "EnumCell.h"
#import "CoinModel.h"

@interface EnumController () <UITableViewDelegate, UITableViewDataSource> {
    
    NSMutableArray *dataArray;   // 数据列表
    NSInteger currentPage;
    
}

@property (strong, nonatomic) UITableView *listTableView;

@end

@implementation EnumController

#pragma mark ========================================生命周期========================================
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"目录";
    self.view.backgroundColor = WhiteColor;
    dataArray = [NSMutableArray array];
    // 创建视图
    [self creatSubViewsAction];
    
    
    
}


#pragma mark ========================================私有方法=============================================

#pragma mark - 创建视图
- (void)creatSubViewsAction {
    
    // 表视图
    _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - Nav_Height)
                                                  style:UITableViewStylePlain];
    //    _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _listTableView.backgroundColor = [UIColor clearColor];
    _listTableView.rowHeight = 40;
    _listTableView.estimatedRowHeight = 0;
    _listTableView.estimatedSectionFooterHeight = 0;
    _listTableView.estimatedSectionHeaderHeight = 0;
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [_listTableView registerNib:[UINib nibWithNibName:@"EnumCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"EnumCell"];
    [self.view addSubview:_listTableView];
    
    if(@available(iOS 11.0, *)){
        _listTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    __weak typeof(self) weakSelf = self;
    _listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakSelf loadListAction:NO];
        
    }];
    
    
    _listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf loadListAction:YES];
        
        
    }];
    
    [self loadListAction:NO];
    
}

#pragma mark ========================================动作响应=============================================


#pragma mark ========================================网络请求=============================================

#pragma mark - 获取列表
- (void)loadListAction:(BOOL)isfooter {
    
    if (isfooter) {
        currentPage ++;
    } else {
        currentPage = 1;
        [dataArray removeAllObjects];
    }
    
    [NetTool loadCoinEnumList:currentPage List:^(id  _Nonnull object) {
        
    
        
        
        NSArray *list = object;
        [dataArray addObjectsFromArray:list];
        
        // 是否加载完比
        if (list.count >= 20) {
            [_listTableView.mj_footer endRefreshing];
        } else {
            [_listTableView.mj_footer endRefreshingWithNoMoreData];
        }
        [_listTableView.mj_header endRefreshing];
        
        // 暂无数据
        [CYC666 setReloadAndNoDataView:_listTableView list:dataArray];
        
        // 刷新
        [_listTableView reloadData];
        
    }];
    
}


#pragma mark ========================================代理方法=============================================

#pragma mark - 表视图代理方法


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return dataArray.count;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EnumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EnumCell"
                                                        forIndexPath:indexPath];
    
    if (indexPath.row < dataArray.count) {
        cell.model = dataArray[indexPath.row];
        
        cell.indexLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row < dataArray.count) {
        CoinModel *model = dataArray[indexPath.row];
        
        ShowController *ctrl = [[ShowController alloc] init];
        ctrl.model = model;
        ctrl.title = model.fullname;
        [self.navigationController pushViewController:ctrl animated:YES];
        
    }
    
    
    
}


#pragma mark ========================================通知================================================

@end
