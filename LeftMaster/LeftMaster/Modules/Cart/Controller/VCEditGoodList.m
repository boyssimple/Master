//
//  VCCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCEditGoodList.h"
#import "CellEditGoodList.h"
#import "ViewTotalCart.h"
#import "VCWriteOrder.h"
#import "VCWriteOrder.h"
#import "RequestBeanCartList.h"
#import "VCGoods.h"
#import "CartGoods.h"
#import "RequestBeanDelCart.h"

@interface VCEditGoodList ()<UITableViewDelegate,UITableViewDataSource,CommonDelegate>
@property(nonatomic,strong)UITableView *table;
@end

@implementation VCEditGoodList

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"编辑商品";
    [self.view addSubview:self.table];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellEditGoodList calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellEditGoodList";
    CellEditGoodList *cell = (CellEditGoodList*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellEditGoodList alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
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

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index withDataIndex:(NSInteger)dataIndex{
    if(index == 0){
        //减数量request
        CartGoods *data = [self.goodsList objectAtIndex:dataIndex];
        if(data.FD_NUM == 1){
            [self.goodsList removeObject:data];
        }else{
            data.FD_NUM -= 1;
        }
        [self.table reloadData];
        [self.superVC reloadDatas:self.goodsList];
    }else if(index == 1){
        //加数量request
        CartGoods *data = [self.goodsList objectAtIndex:dataIndex];
        data.FD_NUM += 1;
        [self.goodsList replaceObjectAtIndex:dataIndex withObject:data];
        [self.table reloadData];
        [self.superVC reloadDatas:self.goodsList];
    }else if(index == 2){
        //加数量request
        [self.goodsList removeObjectAtIndex:dataIndex];
        [self.table reloadData];
        [self.superVC reloadDatas:self.goodsList];
    }
}



- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

@end
