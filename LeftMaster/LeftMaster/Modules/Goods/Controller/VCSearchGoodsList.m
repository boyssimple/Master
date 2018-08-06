//
//  VCSearchGoodsList.m
//  LeftMaster
//
//  Created by simple on 2018/4/23.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCSearchGoodsList.h"
#import "ViewSearchGoodsNav.h"
#import "CellSearchGoodsList.h"
#import "RequestBeanGoodsList.h"
#import "VCGoods.h"

@interface VCSearchGoodsList ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)ViewSearchGoodsNav *searchView;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic,assign)NSInteger page;
@property(nonatomic,strong)NSMutableArray *goodsList;
@end

@implementation VCSearchGoodsList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.page = 1;
    _goodsList = [NSMutableArray array];
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
    UILabel *lbCancel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 44)];
    lbCancel.text = @"取消";
    lbCancel.textColor = [UIColor blackColor];
    lbCancel.font = [UIFont systemFontOfSize:14];
    lbCancel.textAlignment = NSTextAlignmentRight;
    lbCancel.userInteractionEnabled = YES;
    [customView addSubview:lbCancel];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelAction)];
    [customView addGestureRecognizer:tap];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self.view addSubview:self.table];
    self.navigationItem.titleView = self.searchView;
}

- (void)loadData{
    RequestBeanGoodsList *requestBean = [RequestBeanGoodsList new];
    requestBean.page_current = self.page;
    requestBean.cus_id = [AppUser share].CUS_ID;
    requestBean.company_id = [AppUser share].SYSUSER_COMPANYID;
    requestBean.new_goods = FALSE;
    requestBean.page_size = 10;
    if(self.keywords && self.keywords.length > 0){
        requestBean.search_name = self.keywords;
    }else{
        requestBean.search_name = nil;
    }
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [weakself.table.mj_header endRefreshing];
        [weakself.table.mj_footer endRefreshing];
        [Utils hiddenHanding:self.view withTime:0.5];
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
        }else{
            weakself.table.mj_footer.hidden = TRUE;
            [weakself.table.mj_footer endRefreshingWithNoMoreData];
            
        }
    }];
}

- (void)search{
    self.page = 1;
    self.keywords = self.searchView.tfText.text;
    [self loadData];
}


- (void)cancelAction{
    [self dismissViewControllerAnimated:TRUE completion:^{
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self search];
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellSearchGoodsList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"Cell";
    CellSearchGoodsList *cell = (CellSearchGoodsList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellSearchGoodsList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
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
        _table.mj_footer.hidden = YES;
    }
    return _table;
}

- (ViewSearchGoodsNav*)searchView{
    if(!_searchView){
        _searchView = [[ViewSearchGoodsNav alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewSearchGoodsNav calHeight])];
        _searchView.tfText.returnKeyType = UIReturnKeySearch;
        _searchView.tfText.delegate = self;
    }
    return _searchView;
}

@end
