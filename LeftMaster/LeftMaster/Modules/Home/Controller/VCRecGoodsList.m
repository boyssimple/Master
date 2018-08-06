//
//  VCCategory.m
//  LeftMaster
//
//  Created by simple on 2018/4/3.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCRecGoodsList.h"
#import "CellRecGoodsList.h"
#import "ViewSearchHeader.h"
#import "HMScannerController.h"
#import "RequestBeanCategoryHome.h"
#import "RequestBeanGoodsList.h"
#import "VCGoods.h"
#import "ViewOrderRecGoodsList.h"
#import "RequestBeanQueryCartNum.h"
#import "RequestBeanAddCart.h"
#import "RequestBeanNewGoods.h"
#import "VCSingleCart.h"

@interface VCRecGoodsList ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CommonDelegate,CellRecGoodsListDelegate,
        ViewOrderRecGoodsListDelegate>
@property(nonatomic,strong)ViewSearchHeader *vCart;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewOrderRecGoodsList *viewOrder;
@property(nonatomic,strong)NSMutableArray *goodsList;
@property(nonatomic,strong)NSString *keywords;
@property (nonatomic, assign) NSInteger page;
@property(nonatomic,assign)BOOL comp_order;
@property(nonatomic,assign)BOOL price_order;
@property (nonatomic, assign) NSInteger num;
@property(nonatomic,strong)NSString *goods_id;
@property(nonatomic,strong)NSDictionary *data;
@end

@implementation VCRecGoodsList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
    [self loadCartNumData];
}

- (void)initMain{
    self.page = 1;
    self.title = @"新品推荐";
    self.view.backgroundColor = RGB3(247);
    _goodsList = [NSMutableArray array];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 44)];
    view.backgroundColor = [UIColor redColor];
//    self.navigationItem.titleView = self.vCart;
//    [self.view addSubview:self.vCart];
    
    [self.view addSubview:self.vCart];
    [self.view addSubview:self.viewOrder];
    [self.view addSubview:self.table];
    [self observeNotification:REFRESH_CART_LIST];
}


- (void)loadData{
     RequestBeanNewGoods *requestBean = [RequestBeanNewGoods new];
     requestBean.cus_id = [AppUser share].CUS_ID;
     requestBean.company_id = [AppUser share].SYSUSER_COMPANYID;
     requestBean.page_current = 1;
     requestBean.page_size = 10;

//    RequestBeanGoodsList *requestBean = [RequestBeanGoodsList new];
//    requestBean.new_goods = TRUE;
//    requestBean.page_current = self.page;
//    requestBean.page_size = 10;
//    requestBean.cus_id = [AppUser share].CUS_ID;
//    requestBean.company_id = [AppUser share].SYSUSER_COMPANYID;
//
    
//    if (self.comp_order) {
//        requestBean.comp_order = @"asc";
//    }else{
//        requestBean.comp_order = @"desc";
//    }
    
    if (self.price_order) {
        requestBean.price_order = @"asc";
    }else{
        requestBean.price_order = @"desc";
    }
    
    if (self.keywords.length) {
        requestBean.search_name = self.keywords;
    }
    
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [NetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanGoodsList *response = responseBean;
            if(response.success){
                if(self.page == 1){
                    [weakself.goodsList removeAllObjects];
                }
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                if(datas.count == 0 || datas.count < requestBean.page_size){
                    [weakself.table.mj_footer endRefreshingWithNoMoreData];
                    weakself.table.mj_footer.hidden = TRUE;
                }else{
                    [weakself.table.mj_footer resetNoMoreData];
                    weakself.table.mj_footer.hidden = FALSE;
                }
                [weakself.goodsList addObjectsFromArray:datas];
                [weakself.table reloadData];
            }
        }
    }];
}


- (void)loadCartNumData{
    RequestBeanQueryCartNum *requestBean = [RequestBeanQueryCartNum new];
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanQueryCartNum *response = responseBean;
            if(response.success){
                weakself.vCart.count = response.num;
            }
        }
    }];
}

- (void)handleNotification:(NSNotification *)notification{
    [self loadCartNumData];
}

- (void)search{
    self.keywords = self.vCart.tfText.text;
    [self loadData];
}



- (void)addCart{
    NSInteger type = [self.data jk_integerForKey:@"OPER_TYPE"];
    if(type == 0 || [[self.data jk_stringForKey:@"GOODS_PRICE"] isEqualToString:@"?"]){
        [Utils showSuccessToast:@"您不具备该商品购买权限，请联系左师傅" with:self.view withTime:1];
        return;
    }
    RequestBeanAddCart *requestBean = [RequestBeanAddCart new];
    requestBean.goods_id = self.goods_id;
    requestBean.num = self.num;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellRecGoodsList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellRecGoodsList";
    CellRecGoodsList *cell = (CellRecGoodsList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellRecGoodsList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.joinCartDelegate = self;
        cell.vc = self;
    }
    NSDictionary *data = [self.goodsList objectAtIndex:indexPath.row];
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
        footer.backgroundColor = APP_Gray_COLOR;
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [self.goodsList objectAtIndex:indexPath.row];
    VCGoods *vc = [[VCGoods alloc]init];
    vc.goods_id = [data jk_stringForKey:@"GOODS_ID"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (CGFloat)topHeight{
    return NAV_STATUS_HEIGHT + [ViewSearchHeader calHeight] + 10*RATIO_WIDHT320;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self search];
    return YES;
}

#pragma mark ViewCategoryDelegate
- (void)clickQR{
    // 实例化控制器，并指定完成回调
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
        //        self.scanResultLabel.text = stringValue;
    }];
    
    // 设置导航标题样式
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    
    // 展现扫描控制器
    [self showDetailViewController:scanner sender:nil];
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if(index == 0){
        [self clickQR];
    }else{
        VCSingleCart *vc = [[VCSingleCart alloc]init];
        [self.navigationController pushViewController:vc animated:TRUE];
    }
}


#pragma mark - CellRecGoodsListDelegate
- (void)joinCartClick:(NSInteger)index withNum:(NSInteger)num{
    NSDictionary *data = [self.goodsList objectAtIndex:index];
    self.data = data;
    self.goods_id = [data jk_stringForKey:@"GOODS_ID"];
    self.num = num;
    [self addCart];
}

#pragma mark - ViewOrderRecGoodsListDelegate
- (void)clickOrder:(NSInteger)index withState:(BOOL)state{
    if (index == 0) {
        self.comp_order = state;
    }else if(index == 1){
        self.price_order = state;
    }
    [self loadData];
}

- (ViewSearchHeader*)vCart{
    if(!_vCart){
        _vCart = [[ViewSearchHeader alloc]initWithFrame:CGRectMake(0, NAV_STATUS_HEIGHT, DEVICEWIDTH, [ViewSearchHeader calHeight])];
        _vCart.delegate = self;
        _vCart.tfText.delegate = self;
        _vCart.tfText.returnKeyType = UIReturnKeySearch;
        [_vCart updateData];
    }
    return _vCart;
}


- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, self.viewOrder.bottom, DEVICEWIDTH, DEVICEHEIGHT-[ViewOrderRecGoodsList calHeight] - NAV_STATUS_HEIGHT - [ViewSearchHeader calHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor whiteColor];
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
        _table.mj_footer.hidden = TRUE;
    }
    return _table;
}

- (ViewOrderRecGoodsList*)viewOrder{
    if(!_viewOrder){
        _viewOrder = [[ViewOrderRecGoodsList alloc]initWithFrame:CGRectMake(0, self.vCart.bottom, DEVICEWIDTH, [ViewOrderRecGoodsList calHeight])];
        _viewOrder.delegate = self;
    }
    return _viewOrder;
}

@end

