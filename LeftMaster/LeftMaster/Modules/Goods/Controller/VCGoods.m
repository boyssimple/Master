//
//  VCGoods.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCGoods.h"
#import "SDCycleScrollView.h"
#import "ViewHeaderGoods.h"
#import "ViewBtnGoods.h"
#import "RequestBeanGoodsDetail.h"
#import "RequestBeanAddCart.h"
#import "CellGoods.h"
#import "VCWriteOrder.h"
#import "RequestBeanQueryCartNum.h"
#import "CartGoods.h"
#import "VCSingleCart.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PhotoBrowser.h"

@interface VCGoods ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,ViewHeaderGoodsDelegate,CommonDelegate,
        UIWebViewDelegate,ViewHeaderGoodsDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIWebView *footer;
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)UILabel *lbPicCount;
@property(nonatomic,strong)ViewBtnGoods *bottom;
@property(nonatomic,strong)NSDictionary *data;
@property (nonatomic, assign) NSInteger count;

@property(nonatomic,strong)NSArray *roles;

@property(nonatomic,strong)NSString* OTHER_GOODS_ID;



@end

@implementation VCGoods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
    [self loadCartNumData];
}

- (void)initMain{
    self.count = 1;
    self.title = @"商品详情";
    self.OTHER_GOODS_ID = @"";
    [self.view addSubview:self.table];
    [self.view addSubview:self.bottom];
    [self observeNotification:REFRESH_CART_LIST];
}


- (void)loadData{
    RequestBeanGoodsDetail *requestBean = [RequestBeanGoodsDetail new];
    requestBean.goods_id = self.goods_id;
    if (self.OTHER_GOODS_ID && ![self.OTHER_GOODS_ID isEqualToString:@""]) {
        requestBean.goods_id = self.OTHER_GOODS_ID;
    }
    requestBean.cus_id = [AppUser share].CUS_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanGoodsDetail *response = responseBean;
            weakself.data = response.data;
            [weakself installData];
        }
    }];
}

- (void)addCart{
    if([self.data jk_integerForKey:@"GOODS_STOCK"] <= 0){
        [Utils showSuccessToast:@"没有库存" with:self.view withTime:1];
        return;
    }
    if (self.count <= 0) {
        [Utils showSuccessToast:@"数量应大于0" with:self.view withTime:1];
        return;
    }
    RequestBeanAddCart *requestBean = [RequestBeanAddCart new];
    requestBean.goods_id = [self.data jk_stringForKey:@"GOODS_ID"];
    requestBean.num = self.count;
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

- (void)installData{
    if(self.data){
        if (self.roles.count == 0) {
            self.roles = [self.data jk_arrayForKey:@"GOODS_GOODSSPECS"];
        }else{
            NSMutableDictionary *newData = [self.data mutableCopy];
            [newData setObject:self.roles forKey:@"GOODS_GOODSSPECS"];
            self.data = newData;
        }
        NSString *html = [self.data jk_stringForKey:@"GOODS_INTRODUCTION"];
        [self.footer loadHTMLString:[self installHtml:html] baseURL:nil];
        
        self.cycleScrollView.imageURLStringsGroup = [self.data jk_arrayForKey:@"GOODS_PICS"];
        self.lbPicCount.text = [NSString stringWithFormat:@"%d/%ld",1,self.cycleScrollView.imageURLStringsGroup.count];
        if(self.cycleScrollView.imageURLStringsGroup.count > 0){
            self.lbPicCount.hidden = NO;
        }else{
            self.lbPicCount.hidden = YES;
        }
    }
    [self.table reloadData];
}

- (NSString*)installHtml:(NSString*)content{
    if(!content){
        content = @"";
    }
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    
//        [html appendString:@"<meta name=\"viewport\" content=\"target-densitydpi=device-dpi,width=640,user-scalable=no\"/>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"style.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#ffffff\">"];
    [html appendString:content];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return html;
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
                weakself.bottom.count = response.num;
            }
        }
    }];
}

- (void)addOrder{
    if(self.data){
        if ([self.data jk_integerForKey:@"GOODS_STOCK"] > 0) {
            
            if (self.count > 0) {
                NSMutableArray *selects = [NSMutableArray array];
                CartGoods *c = [[CartGoods alloc]init];
                c.GOODS_PIC = [self.data jk_stringForKey:@"GOODS_PIC"];
                c.GOODS_ID = [self.data jk_stringForKey:@"GOODS_ID"];
                c.FD_NUM = self.count;
                c.GOODS_NAME = [self.data jk_stringForKey:@"GOODS_NAME"];
                c.GOODS_PRICE = [self.data jk_floatForKey:@"GOODS_PRICE"];
                c.GOODS_UNIT = [self.data jk_stringForKey:@"GOODS_UNIT"];
                
                [selects  addObject:c];
                VCWriteOrder *vc = [[VCWriteOrder alloc]init];
                vc.goodsList = selects;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [Utils showSuccessToast:@"数量应大于0" with:self.view withTime:0.8];
            }
        }else{
            [Utils showSuccessToast:@"没有库存" with:self.view withTime:0.8];
        }
        
    }
}

- (void)handleNotification:(NSNotification *)notification{
    [self loadCartNumData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.data && [self.data jk_arrayForKey:@"GOODS_PARAMJSON"].count > 0){
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.data){
        return [CellGoods calHeight:[self.data jk_arrayForKey:@"GOODS_PARAMJSON"]];
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"Cell";
    CellGoods *cell = (CellGoods*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellGoods alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(self.data){
        cell.dataSouce = [self.data jk_arrayForKey:@"GOODS_PARAMJSON"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [ViewHeaderGoods calHeight:self.data];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ViewHeaderGoods *header = (ViewHeaderGoods*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[ViewHeaderGoods alloc]init];
        header.delegate = self;
    }
    [header updateData:self.data with:self.OTHER_GOODS_ID];
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
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:TRUE];
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.lbPicCount.text = [NSString stringWithFormat:@"%zi/%zi",index+1,self.cycleScrollView.imageURLStringsGroup.count];
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSArray *imgs  = self.cycleScrollView.imageURLStringsGroup;
    
    //
    NSMutableArray *arrPhotos = [NSMutableArray array];
    for (NSString *url in imgs) {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:url];
        [arrPhotos addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index;
    browser.photos = arrPhotos;
    [browser show];
    
}

#pragma mark - ViewHeaderGoodsDelegate
- (void)minusCount{
    self.count--;
}

- (void)addCount{
    self.count++;
}

- (void)inputCount:(NSInteger)count{
    self.count = count;
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if(self.data){
        
        NSInteger type = [self.data jk_integerForKey:@"OPER_TYPE"];
        if(type == 0 || [[self.data jk_stringForKey:@"GOODS_PRICE"] isEqualToString:@"?"]){
            [Utils showSuccessToast:@"您不具备该商品购买权限，请联系左师傅" with:self.view withTime:1];
        }else{
            NSArray *datas = [self.data jk_arrayForKey:@"GOODS_GOODSSPECS"];
            
            
            if (index == 0) {
                //调用加入购物车接口
                if (datas.count > 0) {
                    if (!self.OTHER_GOODS_ID || [self.OTHER_GOODS_ID isEqualToString:@""]) {
                        [Utils showSuccessToast:@"请选择规格" with:self.view withTime:1];
                    }else{
                        [self addCart];
                        
                    }
                }else{
                    [self addCart];
                    
                }
            }else if(index == 1){
                if (datas.count > 0) {
                    if (!self.OTHER_GOODS_ID || [self.OTHER_GOODS_ID isEqualToString:@""]) {
                        [Utils showSuccessToast:@"请选择规格" with:self.view withTime:1];
                    }else{
                        [self addOrder];
                        
                    }
                }else{
                    [self addOrder];
                    
                }
            }else{
                VCSingleCart *vc = [[VCSingleCart alloc]init];
                [self.navigationController pushViewController:vc animated:TRUE];
            }
        }
    
    }
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    CGFloat  htmlHeight = [[self.footer stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"]floatValue];
    CGRect r = self.footer.frame;
    r.size.height = htmlHeight;
    self.footer.frame = r;
    self.table.tableFooterView = self.footer;
    [self.table reloadData];
    
    [webView stringByEvaluatingJavaScriptFromString:@"function assignImageClickAction(){var imgs=document.getElementsByTagName('img');var length=imgs.length;for(var i=0;i<length;i++){img=imgs[i];img.onclick=function(){window.location.href='image-preview:'+this.src}}}"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"assignImageClickAction();"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //预览图片
    if ([request.URL.scheme isEqualToString:@"image-preview"]) {
        NSString* path = [request.URL.absoluteString substringFromIndex:[@"image-preview:" length]];
        path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"地址:%@",path);
//        [self.imageView setImageWithURL:[NSURL URLWithString:path] placeholderImage:[UIImage imageNamed:@"default"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        [UIView animateWithDuration:0.2f animations:^{
//            self.imageView.alpha = 1.0f;
//        }];
        
//        NSUInteger imgIndex = [arrPicPath indexOfObject:pavalue.content];
        
//        
//        NSMutableArray *arrPhotos = [NSMutableArray array];
//        for (NSString *url in arrPicPath) {
//            MJPhoto *photo = [[MJPhoto alloc] init];
//            photo.url = [NSURL URLWithString:url];
//            photo.srcImageView = cellimg.ivT;
//            [arrPhotos addObject:photo];
//        }
        
//        PhotoBrowser *browser = [[PhotoBrowser alloc]init:path];
//        [browser show];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:path];

        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = 0;
        browser.photos = @[photo];
        [browser show];
        
        return NO;
    }
    return YES;
}

#pragma mark
- (void)clickRole:(NSInteger)index{
    if (self.data) {
        NSArray *datas = [self.data jk_arrayForKey:@"GOODS_GOODSSPECS"];
        if (index < datas.count) {
            NSDictionary *data = [datas objectAtIndex:index];
            self.OTHER_GOODS_ID = [data jk_stringForKey:@"OTHER_GOODS_ID"];
        }
    }
    [self loadData];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT-[ViewBtnGoods calHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.cycleScrollView;
    }
    return _table;
}

- (UIWebView*)footer{
    if(!_footer){
        _footer = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 100)];
        _footer.delegate = self;
    }
    return _footer;
}

- (UILabel*)lbPicCount{
    if(!_lbPicCount){
        _lbPicCount = [[UILabel alloc]initWithFrame:CGRectMake(DEVICEWIDTH - 30*RATIO_WIDHT320 - 10*RATIO_WIDHT320, 320*RATIO_WIDHT320 - 12*RATIO_WIDHT320 -5*RATIO_WIDHT320, 30*RATIO_WIDHT320, 12*RATIO_WIDHT320)];
        _lbPicCount.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbPicCount.textColor = RGB3(254);
        _lbPicCount.backgroundColor = RGB3(153);
        _lbPicCount.textAlignment = NSTextAlignmentCenter;
        _lbPicCount.layer.cornerRadius = _lbPicCount.height/2.0;
        _lbPicCount.layer.masksToBounds = YES;
        _lbPicCount.hidden = YES;
    }
    return _lbPicCount;
}


- (SDCycleScrollView*)cycleScrollView{
    if (!_cycleScrollView) {
        CGRect frame = CGRectMake(0, 0, DEVICEWIDTH, 320*RATIO_WIDHT320);
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        _cycleScrollView.showPageControl = NO;
        [_cycleScrollView addSubview:self.lbPicCount];
        _cycleScrollView.autoScroll = NO;
    }
    return _cycleScrollView;
}

- (ViewBtnGoods*)bottom{
    if(!_bottom){
        _bottom = [[ViewBtnGoods alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT - [ViewBtnGoods calHeight], DEVICEWIDTH,[ViewBtnGoods calHeight])];
        _bottom.delegate = self;
        [_bottom updateData];
    }
    return _bottom;
}
@end
