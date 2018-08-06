//
//  WindowGuide.m
//  LeftMaster
//
//  Created by simple on 2018/4/19.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "WindowCustom.h"
#import "CellCustom.h"
#import "ViewHeaderCancelOrder.h"

#define WindowCustomHeight  250

@interface WindowCustom()<UITableViewDelegate,UITableViewDataSource,CommonDelegate>
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIButton* btnSubmit;

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIButton *btnClose;
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)Custom *cust;
@end

@implementation WindowCustom

- (id)init:(NSArray*)dataSource
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        customWindow = self;
        self.dataSource = dataSource;
        for (Custom *cu in self.dataSource) {
            if(cu.selected){
                self.cust = cu;
                break;
            }
        }
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
    
    _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, DEVICEHEIGHT, DEVICEWIDTH, WindowCustomHeight*RATIO_WIDHT320)];
    _mainView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_mainView];
    
    _lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(25*RATIO_WIDHT320, 0, DEVICEWIDTH - 50*RATIO_WIDHT320, 30*RATIO_WIDHT320)];
    _lbTitle.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    _lbTitle.textColor = [UIColor grayColor];
    _lbTitle.text = @"选择开票单位";
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
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, _lbTitle.bottom, DEVICEWIDTH, _mainView.height - _lbTitle.bottom - _btnSubmit.height) style:UITableViewStyleGrouped];
    _table.backgroundColor = [UIColor whiteColor];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.delegate = self;
    _table.dataSource = self;
    [_mainView addSubview:_table];
    
    if (self.cust) {
        [self selectButton];
    }
}

- (void)submitAction{
    if (self.cust) {
        [self dismiss];
        if([self.delegate respondsToSelector:@selector(selectCustom:)]){
            [self.delegate selectCustom:self.cust];
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
    return [CellCustom calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"Cell";
    CellCustom *cell = (CellCustom*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellCustom alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate = self;
    }
    cell.index = indexPath.row;
    Custom *data = [self.dataSource objectAtIndex:indexPath.row];
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
    self.cust = [self.dataSource objectAtIndex:index];
    NSInteger i = 0;
    for (Custom *r in self.dataSource) {
        if(i == index){
            r.selected = TRUE;
        }else{
            r.selected = FALSE;
        }
        i++;
    }
    
    [self selectButton];
    [self.table reloadData];
}

- (void)selectButton{
    self.btnSubmit.backgroundColor = APP_COLOR;
    self.btnSubmit.enabled = TRUE;
}

- (void)show {
    [self makeKeyAndVisible];
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.grayView.alpha = 0.4;
        weakself.mainView.top = DEVICEHEIGHT - WindowCustomHeight*RATIO_WIDHT320;
    }];
}

- (void)dismiss {
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        customWindow.alpha = 0;
        weakself.mainView.top = DEVICEHEIGHT;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            weakself.grayView.alpha = 0;
        } completion:^(BOOL finished) {
            [customWindow removeAllSubviews];
            customWindow = nil;
            [self resignKeyWindow];
        }];
    }];
    
}

@end
