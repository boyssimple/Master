//
//  VCNotice.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCNoticeList.h"
#import "CellNoticeList.h"
#import "VCNoticeDetail.h"
#import "RequestBeanNoticeList.h"
#import "VCOrder.h"

@interface VCNoticeList ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation VCNoticeList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.page = 1;
    self.dataSource = [NSMutableArray array];
    self.title = @"系统消息";
    [self.view addSubview:self.table];
}

- (void)loadData{
    RequestBeanNoticeList *requestBean = [RequestBeanNoticeList new];
    requestBean.page_current = self.page;
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.page_size = 10;
    requestBean.message_type = self.type;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanNoticeList *response = responseBean;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellNoticeList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellNoticeList";
    CellNoticeList *cell = (CellNoticeList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellNoticeList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateData:data];
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
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    if (self.type == 1) {
        VCOrder *vc = [[VCOrder alloc]init];
        vc.orderId = [data jk_stringForKey:@"FD_ORDER_ID"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(self.type == 2 || self.type == 3){
        
        VCNoticeDetail *vc = [[VCNoticeDetail alloc]init];
        vc.content = [data jk_stringForKey:@"FD_CONTENT"];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
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

