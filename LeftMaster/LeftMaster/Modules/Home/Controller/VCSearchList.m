//
//  VCSearchList.m
//  UMa
//
//  Created by yanyu on 2018/5/22.
//  Copyright © 2018年 yanyu. All rights reserved.
//

#import "VCSearchList.h"
#import "HeaderSearchHistory.h"
#import "SearchHistoryCell.h"
#import "CellSearchGoodsList.h"
#import "ViewSearchGoodsNav.h"
#import "RequestBeanGoodsList.h"
#import "VCGoods.h"


@interface VCSearchList () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UITextFieldDelegate,CommonDelegate>

@property(nonatomic,strong)ViewSearchGoodsNav *searchView;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)HeaderSearchHistory *header;

@property(nonatomic,strong)NSMutableArray *searchHistorys;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)BOOL isSearch;

@property(nonatomic, assign) NSInteger pageIndex;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)NSString *keywords;
@property(nonatomic,strong)EmptyView *emptyView;

@end

@implementation VCSearchList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

/**
 * 初始化主要数据及UI
 */
- (void)initMain{
    self.page = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    _searchHistorys = [NSMutableArray array];
    _dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    self.navigationItem.titleView = self.searchView;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    rightBtn.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [defaults objectForKey:HOME_SEARCH_HISTORY];
    if (array) {
        [self.searchHistorys addObjectsFromArray:array];
        [self reloadData];
    }
}

- (void)cancelAction{
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)addPullLoading{
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

- (void)reloadData{
    [self.table reloadData];
}

- (void)searchAction{
    [self addPullLoading];
    self.keywords = self.searchView.tfText.text;
    [self.searchView.tfText resignFirstResponder];
    self.isSearch = TRUE;
    //去重
    for (NSString *str in self.searchHistorys) {
        if ([str isEqualToString:self.keywords]) {
            [self.searchHistorys removeObject:str];
            break;
        }
    }
    if (self.keywords.length > 0) {
        [self.searchHistorys insertObject:self.keywords atIndex:0];
    }
    [self reloadData];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.searchHistorys forKey:HOME_SEARCH_HISTORY];
    [defaults synchronize];
    
    [self loadData];
    
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
                    [weakself.dataSource removeAllObjects];
                }
                NSArray *datas = [response.data jk_arrayForKey:@"rows"];
                if(datas.count == 0 || datas.count < requestBean.page_size){
                    [weakself.table.mj_footer endRefreshingWithNoMoreData];
                    weakself.table.mj_footer.hidden = TRUE;
                }else{
                    [weakself.table.mj_footer resetNoMoreData];
                    weakself.table.mj_footer.hidden = FALSE;
                }
                [weakself.dataSource addObjectsFromArray:datas];
                [weakself.table reloadData];
            }
        }else{
            weakself.table.mj_footer.hidden = TRUE;
            [weakself.table.mj_footer endRefreshingWithNoMoreData];
            
        }
    }];
}

- (void)viewWillLayoutSubviews{
    CGRect r = self.searchView.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = DEVICEWIDTH;
    self.searchView.frame = r;
}

#pragma  mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isSearch) {
        return self.dataSource.count;
    }
    return self.searchHistorys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        return [CellSearchGoodsList calHeight];
    }
    return [SearchHistoryCell calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        static NSString*identifier = @"Cell";
        CellSearchGoodsList *cell = (CellSearchGoodsList*)[tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CellSearchGoodsList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
        [cell updateData:data];
        return cell;
    }
    static NSString *identifier = @"SearchHistoryCell";
    SearchHistoryCell *cell = (SearchHistoryCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[SearchHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell updateData:[self.searchHistorys objectAtIndex:indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isSearch) {
        
        NSDictionary *data = [self.dataSource objectAtIndex:indexPath.row];
        VCGoods *vc = [[VCGoods alloc]init];
        vc.goods_id = [data jk_stringForKey:@"GOODS_ID"];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSString *str = [self.searchHistorys objectAtIndex:indexPath.row];
        self.isSearch = TRUE;
        self.searchView.tfText.text = str;
        self.keywords = str;
        [self loadData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!self.isSearch) {
        return 50*RATIO_WIDHT750;
    }
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.isSearch) {
        return self.header;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchView.tfText resignFirstResponder];
}

#pragma mark - CommonDelete
- (void)clickActionWithIndex:(NSInteger)index{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:HOME_SEARCH_HISTORY];
    [self.searchHistorys removeAllObjects];
    [self reloadData];
}

-
(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    [self searchAction];
    return YES;
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = RGB3(247);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}


- (HeaderSearchHistory*)header{
    if(!_header){
        _header = [[HeaderSearchHistory alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 50*RATIO_WIDHT750)];
        _header.backgroundColor = [UIColor whiteColor];
        _header.delegate = self;
    }
    return _header;
}


- (ViewSearchGoodsNav*)searchView{
    if(!_searchView){
        _searchView = [[ViewSearchGoodsNav alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewSearchGoodsNav calHeight])];
        _searchView.tfText.returnKeyType = UIReturnKeySearch;
        _searchView.tfText.delegate = self;
    }
    return _searchView;
}


- (EmptyView*)emptyView{
    if(!_emptyView){
        _emptyView = [[EmptyView alloc]init];
    }
    return _emptyView;
}
@end
