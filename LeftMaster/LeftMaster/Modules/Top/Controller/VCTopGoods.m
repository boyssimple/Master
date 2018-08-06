//
//  VCCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCTopGoods.h"
#import "CellTopGoods.h"
#import "TopViewControl.h"
#import "RequestBeanAlwaysBuyGoods.h"
#import "RequestBeanAddBatchCart.h"
#import "AlwaysBuyGoods.h"
#import "VCGoods.h"
#import "CartGoods.h"
#import "CustConfirmView.h"

@interface VCTopGoods ()<UITableViewDelegate,UITableViewDataSource,TopViewControlDelegate,CommonDelegate,CellTopGoodsDelegate,CustConfirmViewDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)TopViewControl *vControl;
@property(nonatomic,strong)NSMutableArray *goodsList;
@property (nonatomic, assign) NSInteger page;
@property(nonatomic,strong)CustConfirmView *custon;



@property(nonatomic,assign)NSInteger count;
@property(nonatomic,assign)NSInteger curIndex;
@end

@implementation VCTopGoods

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
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshAll)
                                                 name:REFRESH_ALL_INFO
                                               object:nil];
}

- (void)refreshAll{
    self.page = 1;
    [self loadData];
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

- (void)loadData{
    RequestBeanAlwaysBuyGoods *requestBean = [RequestBeanAlwaysBuyGoods new];
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    requestBean.cus_id = [AppUser share].CUS_ID;
    requestBean.company_id = [AppUser share].SYSUSER_COMPANYID;
    requestBean.page_current = self.page;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanAlwaysBuyGoods *response = responseBean;
            if(response.success){
                [weakself handleDatas:[response.data jk_arrayForKey:@"rows"] with:requestBean.page_size];
            }
        }else{
            [self.table.mj_footer endRefreshingWithNoMoreData];
            self.table.mj_footer.hidden = TRUE;
            
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
        AlwaysBuyGoods *cart = [[AlwaysBuyGoods alloc]init];
        [cart parse:data];
        [self.goodsList addObject:cart];
    }
    [self.table reloadData];
    [self calTotal];
}

- (void)calTotal{
    NSInteger num = 0;
    CGFloat total = 0;
    for (AlwaysBuyGoods *c in self.goodsList) {
        if(c.selected){
            num += c.Num;
            total += c.GOODS_PRICE*c.Num;
        }
    }
    [self.vControl updateData:num withPrice:total];
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
        
        self.table.height = DEVICEHEIGHT - [TopViewControl calHeight] - TABBAR_HEIGHT;
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellTopGoods calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellTopGoods";
    CellTopGoods *cell = (CellTopGoods*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellTopGoods alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
        cell.cellDelegate = self;
    }
    cell.index = indexPath.row;
    AlwaysBuyGoods *data = [self.goodsList objectAtIndex:indexPath.row];
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
    
    AlwaysBuyGoods *data = [self.goodsList objectAtIndex:indexPath.row];
    VCGoods *vc = [[VCGoods alloc]init];
    vc.goods_id = data.GOODS_ID;
    vc.hidesBottomBarWhenPushed = TRUE;
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)clickCheck:(BOOL)selected{
    for (AlwaysBuyGoods *c in self.goodsList) {
        c.selected = selected;
    }
    [self.table reloadData];
    [self calTotal];
    
}

#pragma mark ViewTotalCartDelegate
- (void)clickOrder{
    
    
    NSMutableArray *selects = [NSMutableArray array];
    NSInteger num = 0;
    for (AlwaysBuyGoods *c in self.goodsList) {
        if(c.selected && ![c.old_GOODS_PRICE isEqualToString:@"?"]){
            CartGoods *g = [[CartGoods alloc]init];
            g.FD_NUM = c.Num;
            g.GOODS_PIC = c.GOODS_PIC;
            g.GOODS_PRICE = c.GOODS_PRICE;
            g.GOODS_UNIT = c.GOODS_UNIT;
            g.GOODS_NAME = c.GOODS_NAME;
            g.GOODS_CODE = c.GOODS_CODE;
            g.GOODS_ID = c.GOODS_ID;
            
            num += c.Num;
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:g.GOODS_ID forKey:@"goods_id"];
            [dic setObject:[NSString stringWithFormat:@"%zi",c.Num] forKey:@"num"];
            [selects addObject:dic];
        }
        
    }
    if(num > 0){
        
        RequestBeanAddBatchCart *requestBean = [RequestBeanAddBatchCart new];
        requestBean.user_id = [AppUser share].SYSUSER_ID;
        requestBean.cus_id = [AppUser share].CUS_ID;
        
        NSData *data=[NSJSONSerialization dataWithJSONObject:selects options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"结果:%@",jsonStr);
        
        
        NSString *result = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(nil,(CFStringRef)jsonStr,nil,(CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
        requestBean.detail = result;
        [Utils showHanding:requestBean.hubTips with:self.view];
        [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
            [Utils hiddenHanding:self.view withTime:0.5];
            if (!err) {
                // 结果处理
                ResponseBeanAddBatchCart *response = responseBean;
                if(response.success){
                    [Utils showSuccessToast:@"加入购车成功" with:self.view withTime:1];
                }
            }else{
                [Utils showSuccessToast:@"加入失败" with:self.view withTime:1];
            }
        }];
        
        
        
        
        /*
        VCWriteOrder *vc = [[VCWriteOrder alloc]init];
        vc.goodsList = selects;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
         */
    }else{
        [Utils showSuccessToast:@"请选择商品" with:self.view withTime:0.8];
    }
    
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index withDataIndex:(NSInteger)dataIndex{
    if (index == 0) {
        AlwaysBuyGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.selected = !data.selected;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self calTotal];
    }else if(index == 1){
        [self.view endEditing:TRUE];
        //减数量request
        AlwaysBuyGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.Num -= 1;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self calTotal];
    }else if(index == 2){
        [self.view endEditing:TRUE];
        //加数量request
        AlwaysBuyGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.Num += 1;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self calTotal];
    }
}

#pragma mark - CellTopGoodsDelegate
- (void)inputCount:(NSInteger)count withDataIndex:(NSInteger)index{
//    AlwaysBuyGoods *data = [self.goodsList objectAtIndex:index];
//    data.Num = count;
//    [self.goodsList replaceObjectAtIndex:index withObject:data];
//    [self calTotal];
//    
    self.curIndex = index;
    self.count = count;
}


#pragma mark - CustConfirmViewDelegate
- (void)custConfirmSelect{
    if (self.count != 0) {
        AlwaysBuyGoods *data = [self.goodsList objectAtIndex:self.curIndex];
        data.Num = self.count;
        [self.goodsList replaceObjectAtIndex:self.curIndex withObject:data];
        [self calTotal];
        self.count = 0;
        self.curIndex = 0;
    }else{
        AlwaysBuyGoods *data = [self.goodsList objectAtIndex:self.curIndex];
        data.Num = 1;
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
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-[TopViewControl calHeight] - TABBAR_HEIGHT) style:UITableViewStyleGrouped];
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

- (TopViewControl*)vControl{
    if(!_vControl){
        _vControl = [[TopViewControl alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [TopViewControl calHeight]-TABBAR_HEIGHT, DEVICEWIDTH, [TopViewControl calHeight])];
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

