//
//  VCOrderContaier.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCUnPayOrderContaier.h"
#import "CellUnPayOrderContainer.h"
#import "ViewBarUnPayOrder.h"
#import "RequestBeanCreditOrder.h"

@interface VCUnPayOrderContaier ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)ViewBarUnPayOrder *vControlBar;
@end

@implementation VCUnPayOrderContaier

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    [self.view addSubview:self.vControlBar];
}


- (void)loadData{
    RequestBeanCreditOrder *requestBean = [RequestBeanCreditOrder new];
//    requestBean.FD_PAY_STATUS = [AppUser share].SYSUSER_ID;
    requestBean.cus_id = [AppUser share].CUS_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanCreditOrder *response = responseBean;
            if(response.success){
                [weakself.dataSource removeAllObjects];
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                [weakself.dataSource addObjectsFromArray:datas];
                [weakself.table reloadData];
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;//self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellUnPayOrderContainer calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellUnPayOrderContainer";
    CellUnPayOrderContainer *cell = (CellUnPayOrderContainer*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellUnPayOrderContainer alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell updateData:[self.dataSource objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[UIView alloc]init];
    }
    return header;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
    if (!footer) {
        footer = [[UIView alloc]init];
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index withDataIndex:(NSInteger)dataIndex{
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT - 40*RATIO_WIDHT750 - NAV_STATUS_HEIGHT - [ViewBarUnPayOrder calHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = APP_Gray_COLOR;
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadData];
        }];
        
    }
    return _table;
}

- (ViewBarUnPayOrder*)vControlBar{
    if(!_vControlBar){
        _vControlBar = [[ViewBarUnPayOrder alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewBarUnPayOrder calHeight] - NAV_STATUS_HEIGHT - 40*RATIO_WIDHT750, DEVICEWIDTH, [ViewBarUnPayOrder calHeight])];
        [_vControlBar updateData];
    }
    return _vControlBar;
}


@end
