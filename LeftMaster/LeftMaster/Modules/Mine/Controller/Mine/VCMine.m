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
#import "VCWebView.h"
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
    [self loadData:4];
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
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(![AppUser share].isBoss){
        if(section == 0 || section == 1 || section == 2 || section == 5){
            return 0;
        }
    }else if(section == 5 && ![AppUser share].isSalesman){
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
        [cell updateData:@"通知消息" with:@""];
    }else if(indexPath.section == 1){
        [cell updateData:@"个人帐户" with:@""];
    }else if(indexPath.section == 2){
        [cell updateData:@"企业帐户" with:@""];
    }else if(indexPath.section == 3){
        [cell updateData:@"订单对账" with:@""];
    }else if(indexPath.section == 4){
        [cell updateData:@"联系客服" with:@"400-1696444"];
    }else if(indexPath.section == 5){
        [cell updateData:@"当前客户" with:[AppUser share].CUS_NAME];
    }else if(indexPath.section == 6){
        [cell updateData:@"设置" with:@""];
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
    if(section == 6){
        return 60*RATIO_WIDHT320;
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
    if(indexPath.section == 0){//通知消息
        VCNotice *vc = [[VCNotice alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 1){//个人帐户
        
        VCWebView *vc = [[VCWebView alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.url = @"http://wallet.qizhangtong.com:8814/api/redirect.html?gid=5b8b8582137b2b3d6942e00c&resultCode=EXECUTE_SUCCESS&sign=c03f979b43de23a5547ddbafef01a43c&resultMessage=%E6%88%90%E5%8A%9F&requestNo=8666216224006140&userId=18090211551001600120&version=1.0&appClient=false&protocol=HTTP_FORM_JSON&success=true&service=walletRedirect&signType=MD5&merchOrderNo=0027515258167617&partnerId=18082916013301600472&operatorId=18090211551001600120";
        vc.title = @"个人帐户";
        [self.navigationController pushViewController:vc animated:YES];
        return;
//        VCUserAccount *vc = [[VCUserAccount alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 2){//企业帐户
        VCEnterpriseList *vc = [[VCEnterpriseList alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 3){//订单对账
        VCAccountContainer *vc = [[VCAccountContainer alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.section == 4){//联系客服
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-1696444"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else if(indexPath.section == 5){//当前客户
        VCProxyCustmer*vc = [[VCProxyCustmer alloc]init];
        vc.type = 1;
        vc.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController:vc animated:TRUE];
    }else if(indexPath.section == 6){//设置
        VCSetting *vc = [[VCSetting alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
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
