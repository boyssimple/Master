//
//  VCCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCCart.h"
#import "CellCart.h"
#import "ViewTotalCart.h"
#import "VCWriteOrder.h"
#import "VCWriteOrder.h"
#import "RequestBeanCartList.h"
#import "VCGoods.h"
#import "CartGoods.h"
#import "RequestBeanDelCart.h"
#import "RequestBeanAddCart.h"
#import "RequestBeanSetCart.h"
#import "CustConfirmView.h"

@interface VCCart ()<UITableViewDelegate,UITableViewDataSource,ViewTotalCartDelegate,CommonDelegate,UIAlertViewDelegate,CellCartDelegate,CustConfirmViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewTotalCart *vControl;
@property(nonatomic,strong)NSMutableArray *goodsList;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *carId;
@property (nonatomic, assign) NSInteger delIndex;
@property(nonatomic,strong)CustConfirmView *custon;


@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger curIndex;
@end

@implementation VCCart

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.page = 1;
    _goodsList = [NSMutableArray array];
    [self.view addSubview:self.table];
    [self.view addSubview:self.vControl];
    [self.view addSubview:self.custon];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonAction)];
    rightButton.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    //加入购物车通知
    [self observeNotification:REFRESH_CART_LIST];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAll) name:REFRESH_ALL_INFO object:nil];
    
}

- (void)refreshAll{
    self.page = 1;
    [self loadData];
}

- (void)rightButtonAction{
    NSMutableArray *selects = [NSMutableArray array];
    for (CartGoods *c in self.goodsList) {
        if(c.selected){
            [selects addObject:c];
        }
    }
    if (selects.count > 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        alert.tag = 101;
        [alert show];
    }else{
        [Utils showSuccessToast:@"请选择删除商品" with:self.view withTime:0.8];
    }
}



- (void)delActions{
    NSMutableString *ids = [[NSMutableString alloc]init];
    NSMutableArray *selects = [NSMutableArray array];
    for (CartGoods *c in self.goodsList) {
        if(c.selected){
            if (ids.length == 0) {
                [ids appendFormat:@"%@",c.FD_ID];
            }else{
                [ids appendFormat:@",%@",c.FD_ID];
            }
            [selects addObject:c];
        }
    }
    if (selects.count == 0) {
        return;
    }
    RequestBeanDelCart *requestBean = [RequestBeanDelCart new];
    requestBean.car_id = ids;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        
        ResponseBeanDelCart *response = responseBean;
        if (!err) {
            // 结果处理
            if(response.success){
                weakself.page = 1;
                [weakself loadData];
            }else{
                [Utils showSuccessToast:response.msg with:weakself.view withTime:0.8];
                
            }
        }else{
            [Utils showSuccessToast:response.msg with:weakself.view withTime:0.8];
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}



//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height - height);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.custon.frame;
        r.origin.y = [UIScreen mainScreen].bounds.size.height - height - [CustConfirmView calHeight];
        self.custon.frame = r;
        self.table.height = DEVICEHEIGHT - (height + [CustConfirmView calHeight]);
    }];
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    NSLog(@"%f",[UIScreen mainScreen].bounds.size.height);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.custon.frame;
        r.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.custon.frame = r;
        
        self.table.height = DEVICEHEIGHT - [ViewTotalCart calHeight] - TABBAR_HEIGHT;
    }];
    
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


- (void)setCart:(NSString*)carId withAmount:(NSInteger)num{
    RequestBeanSetCart *requestBean = [RequestBeanSetCart new];
    requestBean.car_id = carId;
    requestBean.num = num;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        
        if (!err) {
            // 结果处理
            ResponseBeanAddCart *response = responseBean;
            if (response.success) {
                [Utils hiddenHanding:self.view withTime:0.3];
            }else{
                [Utils showSuccessToast:@"操作失败" with:weakself.view withTime:1];
            }
        }else{
            [Utils showSuccessToast:@"操作失败" with:weakself.view withTime:1];
        }
    }];
}

- (void)handleDatas:(NSArray*)datas with:(NSInteger)size{
    if(self.page == 1){
        [self.goodsList removeAllObjects];
    }
    if(datas.count == 0 || datas.count < size){
        [self.table.mj_footer endRefreshingWithNoMoreData];
        self.table.mj_footer.hidden = TRUE;
    }else{
        [self.table.mj_footer resetNoMoreData];
        self.table.mj_footer.hidden = FALSE;
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
        cell.cellDelegate = self;
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
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }else if(index == 2){
        //减数量request
        CartGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.FD_NUM -= 1;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self calTotal];
        
        [self setCart:data.FD_ID withAmount:data.FD_NUM];
    }else{
        //加数量request
        CartGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.FD_NUM += 1;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self calTotal];
        [self setCart:data.FD_ID withAmount:data.FD_NUM];
    }
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 101) {
        
        if (buttonIndex == 1) {
            [self delActions];
        }
    }else{
        if (buttonIndex == 1) {
            [self delAction];
        }
    }
}


#pragma mark - CellTopGoodsDelegate
- (void)inputCount:(NSInteger)count withDataIndex:(NSInteger)index{
    self.curIndex = index;
    self.count = count;
}

#pragma mark - CustConfirmViewDelegate
- (void)custConfirmSelect{
    if (self.count != 0) {
        CartGoods *data = [self.goodsList objectAtIndex:self.curIndex];
        data.FD_NUM = self.count;
        [self.goodsList replaceObjectAtIndex:self.curIndex withObject:data];
        [self calTotal];
        [self setCart:data.FD_ID withAmount:data.FD_NUM];
        self.count = 0;
        self.curIndex = 0;
    }else{
        CartGoods *data = [self.goodsList objectAtIndex:self.curIndex];
        data.FD_NUM = 1;
        [self.goodsList replaceObjectAtIndex:self.curIndex withObject:data];
        [self calTotal];
        [self.table reloadData];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:TRUE];
}



- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-[ViewTotalCart calHeight] - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
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
        _table.mj_footer.hidden = TRUE;
    }
    return _table;
}

- (ViewTotalCart*)vControl{
    if(!_vControl){
        _vControl = [[ViewTotalCart alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewTotalCart calHeight]-TABBAR_HEIGHT, DEVICEWIDTH, [ViewTotalCart calHeight])];
        [_vControl updateData];
        _vControl.delegate = self;
    }
    return _vControl;
}

- (CustConfirmView*)custon{
    if(!_custon){
        _custon = [[CustConfirmView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [CustConfirmView calHeight])];
        _custon.delegate = self;
    }
    return _custon;
}
@end
