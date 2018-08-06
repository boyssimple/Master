//
//  VCProxyCustmer.m
//  LeftMaster
//
//  Created by simple on 2018/4/23.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCProxyCustmer.h"
#import "CellProxy.h"
#import "ViewSearchProxy.h"
#import "VCMain.h"
#import "AppDelegate.h"
#import "RequestBeanCustomer.h"
#import "VCLogin.h"

@interface VCProxyCustmer ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewSearchProxy *vSearch;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,assign)BOOL selected;
@property(nonatomic,strong)NSString *cusId;
@end

@implementation VCProxyCustmer

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.title = @"选择客户";
    self.page = 1;
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmAction)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    if (self.type != 1) {
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
}

- (void)cancelAction{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    VCLogin *vc = [[VCLogin alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [appDelegate restoreRootViewController:nav];
}

- (void)confirmAction{
    if(self.selected && [AppUser share].CUS_ID){
        //存储已选数据到沙盒
        NSData *data = [Utils getUserInfo];
        if(data){
            NSError *error;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if(!error){
                NSMutableDictionary *mutDic = [dictionary mutableCopy];
                [mutDic setObject:[AppUser share].CUS_ID forKey:@"CUS_ID"];
                [mutDic setObject:[AppUser share].CUS_NAME forKey:@"CUS_NAME"];
                [mutDic setObject:[AppUser share].SYSUSER_COMPANYID forKey:@"SYSUSER_COMPANYID"];
                [Utils saveUserInfo:mutDic];
                [self postNotification:REFRESH_MINE_INFO withObject:nil];
                [self postNotification:REFRESH_ALL_INFO withObject:nil];
                
            }
        }
        if (self.type == 1) {
            [self.navigationController popViewControllerAnimated:TRUE];
        }else{
            [self gotoHome];
        }
        
    }else{
        [Utils showToast:@"请选择客户" with:self.view withTime:0.8];
    }
}


- (void)gotoHome{
    VCMain *vc = [[VCMain alloc]init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate restoreRootViewController:vc];
}

- (void)loadData{
    RequestBeanCustomer *requestBean = [RequestBeanCustomer new];
    requestBean.user_login_name = [AppUser share].SYSUSER_ACCOUNT;
    if(self.keywords && self.keywords.length > 0){
        requestBean.customer_name = self.keywords;
    }else{
        requestBean.customer_name = nil;
    }
    requestBean.page_current = self.page;
    requestBean.page_size = 30;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanCustomer *response = responseBean;
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


- (void)search{
    self.keywords = self.vSearch.tfText.text;
    [self loadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellProxy calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"Cell";
    CellProxy *cell = (CellProxy*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellProxy alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    if(self.cusId && [self.cusId isEqualToString:[data jk_stringForKey:@"customer_id"]]){
        cell.isSelected = TRUE;
    }else{
        cell.isSelected = FALSE;
    }
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
    [AppUser share].CUS_ID = [data jk_stringForKey:@"customer_id"];
    [AppUser share].CUS_NAME = [data jk_stringForKey:@"customer_name"];
    [AppUser share].SYSUSER_COMPANYID = [data jk_stringForKey:@"fd_company_id"];
    self.cusId = [data jk_stringForKey:@"customer_id"];
    self.selected = TRUE;
    [self.table reloadData];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self search];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.vSearch;
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

- (ViewSearchProxy*)vSearch{
    if(!_vSearch){
        _vSearch = [[ViewSearchProxy alloc]initWithFrame:CGRectMake(0, 0, 0, [ViewSearchProxy calHeight])];
        _vSearch.tfText.delegate = self;
    }
    return _vSearch;
}

@end
