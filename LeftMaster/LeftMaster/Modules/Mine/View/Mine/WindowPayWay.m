//
//  WindowGuide.m
//  LeftMaster
//
//  Created by simple on 2018/4/19.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "WindowPayWay.h"
#import "ViewPayWay.h"

@interface WindowPayWay()
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIButton* btnSubmit;

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIButton *btnClose;
@property(nonatomic,assign)BOOL isRightNowPay;
@property(nonatomic,assign)BOOL isWaitPay;

@property(nonatomic,strong)ViewPayWay *rightNowPay;
@property(nonatomic,strong)ViewPayWay *waitPay;
@end

@implementation WindowPayWay

- (id)init
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        selectPayWayWindow = self;
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
    _mainView.backgroundColor = APP_Gray_COLOR;
    [self addSubview:_mainView];
    
    _lbTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, 40*RATIO_WIDHT320)];
    _lbTitle.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
    _lbTitle.textColor = [UIColor blackColor];
    _lbTitle.backgroundColor = [UIColor whiteColor];
    _lbTitle.text = @"支付方式";
    _lbTitle.textAlignment = NSTextAlignmentCenter;
    [_mainView addSubview:_lbTitle];
    
    _btnClose = [[UIButton alloc]initWithFrame:CGRectMake(DEVICEWIDTH - 35*RATIO_WIDHT320, 0, 35*RATIO_WIDHT320, 40*RATIO_WIDHT320)];
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
    
    
    self.rightNowPay = [[ViewPayWay alloc]initWithFrame:CGRectMake(0, _lbTitle.bottom + 10*RATIO_WIDHT320, DEVICEWIDTH, [ViewPayWay calHeight])];
    self.rightNowPay.tag = 100;
    __weak typeof(self) weakself = self;
    self.rightNowPay.clickBlock = ^(NSInteger index,BOOL selected) {
        [weakself handleClick:index with:selected];
    };
    [_mainView addSubview:self.rightNowPay];
    [self.rightNowPay updateData:@"立即支付" withDesc:@"立即支付可让您购买的宝贝早日到您身边"];
    
    self.waitPay = [[ViewPayWay alloc]initWithFrame:CGRectMake(0, self.rightNowPay.bottom + 10*RATIO_WIDHT320, DEVICEWIDTH, [ViewPayWay calHeight])];
    self.waitPay.tag = 101;
    self.waitPay.clickBlock = ^(NSInteger index,BOOL selected) {
        [weakself handleClick:index with:selected];
    };
    [_mainView addSubview:self.waitPay];
    [self.waitPay updateData:@"稍后支付" withDesc:@"稍后支付需要等业务人员审核"];
}

- (void)handleClick:(NSInteger)index with:(BOOL)selected{
    if(index == 100){
        self.isRightNowPay = selected;
        if(self.isRightNowPay){
            self.isWaitPay = FALSE;
            self.waitPay.btnCheck.selected = FALSE;
        }
    }else {
        self.isWaitPay = selected;
        if(self.isWaitPay){
            self.isRightNowPay = FALSE;
            self.rightNowPay.btnCheck.selected = FALSE;
        }
    }
    if(self.isRightNowPay || self.isWaitPay){
        self.btnSubmit.backgroundColor = APP_COLOR;
        self.btnSubmit.enabled = TRUE;
    }else{
        
        self.btnSubmit.backgroundColor = RGB3(205);
        self.btnSubmit.enabled = FALSE;
    }
}

- (void)submitAction{
    [self dismiss];
    if (self.clickBlock) {
        if(self.isRightNowPay){
            self.clickBlock(0);
        }else if(self.isWaitPay){
            self.clickBlock(1);
        }
    }
}

- (void)dealloc{
    NSLog(@"[DEBUG] delloc:%@",self);
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
        selectPayWayWindow.alpha = 0;
        weakself.mainView.top = DEVICEHEIGHT;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            weakself.grayView.alpha = 0;
        } completion:^(BOOL finished) {
            [selectPayWayWindow removeAllSubviews];
            selectPayWayWindow = nil;
            [self resignKeyWindow];
        }];
    }];
    
}

@end
