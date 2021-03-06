//
//  VCMine.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCMine.h"
#import "ViewHeaderMine.h"
#import "CellMine.h"
#import "VCNotice.h"
#import "VCOrderCheckAccount.h"
#import "ViewWithExit.h"
#import "VCSetting.h"
#import "RequestBeanOrderNum.h"
#import "VCProxyCustmer.h"
#import "VCAccountContainer.h"
#import "RequestBeanGetCredit.h"
#import "VCUserInfo.h"
#import "VCUserAccount.h"
#import "VCEnterpriseList.h"
#import "RequestBeanGetUserInfo.h"

@interface VCMine ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,CommonDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewHeaderMine *header;
@property(nonatomic,strong)ViewWithExit *footer;
@end

@implementation VCMine

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    [self.view addSubview:self.table];
    [self observeNotification:REFRESH_MINE_INFO];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]initWithTitle:@"通知" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    leftButton.tintColor = [UIColor blackColor];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    rightButton.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)leftButtonClick{
    VCNotice *vc = [[VCNotice alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightButtonClick{
    
    VCSetting *vc = [[VCSetting alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadOrderNum];
    [self loadCustomerCredit];
    [self loadInfoData];
}

- (void)viewWillDisappear:(BOOL)animated{
}


- (void)loadData{
    [self loadOrderNum];
    [self.table reloadData];
    int64_t delayInSeconds = 0.6;
    __weak typeof(self) weakself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakself.table.mj_header endRefreshing];
    });
    [self loadCustomerCredit];
}

- (void)loadInfoData{
    
    RequestBeanGetUserInfo *requestBean = [RequestBeanGetUserInfo new];
    requestBean.SYSUSER_ID = [AppUser share].SYSUSER_ID;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanGetUserInfo *response = responseBean;
            if(response.success){
                [weakself.header updateData:response.data];
            }
        }
    }];
}

- (void)handleNotification:(NSNotification *)notification{
    [self loadData];
}


- (void)loadOrderNum{
    [self loadData:0];
    [self loadData:1];
    [self loadData:2];
    [self loadData:3];
    [self loadData:10];
}

- (void)loadData:(NSInteger)type{
    RequestBeanOrderNum *requestBean = [RequestBeanOrderNum new];
    requestBean.order_status = type;
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanOrderNum *response = responseBean;
            if(response.success){
                [weakself.header updateData:type withCount:response.num];
            }
        }
    }];
}


- (void)loadCustomerCredit{
    RequestBeanGetCredit *requestBean = [RequestBeanGetCredit new];
    requestBean.cus_id = [AppUser share].CUS_ID;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanGetCredit *response = responseBean;
            if(response.success){
                [weakself.header updateDataCredit:response.data];
            }
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(![AppUser share].isBoss){
        if(section == 0 || section == 1){
            return 0;
        }
    }
    if(section == 4 && ![AppUser share].isSalesman){
        return 0;
    }
        
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellMine calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellMine";
    CellMine *cell = (CellMine*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellMine alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.section == 0){
        [cell updateData:@"个人帐户" with:@""];
    }else if(indexPath.section == 1){
        [cell updateData:@"企业帐户" with:@""];
    }else if(indexPath.section == 2){
        [cell updateData:@"订单对账" with:@""];
    }else if(indexPath.section == 3){
        [cell updateData:@"联系客服" with:@"400-1696444"];
    }else if(indexPath.section == 4){
        [cell updateData:@"当前客户" with:[AppUser share].CUS_NAME];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 8.f*RATIO_WIDHT320;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 4){
        return 30*RATIO_WIDHT320;
    }
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
    if(indexPath.section == 0){//个人帐户
        
        VCUserAccount *vc = [[VCUserAccount alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        if([AppUser share].eaUserId_person && [AppUser share].eaUserId_person.length > 0){
            vc.isRegister = TRUE;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 1){//企业帐户
        if([AppUser share].eaUserId_corp && [AppUser share].eaUserId_corp.length > 0){
            VCEnterpriseList *vc = [[VCEnterpriseList alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您未开通企业账户!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 1000;
            [alert show];
        }
    }else if(indexPath.section == 2){//订单对账
        VCAccountContainer *vc = [[VCAccountContainer alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 3){//联系客服
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-1696444"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if(indexPath.section == 4){//当前客户
        VCProxyCustmer*vc = [[VCProxyCustmer alloc]init];
        vc.type = 1;
        vc.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController:vc animated:TRUE];
    }
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if (index == 0) {
        
        
        VCUserInfo *vc = [[VCUserInfo alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
//        [self showModifyAvatar];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1000){
        
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
        _table.tableHeaderView = self.header;
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadData];
            [weakself loadCustomerCredit];
            [weakself loadInfoData];
        }];
    }
    return _table;
}


- (ViewHeaderMine*)header{
    if(!_header){
        _header = [[ViewHeaderMine alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewHeaderMine calHeight])];
        _header.delegate = self;
        [_header updateData];
    }
    return _header;
}

@end
