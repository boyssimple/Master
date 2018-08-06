//
//  VCOrder.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCOrder.h"
#import "ViewSectionOrder.h"
#import "CellOrderInfo.h"
#import "CellOrderRemark.h"
#import "VCOrderGoodsList.h"
#import "VCInvoice.h"
#import "RequestBeanOrderInfo.h"

@interface VCOrder ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSDictionary *data;
@end

@implementation VCOrder

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.title = @"订单详情";
    [self.view addSubview:self.table];
}

- (void)loadData{
    RequestBeanOrderInfo *requestBean = [RequestBeanOrderInfo new];
    requestBean.FD_ORDER_ID = self.orderId;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanOrderInfo *response = responseBean;
            if(response.success){
                weakself.data = response.data;
                [weakself.table reloadData];
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == 3){
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return [CellOrderInfo calHeight:self.data];
    }
    if(!self.data){
        return 0;
    }else{
        return [CellOrderRemark calHeight:[self.data jk_stringForKey:@"FD_DESC"]];
        
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString*identifier = @"CellOrderInfo";
        CellOrderInfo *cell = (CellOrderInfo*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CellOrderInfo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        [cell updateData:self.data];
        return cell;
    }else{
        
        static NSString*identifier = @"CellOrderRemark";
        CellOrderRemark *cell = (CellOrderRemark*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CellOrderRemark alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if(self.data){
            [cell updateData:[self.data jk_stringForKey:@"FD_DESC"]];
            
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36*RATIO_WIDHT320;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ViewSectionOrder *header = (ViewSectionOrder*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[ViewSectionOrder alloc]init];
    }
    if(section == 0){
        [header updateDataIcon:@"order_order" withName:@"订单信息" withHiddenArrow:YES];
        
    }else if(section == 1){
        [header updateDataIcon:@"order_list" withName:@"商品清单" withHiddenArrow:NO];
        __weak typeof(self) weakself = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            VCOrderGoodsList *vc = [[VCOrderGoodsList alloc]init];
            vc.orderId = weakself.orderId;
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
        [header addGestureRecognizer:tap];
    }else if(section == 2){
        [header updateDataIcon:@"order_record" withName:@"发货记录" withHiddenArrow:NO];
        __weak typeof(self) weakself = self;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            VCInvoice *vc = [[VCInvoice alloc]init];
            vc.orderId = weakself.orderId;
            vc.status = [weakself.data jk_integerForKey:@"FD_ORDER_STATUS"];
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
        [header addGestureRecognizer:tap];
    }else if(section == 3){
        [header updateDataIcon:@"order_remark" withName:@"备注" withHiddenArrow:YES];
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

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = APP_Gray_COLOR;
    }
    return _table;
}

@end
