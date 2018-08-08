//
//  VCUnConfirmList.m
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCUnConfirmList.h"
#import "CellAccountList.h"
#import "ViewTabAccount.h"
#import "RequestBeanBillList.h"
#import "VCAccountDetailContainer.h"
#import "RequestBeanConfirmBill.h"
#import "AppDelegate.h"

@interface VCUnConfirmList ()<UITableViewDelegate,UITableViewDataSource,CellAccountListDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)NSInteger pageSize;
@property(nonatomic,strong)NSString *billNo;
@end

@implementation VCUnConfirmList

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.pageSize = 10;
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:REFRESH_BILL_INFO object:nil];
}

- (void)refreshData{
    self.page = 1;
    [self loadData];
}

- (void)loadData{
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    RequestBeanBillList *requestBean = [RequestBeanBillList new];
    requestBean.cus_id = [AppUser share].CUS_ID;
    requestBean.page_current = self.page;
    requestBean.page_size = self.pageSize;
    if(delegate.month){
        requestBean.ym = delegate.month;
    }
    requestBean.bill_status = 0;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanBillList *response = responseBean;
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


- (void)confirmBill{
    RequestBeanConfirmBill *requestBean = [RequestBeanConfirmBill new];
    requestBean.ca_bill_id = self.billNo;
    requestBean.billstatus = 1;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            ResponseBeanBillList *response = responseBean;
            if(response.success){
                weakself.page = 1;
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
    return [CellAccountList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellAccountList";
    CellAccountList *cell = (CellAccountList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellAccountList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.index = indexPath.row;
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateData:data];
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
    VCAccountDetailContainer *vc = [[VCAccountDetailContainer alloc]init];
    vc.billNo = [data jk_stringForKey:@"FD_ID"];
    [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark - CellAccountListDelegate
- (void)confirmBill:(NSInteger)index{
    NSDictionary *data = [self.dataSource objectAtIndex:index];
    self.billNo = [data jk_stringForKey:@"FD_ID"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"对帐单是否确认？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [self confirmBill];
    }
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT - [ViewTabAccount calHeight]-NAV_STATUS_HEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
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
