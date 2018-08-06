//
//  VCCategory.m
//  LeftMaster
//
//  Created by simple on 2018/4/3.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCCategory.h"
#import "CellCategory.h"
#import "CollCellCategory.h"
#import "ViewCategory.h"
#import "HMScannerController.h"
#import "RequestBeanCategoryHome.h"
#import "RequestBeanGoodsList.h"
#import "VCGoodsList.h"
#import "RequestBeanQueryCartNum.h"
#import "VCSingleCart.h"
#import "VCSearchGoodsList.h"
#import "VCGoods.h"

@interface VCCategory ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout,CommonDelegate,UITextFieldDelegate>
@property(nonatomic,strong)ViewCategory *vCart;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UICollectionView *collView;
@property(nonatomic,strong)NSMutableArray *categorys;
@property(nonatomic,strong)NSMutableArray *goodsList;
@property(nonatomic,strong)NSString *keywords;
@property(nonatomic,assign)NSInteger page;
@end

@implementation VCCategory

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
    [self loadCartNumData];
}

- (void)initMain{
    self.view.backgroundColor = RGB3(247);
    self.title = @"分类";
    self.page = 1;
    _categorys = [NSMutableArray array];
    _goodsList = [NSMutableArray array];
    [self.view addSubview:self.vCart];
    [self.view addSubview:self.table];
    [self.view addSubview:self.collView];
    [self observeNotification:REFRESH_CART_LIST];
}


- (void)loadData{
    RequestBeanCategoryHome *requestBean = [RequestBeanCategoryHome new];
    requestBean.parent_id = @"0";
    requestBean.page_current = 1;
    requestBean.page_size = 100;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanCategoryHome *response = responseBean;
            [weakself.categorys removeAllObjects];
            [weakself.categorys addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
            [weakself.table reloadData];
            if(weakself.categorys && weakself.categorys.count > 0){
                if(self.cateId){
                    [weakself loadSubData];
                }else{
                    NSDictionary *first = [weakself.categorys firstObject];
                    if(first){
                        self.cateId = [first jk_stringForKey:@"GOODSTYPE_ID"];
                        [weakself loadSubData];
                    }
                }
            }
        }
    }];
}



- (void)loadSubData{
    RequestBeanCategoryHome *requestBean = [RequestBeanCategoryHome new];
    requestBean.parent_id = self.cateId;
    requestBean.page_current = self.page;
    requestBean.page_size = 20;
    if (self.keywords) {
        requestBean.search_name = self.keywords;
    }
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanCategoryHome *response = responseBean;
            [weakself.goodsList removeAllObjects];
            [weakself.goodsList addObjectsFromArray:[response.data jk_arrayForKey:@"rows"]];
            [weakself.collView reloadData];
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.categorys.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellCategory calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellCategory";
    CellCategory *cell = (CellCategory*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellCategory alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *data = [self.categorys objectAtIndex:indexPath.row];
    
    cell.isSelected = FALSE;
    if(self.cateId){
        if([[data jk_stringForKey:@"GOODSTYPE_ID"] isEqualToString:self.cateId]){
            cell.isSelected = TRUE;
        }
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
    NSDictionary *data = [self.categorys objectAtIndex:indexPath.row];
    self.cateId = [data jk_stringForKey:@"GOODSTYPE_ID"];
    [self loadSubData];
    [self.table reloadData];
}

#pragma mark Collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.goodsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CollCellCategory";
    CollCellCategory *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSDictionary *data = [self.goodsList objectAtIndex:indexPath.row];
    [cell updateData:data];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(73*RATIO_WIDHT320, [CollCellCategory calHeight]);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data = [self.goodsList objectAtIndex:indexPath.row];
    VCGoodsList *vc = [[VCGoodsList alloc]init];
    vc.cateId = [data jk_integerForKey:@"GOODSTYPE_ID"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (CGFloat)topHeight{
    return NAV_STATUS_HEIGHT + [ViewCategory calHeight] + 10*RATIO_WIDHT320;
}


#pragma mark CommanDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if(index == 0){
        [self clickQR];
    }else if(index == 1){
        VCSingleCart *vc = [[VCSingleCart alloc]init];
        [self.navigationController pushViewController:vc animated:TRUE];
    }else{
        VCSearchGoodsList *vc = [[VCSearchGoodsList alloc]init];
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:FALSE completion:^{
            
        }];
    }
}

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

- (ViewCategory*)vCart{
    if(!_vCart){
        _vCart = [[ViewCategory alloc]initWithFrame:CGRectMake(0, NAV_STATUS_HEIGHT, DEVICEWIDTH, [ViewCategory calHeight])];
        _vCart.delegate = self;
        [_vCart updateData];
    }
    return _vCart;
}


- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, [self topHeight], 73*RATIO_WIDHT320, DEVICEHEIGHT - [self topHeight]) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor whiteColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (UICollectionView*)collView{
    if(!_collView){
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10*RATIO_WIDHT320;
        layout.minimumInteritemSpacing = 3;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collView = [[UICollectionView alloc]initWithFrame:CGRectMake(73*RATIO_WIDHT320+10*RATIO_WIDHT320, [self topHeight], DEVICEWIDTH - 20*RATIO_WIDHT320 - 73*RATIO_WIDHT320, DEVICEHEIGHT - [self topHeight]) collectionViewLayout:layout];
        [_collView registerClass:[CollCellCategory class] forCellWithReuseIdentifier:@"CollCellCategory"];
//        _collView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collView.alwaysBounceVertical = YES;
        _collView.backgroundColor = [UIColor whiteColor];
        _collView.delegate = self;
        _collView.dataSource = self;
    }
    return _collView;
}


@end
