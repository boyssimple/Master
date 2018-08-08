//
//  VCHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCHome.h"
#import "VCOrder.h"
#import "SectionHeaderHome.h"
#import "CellCategoryHome.h"
#import "CellNewHome.h"
#import <SDCycleScrollView.h>
#import "RequestBeanCategoryHome.h"
#import "RequestBeanGoodsList.h"
#import "VCCategory.h"
#import "VCRecGoodsList.h"
#import "RequestBeanCarouseList.h"
#import "ViewSearchWithHome.h"
#import "VCModifyPassword.h"
#import "RequestBeanQueryCartNum.h"
#import "HMScannerController.h"
#import "RequestBeanNewGoods.h"
#import "VCGoods.h"
#import "RequestBeanVision.h"
#import "LaunchAdsManager.h"
#import "VCSearchList.h"

@interface VCHome ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,SectionHeaderHomeDelegate,UIScrollViewDelegate,
        UIAlertViewDelegate,CommonDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)NSMutableArray *categorys;
@property(nonatomic,strong)NSMutableArray *goodsList;
@property(nonatomic,strong)ViewSearchWithHome *vCart;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSString *downUrl;
@end

@implementation VCHome

- (void)viewDidLoad {
    [super viewDidLoad];
    [[LaunchAdsManager shareManager] setupLaunchAd:^{
        NSLog(@"检查版本");
        [self getVision];
    }];
    
    [self initMain];
    [self loadCarouseListData];
    [self loadData];
    [self loadGoodsListData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showOrderAction:)
                                                 name:@"OPEN_ORDER_LIST"
                                               object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshAll)
                                                 name:REFRESH_ALL_INFO
                                               object:nil];
}

- (void)refreshAll{
    
    self.page = 1;
    [self loadCarouseListData];
    [self loadData];
    [self loadGoodsListData];
}

- (void)getVision{
    __weak typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf delayMethod];
    });
}

- (void)delayMethod{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    NSLog(@"版本:%@",app_Version);
    
    RequestBeanVision *request = [[RequestBeanVision alloc]init];
    request.APP_TYPE = 1;
    __weak typeof(self) weakself = self;
    [NetworkManager requestWithBean:request callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanVision *response = responseBean;
            NSString *version = [response.data jk_stringForKey:@"APP_VER"];
            BOOL result = [version compare:app_Version] == NSOrderedDescending;
            if(result){
                
                weakself.downUrl = [response.data jk_stringForKey:@"APP_LINK_PATH"];
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"发现版本 %@",[response.data jk_stringForKey:@"APP_VER"]] message:[response.data jk_stringForKey:@"APP_DESC"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往下载", nil];
                alert.tag = 102;
                [alert show];
            }
        }
    }];
}

- (void)showOrderAction:(NSNotification*)notification{
    NSString *orderId = notification.object;
    if (orderId) {
        
        VCOrder *vc = [[VCOrder alloc]init];
        vc.hidesBottomBarWhenPushed = TRUE;
        vc.orderId = orderId;
        [self.navigationController pushViewController:vc animated:TRUE];
    }
}

- (void)initMain{
    self.page = 1;
    [self.view addSubview:self.table];
    _categorys = [NSMutableArray array];
    _goodsList = [NSMutableArray array];

    //修改初始密码
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *isModify = [defaults objectForKey:USER_MODIFY_PWD];
    if(isModify){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"密码过于简单，请修改密码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar addSubview:self.vCart];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.vCart removeFromSuperview];
}

- (void)loadData{
    RequestBeanCategoryHome *requestBean = [RequestBeanCategoryHome new];
    requestBean.parent_id = 0;
    requestBean.page_current = 1;
    requestBean.page_size = 8;
    __weak typeof(self) weakself = self;
    
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [weakself.table.mj_footer endRefreshing];
        [weakself.table.mj_header endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanCategoryHome *response = responseBean;
            [weakself.categorys removeAllObjects];
            [weakself.categorys addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
            [weakself.table reloadData];
        }
    }];
}

- (void)loadCarouseListData{
    RequestBeanCarouseList *requestBean = [RequestBeanCarouseList new];
    requestBean.page_current = 1;
    requestBean.page_size = 5;
    __weak typeof(self) weakself = self;
    
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanCarouseList *response = responseBean;
            if (response.success) {
                if (response.data) {
                    NSArray *rows = [response.data jk_arrayForKey:@"rows"];
                    if (rows) {
                        NSInteger i = [response.data jk_integerForKey:@"records"];
                        NSMutableArray *images = [NSMutableArray arrayWithCapacity:i];
                        for (NSDictionary *data in rows) {
                            [images addObject:[data jk_stringForKey:@"FILE_PATH"]];
                        }
                        weakself.cycleScrollView.imageURLStringsGroup = images;
                    }
                }
            }
        }
    }];
}

- (void)loadGoodsListData{
    RequestBeanNewGoods *requestBean = [RequestBeanNewGoods new];
    requestBean.price_order = @"desc";
    requestBean.cus_id = [AppUser share].CUS_ID;
    requestBean.company_id = [AppUser share].SYSUSER_COMPANYID;
    requestBean.page_current = self.page;
    requestBean.page_size = 10;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_footer endRefreshing];
        [weakself.table.mj_header endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanNewGoods *response = responseBean;
            
            if(self.page == 1){
                [weakself.goodsList removeAllObjects];
            }
            NSArray *datas = [response.data jk_arrayForKey:@"rows"];
            if(datas.count == 0 || datas.count < requestBean.page_size){
                [weakself.table.mj_footer endRefreshingWithNoMoreData];
                weakself.table.mj_footer.hidden = TRUE;
            }else{
                [weakself.table.mj_footer resetNoMoreData];
                weakself.table.mj_footer.hidden = TRUE;
            }
            [weakself.goodsList addObjectsFromArray:datas];
            [weakself.table reloadData];
        }else{
            if (self.page > 1) {
                [weakself.table.mj_footer endRefreshingWithNoMoreData];
                weakself.table.mj_footer.hidden = TRUE;
            }
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return [CellCategoryHome calHeight:[self.categorys count]];
    }else{
        return [CellNewHome calHeight:self.goodsList];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString*identifier = @"CellCategoryHome";
        CellCategoryHome *cell = (CellCategoryHome*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CellCategoryHome alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.dataSource = self.categorys;
        return cell;
    }else{
        static NSString*identifier = @"CellNewHome";
        CellNewHome *cell = (CellNewHome*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CellNewHome alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.dataSource = self.goodsList;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [SectionHeaderHome calHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return 10.f*RATIO_WIDHT320;
    }else{
        return 0.00001f;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionHeaderHome *header = (SectionHeaderHome*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[SectionHeaderHome alloc]init];
        header.delegate = self;
    }
    if(section == 0){
        [header setTitle:@"商品分类" witIcon:@"home_btn_commodity"];
        header.index = 0;
    }else if(section == 1){
        [header setTitle:@"新品推荐" witIcon:@"home_btn_news"];
        header.index = 1;
    }
    return header;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
    if (!footer) {
        footer = [[UIView alloc]init];
        footer.backgroundColor = RGB3(246);
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[UIViewController alloc]init] animated:TRUE];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - SectionHeaderHomeDelegate
- (void)sectionClickShowAll:(NSInteger)index{
    if(index == 0){
        VCCategory *vc = [[VCCategory alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        VCRecGoodsList *vc = [[VCRecGoodsList alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 102) {
        
        if(buttonIndex == 1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/id1387301168"]];
        }
    }else{
        
        if(buttonIndex == 0){
            VCModifyPassword *vc = [[VCModifyPassword alloc]init];
            [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:TRUE completion:^{
                
            }];
        }
    }
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if(index == 0){
        __weak typeof(self) weakself = self;
        HMScannerController *scanner = [HMScannerController scannerWithCardName:@"" avatar:nil completion:^(NSString *stringValue) {
            if (!stringValue || [stringValue isEqualToString:@""]) {
                [Utils showSuccessToast:@"请扫描正确的商品二维码" with:weakself.view withTime:1];
                return;
            }
            if (![stringValue hasPrefix:@"ID#"]) {
                [Utils showSuccessToast:@"请扫描正确的商品二维码" with:weakself.view withTime:1];
                return;
            }
            stringValue = [stringValue substringFromIndex:3];
            VCGoods *vc = [[VCGoods alloc]init];
            vc.goods_id = stringValue;
            [self.navigationController pushViewController:vc animated:TRUE];
            NSLog(@"%@",stringValue);
        }];
        
        // 设置导航标题样式
        [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
        
        // 展现扫描控制器
        [self showDetailViewController:scanner sender:nil];
    }else{
        VCSearchList *vc = [[VCSearchList alloc]init];
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:FALSE completion:^{
            
        }];
    }
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.tableHeaderView = self.cycleScrollView;
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.dataSource = self;
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            weakself.page = 1;
            [weakself loadCarouseListData];
            [weakself loadData];
            [weakself loadGoodsListData];
        }];
        
        _table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            weakself.page++;
            [weakself loadGoodsListData];
        }];
    }
    return _table;
}

- (SDCycleScrollView*)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect frame = CGRectMake(0, 0, DEVICEWIDTH, 103*RATIO_WIDHT320);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
    }
    return _cycleScrollView;
}

- (ViewSearchWithHome*)vCart{
    if(!_vCart){
        _vCart = [[ViewSearchWithHome alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewSearchWithHome calHeight])];
        _vCart.delegate = self;
        [_vCart updateData];
    }
    return _vCart;
}

@end
