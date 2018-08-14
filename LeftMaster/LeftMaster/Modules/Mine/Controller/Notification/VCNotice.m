//
//  VCNotice.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCNotice.h"
#import "CellNotice.h"
#import "VCNoticeList.h"
#import "RequestBeanNotice.h"

@interface VCNotice ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property (nonatomic, assign) NSInteger sysCount;
@property (nonatomic, assign) NSInteger orderCount;
@property (nonatomic, assign) NSInteger orderCount2;
@end

@implementation VCNotice

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.title = @"通知消息";
    [self.view addSubview:self.table];
}

- (void)loadData{
    [self loadData:1];
    [self loadData:2];
    [self loadData:3];
    
}

- (void)loadData:(NSInteger)type{
    RequestBeanNotice *requestBean = [RequestBeanNotice new];
    requestBean.message_type = type;
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.page_current = 1;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanNotice *response = responseBean;
            if(response.success){
                if(requestBean.message_type == 1){
                    weakself.orderCount = [response.data jk_integerForKey:@"count_num"];
                }else if(requestBean.message_type == 2){
                    weakself.sysCount = [response.data jk_integerForKey:@"count_num"];
                }else if(requestBean.message_type == 3){
                    weakself.orderCount2 = [response.data jk_integerForKey:@"count_num"];
                }
                [weakself.table reloadData];
            }
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellNotice calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellNotice";
    CellNotice *cell = (CellNotice*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellNotice alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.row == 0){
        [cell updateData:@"icon_1" withTitle:@"订单消息" withCount:self.orderCount];
    }else if(indexPath.row == 1){
        [cell updateData:@"icon_2" withTitle:@"系统公告" withCount:self.sysCount];
    }else if(indexPath.row == 2){
        [cell updateData:@"icon_3" withTitle:@"促销提醒" withCount:self.orderCount2];
    }
    [cell updateData];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
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
    VCNoticeList *vc = [[VCNoticeList alloc]init];
    vc.type = indexPath.row+1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = APP_Gray_COLOR;
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadData];
        }];
    }
    return _table;
}

@end
