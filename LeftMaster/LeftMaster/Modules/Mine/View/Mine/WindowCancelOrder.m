//
//  WindowGuide.m
//  LeftMaster
//
//  Created by simple on 2018/4/19.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "WindowCancelOrder.h"
#import "CellCancelOrder.h"
#import "ViewHeaderCancelOrder.h"
#import "Reason.h"

@interface WindowCancelOrder()<UITableViewDelegate,UITableViewDataSource,CommonDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIButton* btnSubmit;

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIButton *btnClose;
@property(nonatomic,strong)ViewHeaderCancelOrder *header;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)Reason *reason;
@end

@implementation WindowCancelOrder

- (id)init
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        _dataSource = [NSMutableArray array];
        
        Reason *reason1 = [[Reason alloc]init];
        reason1.text = @"订单不能按预计时间送达";
        [_dataSource addObject:reason1];
        
        Reason *reason2 = [[Reason alloc]init];
        reason2.text = @"重复下单/误下单";
        [_dataSource addObject:reason2];
        
        Reason *reason3 = [[Reason alloc]init];
        reason3.text = @"不想买了";
        [_dataSource addObject:reason3];
        
        Reason *reason4 = [[Reason alloc]init];
        reason4.text = @"其他";
        [_dataSource addObject:reason4];
        
        cancelOrderWindow = self;
        [self setupSubviews];
    }
    
    return self;
}


- (void)setupSubviews{
    _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
    _grayView.backgroundColor = [UIColor blackColor];
    _grayView.alpha = 0;
    _grayView.userInteractionEnabled = YES;
    [self addSubview:_grayView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [_grayView addGestureRecognizer:tap];
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT, DEVICEWIDTH, 300*RATIO_WIDHT320)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_mainView];
    
    _lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(25*RATIO_WIDHT320, 0, DEVICEWIDTH - 50*RATIO_WIDHT320, 30*RATIO_WIDHT320)];
    _lbTitle.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    _lbTitle.textColor = [UIColor grayColor];
    _lbTitle.text = @"取消订单";
    _lbTitle.textAlignment = NSTextAlignmentCenter;
    [_mainView addSubview:_lbTitle];
    
    _btnClose = [[UIButton alloc]initWithFrame:CGRectMake(DEVICEWIDTH - 25*RATIO_WIDHT320, 0, 25*RATIO_WIDHT320, 30*RATIO_WIDHT320)];
    [_btnClose setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [_btnClose addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_btnClose];
    
    _btnSubmit = [[UIButton alloc]initWithFrame:CGRectMake(0, self.mainView.height - 40*RATIO_WIDHT320, DEVICEWIDTH, 40*RATIO_WIDHT320)];
    [_btnSubmit setTitle:@"提交" forState:UIControlStateNormal];
    [_btnSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSubmit.backgroundColor = RGB3(205);
    _btnSubmit.enabled = FALSE;
    [_btnSubmit addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [_mainView addSubview:_btnSubmit];
    
    _header = [[ViewHeaderCancelOrder alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewHeaderCancelOrder calHeight])];
    [_header updateData];
    [self addSubview:_header];
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, _lbTitle.bottom, DEVICEWIDTH, _mainView.height - _lbTitle.bottom - _btnSubmit.height) style:UITableViewStyleGrouped];
    _table.backgroundColor = [UIColor whiteColor];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    _table.tableHeaderView = _header;
    [_mainView addSubview:_table];
}

- (void)submitAction{
    if (self.reason) {
        [self dismiss];
        if([self.delegate respondsToSelector:@selector(selectReason:)]){
            [self.delegate selectReason:self.reason.text];
        }
    }
}

- (void)dealloc{
    NSLog(@"[DEBUG] delloc:%@",self);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellCancelOrder calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"Cell";
    CellCancelOrder *cell = (CellCancelOrder*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellCancelOrder alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.index = indexPath.row;
    Reason *data = [self.dataSource objectAtIndex:indexPath.row];
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
    
}

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    self.btnSubmit.backgroundColor = APP_COLOR;
    self.reason = [self.dataSource objectAtIndex:index];
    NSInteger i = 0;
    for (Reason *r in self.dataSource) {
        if(i == index){
            r.selected = TRUE;
        }else{
            r.selected = FALSE;
        }
        i++;
    }
    [self.table reloadData];
    self.btnSubmit.enabled = TRUE;
}

- (void)show {
    [self makeKeyAndVisible];
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.grayView.alpha = 0.4;
        weakself.mainView.top = DEVICEHEIGHT - 300*RATIO_WIDHT320;
    }];
}

- (void)dismiss {
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        cancelOrderWindow.alpha = 0;
        weakself.mainView.top = DEVICEHEIGHT;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            weakself.grayView.alpha = 0;
        } completion:^(BOOL finished) {
            [cancelOrderWindow removeAllSubviews];
            cancelOrderWindow = nil;
            [self resignKeyWindow];
        }];
    }];
    
}

@end
