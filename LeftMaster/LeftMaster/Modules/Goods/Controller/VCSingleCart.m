//
//  VCCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCSingleCart.h"
#import "CellCart.h"
#import "ViewTotalCart.h"
#import "VCWriteOrder.h"
#import "VCWriteOrder.h"
#import "RequestBeanCartList.h"
#import "VCGoods.h"
#import "CartGoods.h"
#import "RequestBeanDelCart.h"
#import "RequestBeanAddCart.h"

@interface VCSingleCart ()<UITableViewDelegate,UITableViewDataSource,ViewTotalCartDelegate,CommonDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewTotalCart *vControl;
@property(nonatomic,strong)NSMutableArray *goodsList;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *carId;
@property (nonatomic, assign) NSInteger delIndex;
@end

@implementation VCSingleCart

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.title = @"购物车";
    self.page = 1;
    _goodsList = [NSMutableArray array];
    [self.view addSubview:self.table];
    [self.view addSubview:self.vControl];
    
    //加入购物车通知
    [self observeNotification:REFRESH_CART_LIST];
    
    
    //    [self postNotification:REFRESH_CART_LIST withObject:nil];
}

- (void)handleNotification:(NSNotification *)notification{
    [self refreshData];
}

- (void)refreshData{
    RequestBeanCartList *requestBean = [RequestBeanCartList new];
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.page_current = self.page;
    requestBean.CUS_ID = [AppUser share].CUS_ID;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanCartList *response = responseBean;
            if(response.success){
                [weakself handleDatas:[response.data jk_arrayForKey:@"rows"] with:requestBean.page_size];
            }
        }
    }];
}

- (void)loadData{
    RequestBeanCartList *requestBean = [RequestBeanCartList new];
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.page_current = self.page;
    requestBean.CUS_ID = [AppUser share].CUS_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanCartList *response = responseBean;
            if(response.success){
                [weakself handleDatas:[response.data jk_arrayForKey:@"rows"] with:requestBean.page_size];
            }
        }
    }];
}

- (void)delAction{
    
    
    RequestBeanDelCart *requestBean = [RequestBeanDelCart new];
    requestBean.car_id = self.carId;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        
        ResponseBeanDelCart *response = responseBean;
        if (!err) {
            // 结果处理
            if(response.success){
                [weakself.goodsList removeObjectAtIndex:weakself.delIndex];
                [weakself calTotal];
                [weakself.table reloadData];
            }else{
                [Utils showSuccessToast:response.msg with:weakself.view withTime:0.8];
                
            }
        }else{
            [Utils showSuccessToast:response.msg with:weakself.view withTime:0.8];
        }
    }];
    
}


- (void)addCart:(CartGoods*)data withAmount:(NSInteger)num{
    RequestBeanAddCart *requestBean = [RequestBeanAddCart new];
    requestBean.goods_id = data.GOODS_ID;
    requestBean.num = num;
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        
        if (!err) {
            // 结果处理
            ResponseBeanAddCart *response = responseBean;
            if (response.success) {
                [self postNotification:REFRESH_CART_LIST withObject:nil];
                [Utils showSuccessToast:@"加入购物车成功" with:weakself.view withTime:1];
            }else{
                [Utils showSuccessToast:@"加入购物车失败" with:weakself.view withTime:1];
            }
        }else{
            [Utils showSuccessToast:@"加入购物车失败" with:weakself.view withTime:1];
        }
    }];
}

- (void)handleDatas:(NSArray*)datas with:(NSInteger)size{
    if(self.page == 1){
        [self.goodsList removeAllObjects];
    }
    if(datas.count == 0 || datas.count < size){
        [self.table.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.table.mj_footer resetNoMoreData];
    }
    
    for (NSDictionary *data in datas) {
        CartGoods *cart = [[CartGoods alloc]init];
        [cart parse:data];
        [self.goodsList addObject:cart];
    }
    [self.table reloadData];
    [self calTotal];
}

- (void)calTotal{
    NSInteger num = 0;
    CGFloat total = 0;
    for (CartGoods *c in self.goodsList) {
        if(c.selected){
            num += c.FD_NUM;
            total += c.GOODS_PRICE*c.FD_NUM;
        }
    }
    [self.vControl updateData:num withPrice:total];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellCart calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellCart";
    CellCart *cell = (CellCart*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellCart alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.index = indexPath.row;
    CartGoods *data = [self.goodsList objectAtIndex:indexPath.row];
    [cell updateData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return 0.00001f;
    }
    return 10.f;
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
        footer.backgroundColor = APP_Gray_COLOR;
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CartGoods *data = [self.goodsList objectAtIndex:indexPath.row];
    VCGoods *vc = [[VCGoods alloc]init];
    vc.goods_id = data.GOODS_ID;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ViewTotalCartDelegate
- (void)clickOrder{
    NSMutableArray *selects = [NSMutableArray array];
    NSInteger num = 0;
    for (CartGoods *c in self.goodsList) {
        if(c.selected){
            num += c.FD_NUM;
            [selects addObject:c];
        }
    }
    if(num > 0){
        VCWriteOrder *vc = [[VCWriteOrder alloc]init];
        vc.goodsList = selects;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [Utils showSuccessToast:@"请选择商品" with:self.view withTime:0.8];
    }
}

- (void)clickCheck:(BOOL)selected{
    for (CartGoods *c in self.goodsList) {
        c.selected = selected;
    }
    [self.table reloadData];
    [self calTotal];
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index withDataIndex:(NSInteger)dataIndex{
    if (index == 0) {
        CartGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.selected = !data.selected;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self calTotal];
    }else if(index == 1){
        self.delIndex = dataIndex;
        CartGoods *data = [self.goodsList objectAtIndex:dataIndex];
        self.carId = data.FD_ID;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }else if(index == 2){
        //减数量request
        CartGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.FD_NUM -= 1;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self calTotal];
    }else{
        //加数量request
        CartGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.FD_NUM += 1;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self calTotal];
    }
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self delAction];
    }
}


- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-[ViewTotalCart calHeight]) style:UITableViewStyleGrouped];
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

- (ViewTotalCart*)vControl{
    if(!_vControl){
        _vControl = [[ViewTotalCart alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewTotalCart calHeight], DEVICEWIDTH, [ViewTotalCart calHeight])];
        [_vControl updateData];
        _vControl.delegate = self;
    }
    return _vControl;
}

@end
