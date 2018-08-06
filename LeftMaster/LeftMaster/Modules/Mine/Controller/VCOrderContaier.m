//
//  VCOrderContaier.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCOrderContaier.h"
#import "CellOrderList.h"
#import "VCOrder.h"
#import "ViewTabOrder.h"
#import "ViewSearchOrderList.h"
#import "RequestBeanQueryOrder.h"
#import "RequestBeanConfirmOrder.h"
#import "RequestBeanCancelOrder.h"
#import "WindowCancelOrder.h"
#import "RequestBeanSignOrder.h"
#import "VCWriteOrderAgain.h"

@interface VCOrderContaier ()<UITableViewDelegate,UITableViewDataSource,CommonDelegate,UIAlertViewDelegate,WindowCancelOrderDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *table;
@property(nonatomic,strong)ViewSearchOrderList *searchView;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *keywords;
@end

@implementation VCOrderContaier

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.page = 1;
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
}


- (void)loadData{
    RequestBeanQueryOrder *requestBean = [RequestBeanQueryOrder new];
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.cus_id = [AppUser share].CUS_ID;
    requestBean.page_current = self.page;
    if (self.keywords) {
        requestBean.search_key = self.keywords;
    }
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


- (void)confirmAction{
    RequestBeanConfirmOrder *requestBean = [RequestBeanConfirmOrder new];
    requestBean.FD_CREATE_USER_ID = [AppUser share].SYSUSER_ID;
    requestBean.FD_ID = self.orderId;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanConfirmOrder *response = responseBean;
            if(response.success){
                [weakself loadData];
            }
        }
    }];
}

- (void)searchData{
    if (self.keywords.length > 0) {
        [self loadData];
    }
}

- (void)changeText:(UITextField*)textField{
    self.keywords  = textField.text;
}

#pragma mark - WindowCancelOrderDelegate
- (void)selectReason:(NSString *)reason{
    RequestBeanCancelOrder *requestBean = [RequestBeanCancelOrder new];
    requestBean.FD_CANEL_USER_ID = [AppUser share].SYSUSER_ID;
    requestBean.FD_ID = self.orderId;
    requestBean.FD_CANEL_REASON = reason;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanConfirmOrder *response = responseBean;
            if(response.success){
                [weakself loadData];
                [Utils showSuccessToast:@"取消成功" with:weakself.view withTime:0.8];
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
    }else if(index == 1){
        WindowCancelOrder *windowCancel = [[WindowCancelOrder alloc]init];
        windowCancel.delegate = self;
        [windowCancel show];
    }else if(index == 2){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定提交审核？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 1002;
        [alert show];
    }else if(index == 3){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定再来一单？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alert.tag = 1003;
        [alert show];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger tag = alertView.tag;
    if(tag == 1000){
        if(buttonIndex == 0){
            [self receiveAction];
        }
    }else if(tag == 1001){
        
        if(buttonIndex == 0){
            
        }else{
            
        }
    }else if(tag == 1002){
        
        if(buttonIndex == 0){
            [self confirmAction];
        }
    }else if(tag == 1003){
        
        if(buttonIndex == 0){
            VCWriteOrderAgain *vc = [[VCWriteOrderAgain alloc]init];
            vc.orderId = self.orderId;
            [self.navigationController pushViewController:vc animated:TRUE];
        }
    }
    
    //    if (buttonIndex == 0) {
//        [Utils showHanding:@"处理中..." with:self.view];
//        [Utils hiddenHanding:self.view withTime:2];
//    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [self searchData];
    return TRUE;
}

- (ViewSearchOrderList*)searchView{
    if(!_searchView){
        _searchView = [[ViewSearchOrderList alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewSearchOrderList calHeight])];
        _searchView.tfText.placeholder = @"客户名称、订单编号";
        _searchView.tfText.returnKeyType = UIReturnKeySearch;
        _searchView.tfText.delegate = self;
        [_searchView.tfText addTarget:self action:@selector(changeText:) forControlEvents:UIControlEventEditingChanged];
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
        _table.tableHeaderView = self.searchView;
        
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
