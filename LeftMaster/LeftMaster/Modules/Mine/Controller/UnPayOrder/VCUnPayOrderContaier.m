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
@property(nonatomic,assign)CGFloat total;
@property(nonatomic,assign)NSInteger num;
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
    requestBean.FD_PAY_STATUS = @"1";
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

- (void)clickCheck:(NSInteger)index{
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(index == idx){
            NSMutableDictionary *data = [obj mutableCopy];
            BOOL selected = [obj jk_boolForKey:@"selected"];
            [data setObject:@(!selected) forKey:@"selected"];
            [self.dataSource replaceObjectAtIndex:idx withObject:data];
        }
    }];
    [self.table reloadData];
    [self calTotal];
}

- (void)selectedALL:(BOOL)selected{
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *data = [obj mutableCopy];
        [data setObject:@(selected) forKey:@"selected"];
        [self.dataSource replaceObjectAtIndex:idx withObject:data];
    }];
    [self.table reloadData];
    [self calTotal];
}

- (void)calTotal{
    self.total = 0;
    __weak typeof(self) weakself = self;
    self.num = 0;
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL selected = [obj jk_boolForKey:@"selected"];
        if(selected){
            self.num++;
            weakself.total += [obj jk_floatForKey:@"FD_TOTAL_PRICE"];
        }
    }];
    
    [self.vControlBar updateDataPrice:self.total];
    [self.vControlBar updateCal:self.num];
}

- (void)gotoPay{
    
    NSMutableArray *paySelects = [NSMutableArray array];
    [self.dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        BOOL selected = [obj jk_boolForKey:@"selected"];
        if(selected){
            [paySelects addObject:obj];
        }
    }];
    //计算
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
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
    cell.index = indexPath.row;
    __weak typeof(self) weakself = self;
    cell.clickBlock = ^(NSInteger index) {
        [weakself clickCheck:index];
    };
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
        __weak typeof(self) weakself = self;
        _vControlBar.clickBlock = ^(NSInteger index,BOOL selected) {
            if(index == 0){
                [weakself selectedALL:selected];
            }else{
                [weakself gotoPay];
            }
        };
    }
    return _vControlBar;
}


@end
