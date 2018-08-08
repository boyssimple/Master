//
//  VCOrderContaier.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCUnReceive.h"
#import "CellOrderList.h"
#import "VCOrder.h"
#import "ViewTabOrder.h"
#import "ViewSearchOrderList.h"
#import "RequestBeanQueryOrder.h"
#import "RequestBeanSignOrder.h"
#import "VCWriteOrderAgain.h"

@interface VCUnReceive ()<UITableViewDelegate,UITableViewDataSource,CommonDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UITableView *table;
@property(nonatomic,strong)ViewSearchOrderList *searchView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSString *orderId;
@end

@implementation VCUnReceive

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.page = 1;
    self.title = @"待签收";
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
}


- (void)loadData{
    RequestBeanQueryOrder *requestBean = [RequestBeanQueryOrder new];
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.cus_id = [AppUser share].CUS_ID;
    requestBean.page_current = self.page;
    requestBean.order_status = @"3";
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanQueryOrder *response = responseBean;
            if(response.success){
                if(self.page == 1){
                    [weakself.dataSource removeAllObjects];
                }
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                if(datas.count == 0 || datas.count < requestBean.page_size){
                    [weakself.table.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakself.table.mj_footer resetNoMoreData];
                }
                [weakself.dataSource addObjectsFromArray:datas];
                [weakself.table reloadData];
            }
        }
    }];
}

- (void)receiveAction{
    RequestBeanSignOrder *requestBean = [RequestBeanSignOrder new];
    requestBean.FD_CREATE_USER_ID = [AppUser share].SYSUSER_ID;
    requestBean.FD_ID = self.orderId;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanSignOrder *response = responseBean;
            if(response.success){
                [weakself loadData];
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellOrderList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CeCellOrderListll";
    CellOrderList *cell = (CellOrderList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellOrderList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.index = indexPath.row;
    [cell updateData:[self.dataSource objectAtIndex:indexPath.row]];
    if(indexPath.row == self.dataSource.count - 1){
        cell.vLine.hidden = YES;
    }else{
        cell.vLine.hidden = NO;
    }
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
    
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    VCOrder *vc = [[VCOrder alloc]init];
    vc.orderId = [data jk_stringForKey:@"FD_ID"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index withDataIndex:(NSInteger)dataIndex{
    NSDictionary *data = [self.dataSource objectAtIndex:dataIndex];
    self.orderId = [data jk_stringForKey:@"FD_ID"];
    if(index == 0){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定签收？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 1000;
        [alert show];
    }else if(index == 3){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定再来一单？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 1001;
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1000){
        if (buttonIndex == 0) {
            [self receiveAction];
        }
    }else if(alertView.tag == 1001){
        if (buttonIndex == 0) {
            VCWriteOrderAgain *vc = [[VCWriteOrderAgain alloc]init];
            vc.orderId = self.orderId;
            [self.navigationController pushViewController:vc animated:TRUE];
        }
    }
}

- (ViewSearchOrderList*)searchView{
    if(!_searchView){
        _searchView = [[ViewSearchOrderList alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewSearchOrderList calHeight])];
    }
    return _searchView;
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT - [ViewTabOrder calHeight]-NAV_STATUS_HEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
//        _table.tableHeaderView = self.searchView;
        
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakself.page = 1;
            [weakself loadData];
        }];
        
        _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakself.page++;
            [weakself loadData];
        }];
    }
    return _table;
}
@end
