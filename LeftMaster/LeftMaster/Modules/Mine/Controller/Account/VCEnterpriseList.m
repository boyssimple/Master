//
//  VCEnterpriseList.m
//  LeftMaster
//
//  Created by simple on 2018/8/13.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCEnterpriseList.h"
#import "CellEnterpriseList.h"
#import "VCEnterpriseAccountBind.h"

@interface VCEnterpriseList ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSMutableArray *results;

@end

@implementation VCEnterpriseList
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"企业帐户绑定";
    
    self.title = @"企业帐户绑定";
    _datas = [NSMutableArray arrayWithCapacity:0];
    _results = [NSMutableArray arrayWithCapacity:0];
    [self.view addSubview:self.table];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"添加帐户" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    for (int i = 0; i < 100; i++) {
        
        NSString *str = [NSString stringWithFormat:@"测试数据%d", i];
        
        [self.datas addObject:str];
    }
    
    // 创建UISearchController, 这里使用当前控制器来展示结果
    UISearchController *search = [[UISearchController alloc]initWithSearchResultsController:nil];
    // 设置结果更新代理
    search.searchResultsUpdater = self;
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    search.dimsBackgroundDuringPresentation = NO;
    // 是否自动隐藏导航
    //    search.hidesNavigationBarDuringPresentation = NO;
    self.searchController = search;
    // 将searchBar赋值给tableView的tableHeaderView
    self.table.tableHeaderView = search.searchBar;
    
    search.searchBar.delegate = self;
}


- (void)rightButtonClick{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请确认选择绑定的账户是您的企业账户避免财产上的损失" message:@"企业帐户名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active) {
        
        return self.results.count ;
    }
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellEnterpriseList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellEnterpriseList";
    CellEnterpriseList *cell = (CellEnterpriseList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellEnterpriseList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    // 这里通过searchController的active属性来区分展示数据源是哪个
    if (self.searchController.active ) {
        
        cell.lbName.text = [self.results objectAtIndex:indexPath.row];
    } else {
        
        cell.lbName.text = [self.datas objectAtIndex:indexPath.row];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchController.active) {
        NSLog(@"选择了搜索结果中的%@", [self.results objectAtIndex:indexPath.row]);
    } else {
        
        NSLog(@"选择了列表中的%@", [self.datas objectAtIndex:indexPath.row]);
    }
    
}


#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *inputStr = searchController.searchBar.text ;
    if (self.results.count > 0) {
        [self.results removeAllObjects];
    }
    for (NSString *str in self.datas) {
        
        if ([str.lowercaseString rangeOfString:inputStr.lowercaseString].location != NSNotFound) {
            
            [self.results addObject:str];
        }
    }
    
    [self.table reloadData];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    VCEnterpriseAccountBind *vc = [[VCEnterpriseAccountBind alloc]init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}
@end
