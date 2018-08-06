//
//  VCProxy.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCProxy.h"
#import "VCMain.h"
#import "AppDelegate.h"
#import "CellProxy.h"
#import "RequestBeanCustomer.h"

@interface VCProxy ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic,strong)UIView *vBg;
@property(nonatomic,strong)UITextField *tfSearch;
@property(nonatomic,strong)UIButton *btnArrow;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIButton *btnConfirm;
@property(nonatomic,assign)BOOL expland;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic,assign)BOOL selected;
@end

@implementation VCProxy

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    _dataSource = [NSMutableArray array];
    self.title = @"代理客户";
    [self.view addSubview:self.vBg];
    [self.view addSubview:self.table];
    [self.view addSubview:self.btnConfirm];
}

- (void)clickAction:(UIButton*)sender{
    if(sender.tag == 100){
        self.expland = !self.expland;
    }else{
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
                    [Utils saveUserInfo:mutDic];
                }
            }
            
            
            [self gotoHome];
        }else{
            [Utils showToast:@"请选择客户" with:self.view withTime:0.8];
        }
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
    requestBean.page_current = 1;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanCustomer *response = responseBean;
            if(response.success){
                [weakself.dataSource removeAllObjects];
                [weakself.dataSource addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
                [weakself.table reloadData];
            }
        }
    }];
}



- (void)loadRefreshData{
    RequestBeanCustomer *requestBean = [RequestBeanCustomer new];
    requestBean.user_login_name = [AppUser share].SYSUSER_ACCOUNT;
    if(self.keywords && self.keywords.length > 0){
        requestBean.customer_name = self.keywords;
    }else{
        requestBean.customer_name = nil;
    }
    requestBean.page_current = 1;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanCustomer *response = responseBean;
            if(response.success){
                [weakself.dataSource removeAllObjects];
                [weakself.dataSource addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
                [weakself.table reloadData];
            }
        }
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)search{
    self.keywords = self.tfSearch.text;
    self.expland = TRUE;
    [self loadData];
}

- (void)viewWillLayoutSubviews{
    CGRect r = self.vBg.frame;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = 20*RATIO_WIDHT320 + NAV_STATUS_HEIGHT;
    r.size.width = DEVICEWIDTH - 40*RATIO_WIDHT320;
    r.size.height = 34*RATIO_WIDHT320;
    self.vBg.frame = r;
    
    r = self.btnArrow.frame;
    r.size.width = self.vBg.height;
    r.size.height = self.vBg.height;
    r.origin.x = self.vBg.width - r.size.width;
    r.origin.y = 0;
    self.btnArrow.frame = r;
    
    r = self.tfSearch.frame;
    r.size.height = self.vBg.height;
    r.size.width = self.vBg.width - self.btnArrow.width - 20*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.vBg.height - r.size.height)/2.0;
    self.tfSearch.frame = r;
    
    r = self.table.frame;
    r.size.width = DEVICEWIDTH - 40*RATIO_WIDHT320;
    r.size.height = 170*RATIO_WIDHT320;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = self.vBg.bottom;
    self.table.frame = r;
    
    r = self.btnConfirm.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 40*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.vBg.bottom + 170*RATIO_WIDHT320 + 30*RATIO_WIDHT320;
    self.btnConfirm.frame = r;
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
    static NSString*identifier = @"CellProxy";
    CellProxy *cell = (CellProxy*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellProxy alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
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
    self.expland = !self.expland;
    NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
    [AppUser share].CUS_ID = [data jk_stringForKey:@"customer_id"];
    [AppUser share].CUS_NAME = [data jk_stringForKey:@"customer_name"];
    self.tfSearch.text = [data jk_stringForKey:@"customer_name"];
    self.selected = TRUE;
    self.btnConfirm.backgroundColor = APP_COLOR;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self search];
    return YES;
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.layer.borderColor = RGB3(224).CGColor;
        _table.layer.borderWidth = 0.5;
        _table.alpha = 0.f;
    }
    return _table;
}

- (UIView*)vBg{
    if(!_vBg){
        _vBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vBg.layer.borderColor = RGB3(224).CGColor;
        _vBg.layer.borderWidth = 0.5;
        [_vBg addSubview:self.tfSearch];
        [_vBg addSubview:self.btnArrow];
    }
    return _vBg;
}

- (void)setExpland:(BOOL)expland{
    _expland = expland;
    self.btnArrow.selected = expland;
    if(_expland){
        [UIView animateWithDuration:0.3 animations:^{
            self.table.alpha = 1.f;
        }];
        [self loadRefreshData];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.table.alpha = 0.f;
        }];
    }
}

- (UITextField*)tfSearch{
    if(!_tfSearch){
        _tfSearch = [[UITextField alloc]initWithFrame:CGRectZero];
        _tfSearch.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _tfSearch.textColor = APP_COLOR;
        _tfSearch.delegate = self;
        _tfSearch.returnKeyType = UIReturnKeySearch;
    }
    return _tfSearch;
}

- (UIButton*)btnArrow{
    if(!_btnArrow){
        _btnArrow = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnArrow setImage:[UIImage imageNamed:@"icon_up_normal"] forState:UIControlStateNormal];
        [_btnArrow setImage:[UIImage imageNamed:@"icon_down_normal"] forState:UIControlStateSelected];
        _btnArrow.tag = 100;
        [_btnArrow addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        CGRect r = _btnArrow.imageView.frame;
        r.size.width = 5*RATIO_WIDHT320;
        r.size.height = r.size.width;
        _btnArrow.imageView.frame = r;
    }
    return _btnArrow;
}

- (UIButton*)btnConfirm{
    if(!_btnConfirm){
        _btnConfirm = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        [_btnConfirm addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.backgroundColor = APP_COLOR;//APP_Gray_COLOR;
        _btnConfirm.tag = 101;
        _btnConfirm.layer.cornerRadius = 6.f;
    }
    return _btnConfirm;
}
@end
