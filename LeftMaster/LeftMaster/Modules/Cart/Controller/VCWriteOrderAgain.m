//
//  VCWriteOrder.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCWriteOrderAgain.h"
#import "ViewGoodsList.h"
#import "ViewMessageOrder.h"
#import "ViewTotalOrder.h"
#import "ViewTotalBottomWriteOrder.h"
#import "ViewISBill.h"
#import "RequestBeanBillOrg.h"
#import "WindowCustom.h"
#import "Custom.h"
#import "CartGoods.h"
#import "RequestBeanAddOrder.h"
#import "RequestBeanOrderGoodsList.h"
#import "VCEditGoodList.h"
#import "NetWorkTools.h"

@interface VCWriteOrderAgain ()<CommonDelegate,WindowCustomDelegate,UIScrollViewDelegate,ViewTotalBottomWriteOrderDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UIScrollView *mainView;
@property(nonatomic,strong)ViewGoodsList *vGoodsList;
@property(nonatomic,strong)ViewISBill *vBill;
@property(nonatomic,strong)ViewMessageOrder *vMsgOrder;
@property(nonatomic,strong)ViewTotalOrder *vTotalOrder;
@property(nonatomic,strong)ViewTotalBottomWriteOrder *vTotalControl;
@property(nonatomic,strong)WindowCustom *customView;
@property(nonatomic,strong)Custom *cust;
@property(nonatomic,assign)BOOL isBill;
@property(nonatomic,assign)CGFloat totalPrice;
@property(nonatomic,strong)NSString *remark;

@property(nonatomic,strong)NSMutableArray *goodsList;
@end

@implementation VCWriteOrderAgain

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadCustom];
    [self loadData];
}


- (void)initMain{
    self.title = @"填写订单";
    _goodsList = [NSMutableArray array];
    [self.view addSubview:self.mainView];
    [self.mainView addSubview:self.vGoodsList];
//    [self.mainView addSubview:self.vBill];
    [self.mainView addSubview:self.vMsgOrder];
    [self.mainView addSubview:self.vTotalOrder];
    
    self.mainView.contentSize = CGSizeMake(self.mainView.contentSize.width, self.vTotalOrder.bottom);
    [self.view addSubview:self.vTotalControl];
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

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"%f",DEVICEHEIGHT - height);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect r = self.mainView.frame;
        r.size.height = DEVICEHEIGHT - height;
        self.mainView.frame = r;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            
            CGPoint p = self.mainView.contentOffset;
            p.y = self.mainView.contentSize.height - self.mainView.bounds.size.height;
            self.mainView.contentOffset = p;
            
        }];
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
        
        self.mainView.height = DEVICEHEIGHT - [ViewTotalBottomWriteOrder calHeight];
    }];
    
}

- (void)loadData{
    RequestBeanOrderGoodsList *requestBean = [RequestBeanOrderGoodsList new];
    requestBean.page_current = 1;
    requestBean.FD_ORDER_ID = self.orderId;
    requestBean.page_size = 1000;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanOrderGoodsList *response = responseBean;
            if(response.success){
                [weakself.goodsList removeAllObjects];
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                for (NSDictionary *data in datas) {
                    if (![data jk_boolForKey:@"FD_IS_GIFT"]) {
                        CartGoods *c = [[CartGoods alloc]init];
                        c.GOODS_PIC = [data jk_stringForKey:@"GOODS_PIC"];
                        c.FD_NUM = [data jk_integerForKey:@"FD_NUM"];
                        c.GOODS_PRICE = [data jk_floatForKey:@"FD_UNIT_PRICE"];
                        c.GOODS_UNIT = [data jk_stringForKey:@"FD_UNIT_NAME"];
                        c.GOODS_NAME = [data jk_stringForKey:@"GOODS_NAME"];
                        c.GOODS_ID = [data jk_stringForKey:@"GOODS_ID"];
                        c.GOODS_CODE = [data jk_stringForKey:@"GOODS_CODE"];
                        [weakself.goodsList addObject:c];
                    }
                }
                [weakself installData];
                
            }
        }
    }];
}

- (void)loadCustom{
    RequestBeanBillOrg *requestBean = [RequestBeanBillOrg new];
    requestBean.cus_id = [AppUser share].CUS_ID;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanBillOrg *response = responseBean;
            if(response.success){
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                NSMutableArray *customs = [NSMutableArray array];
                for (NSDictionary *data in datas) {
                    Custom *custom = [[Custom alloc]init];
                    [custom parse:data];
                    if(custom.fd_default){
                        weakself.isBill = TRUE;
                        weakself.cust = custom;
                        [weakself.vBill updateData:custom];
                    }
                    [customs addObject:custom];
                }
            }
        }
    }];
}

- (void)installData{
    self.totalPrice = 0;
    for (CartGoods *g in self.goodsList) {
        self.totalPrice += g.FD_NUM * g.GOODS_PRICE;
    }
    
    [self.vTotalOrder updateData:self.totalPrice];
    [self.vTotalControl updateData:self.totalPrice];
    self.vGoodsList.dataSource = _goodsList;
    
}

- (void)refreshCustom{
    RequestBeanBillOrg *requestBean = [RequestBeanBillOrg new];
    requestBean.cus_id = [AppUser share].CUS_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:weakself.view withTime:0.2];
        if (!err) {
            // 结果处理
            ResponseBeanBillOrg *response = responseBean;
            if(response.success){
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                NSMutableArray *customs = [NSMutableArray array];
                for (NSDictionary *data in datas) {
                    Custom *custom = [[Custom alloc]init];
                    [custom parse:data];
                    [customs addObject:custom];
                }
                weakself.customView = [[WindowCustom alloc]init:customs];
                weakself.customView.delegate = weakself;
                [weakself.customView show];
            }
        }
    }];
}

- (void)addOrderAction{
    RequestBeanAddOrder *requestBean = [RequestBeanAddOrder new];
    NSMutableDictionary *orderInfo = [[NSMutableDictionary alloc]init];
    [orderInfo setObject:[AppUser share].SYSUSER_ID forKey:@"FD_CREATE_USER_ID"];
    [orderInfo setObject:[AppUser share].CUS_ID forKey:@"FD_ORDER_ORG_ID"];
    [orderInfo setObject:[NSString stringWithFormat:@"%f",self.totalPrice] forKey:@"FD_TOTAL_PRICE"];
    NSMutableArray *goods = [[NSMutableArray alloc]init];
    for (CartGoods *g in self.goodsList) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:g.GOODS_ID forKey:@"FD_GOODS_ID"];
        [dic setObject:g.GOODS_NAME forKey:@"FD_GOODS_ID_LABELS"];
        [dic setObject:[NSString stringWithFormat:@"%ld",g.FD_NUM] forKey:@"FD_NUM"];
        [dic setObject:[NSString stringWithFormat:@"%f",g.GOODS_PRICE] forKey:@"FD_UNIT_PRICE"];
        [dic setObject:[NSString stringWithFormat:@"%f",g.FD_NUM * g.GOODS_PRICE] forKey:@"FD_TOTAL_PRICE"];
        [goods addObject:dic];
    }
    [orderInfo setObject:goods forKey:@"ORDER_DETAIL"];
    
    
    if(self.remark && self.remark.length > 0){
        [orderInfo setObject:self.remark forKey:@"FD_DESC"];
    }
    NSString *encodedValue = [[Utils dictToJsonStr:orderInfo] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    requestBean.oderInfo = encodedValue;//[Utils dictToJsonStr:orderInfo];
    NSLog(@"结果:%@",requestBean.oderInfo);
    
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    
    
    [NetWorkTools requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        ResponseBeanAddOrder *response = responseBean;
        if (!err) {
            // 结果处理
            if(response.success){
                [Utils showSuccessToast:@"下单成功" with:self.view withTime:1 withBlock:^{
                    [weakself.navigationController popViewControllerAnimated:TRUE];
                }];
                [weakself postNotification:REFRESH_CART_LIST withObject:nil];
            }else{
                [Utils showSuccessToast:response.msg with:weakself.view withTime:1];
            }
        }else{
            if (response.msg) {
                [Utils showSuccessToast:response.msg with:weakself.view withTime:1];
            }else{
                [Utils showSuccessToast:@"请求失败" with:weakself.view withTime:1];
            }
            
        }
    }];
}

- (void)reloadDatas:(NSArray*)datas{
    [self.goodsList removeAllObjects];
    [self.goodsList addObjectsFromArray:datas];
    [self installData];
}

- (void)gotoEditGoodList{
    VCEditGoodList *vc = [[VCEditGoodList alloc]init];
    vc.superVC = self;
    vc.goodsList = [self.goodsList mutableCopy];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)changeAction:(id)sender{
    UITextField* target = (UITextField*)sender;
    self.remark = target.text;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if(index == 0){
        //暂不能选
//        [self refreshCustom];
    }else if(index == 1){
        self.isBill = TRUE;
    }else{
        self.isBill = FALSE;
    }
    
}

#pragma mark - WindowCustomDelegate
- (void)selectCustom:(Custom *)cust{
    self.cust = cust;
    [self.vBill updateData:self.cust];
}

#pragma mark - ViewTotalBottomWriteOrderDelegate
- (void)clickOrder{
    if (self.goodsList.count == 0) {
        [Utils showSuccessToast:@"未选择商品" with:self.view withTime:0.8];
        return;
    }
    if (self.totalPrice < 500) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"订单金额未达到500元免运费条件，将自付运费，请确认!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 100;
        [alert show];
    }else{
        [self addOrderAction];
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            [self addOrderAction];
        }
    }
}

- (UIScrollView*)mainView{
    if (!_mainView) {
        _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT - [ViewTotalBottomWriteOrder calHeight])];
        _mainView.backgroundColor = APP_Gray_COLOR;
        _mainView.alwaysBounceVertical = YES;
        _mainView.delegate = self;
    }
    return _mainView;
}

- (ViewGoodsList*)vGoodsList{
    if (!_vGoodsList) {
        _vGoodsList = [[ViewGoodsList alloc]initWithFrame:CGRectMake(0, 10*RATIO_WIDHT320, DEVICEWIDTH, [ViewGoodsList calHeight])];
        _vGoodsList.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoEditGoodList)];
        [_vGoodsList addGestureRecognizer:tap];
        [_vGoodsList updateData];
    }
    return _vGoodsList;
}

- (ViewISBill*)vBill{
    if (!_vBill) {
        _vBill = [[ViewISBill alloc]initWithFrame:CGRectMake(0, self.vGoodsList.bottom + 8*RATIO_WIDHT320, DEVICEWIDTH, [ViewISBill calHeight])];
        _vBill.delegate = self;
        [_vBill updateData];
    }
    return _vBill;
}

- (ViewMessageOrder*)vMsgOrder{
    if (!_vMsgOrder) {
        _vMsgOrder = [[ViewMessageOrder alloc]initWithFrame:CGRectMake(0, self.vGoodsList.bottom + 8*RATIO_WIDHT320, DEVICEWIDTH, [ViewMessageOrder calHeight])];
        [_vMsgOrder.tfText addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    }
    return _vMsgOrder;
}

- (ViewTotalOrder*)vTotalOrder{
    if (!_vTotalOrder) {
        _vTotalOrder = [[ViewTotalOrder alloc]initWithFrame:CGRectMake(0, self.vMsgOrder.bottom + 8*RATIO_WIDHT320, DEVICEWIDTH, [ViewTotalOrder calHeight])];
        [_vTotalOrder updateData];
    }
    return _vTotalOrder;
}

- (ViewTotalBottomWriteOrder*)vTotalControl{
    if (!_vTotalControl) {
        _vTotalControl = [[ViewTotalBottomWriteOrder alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewTotalBottomWriteOrder calHeight], DEVICEWIDTH, [ViewTotalBottomWriteOrder calHeight])];
        _vTotalControl.delegate = self;
        [_vTotalControl updateData];
    }
    return _vTotalControl;
}

@end
