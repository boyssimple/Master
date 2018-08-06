//
//  ViewTabOrder.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewTabOrder.h"
@interface ViewTabOrder()
@property (nonatomic, strong) UIButton *btnUnConfirm;
@property (nonatomic, strong) UIButton *btnUnAudi;
@property (nonatomic, strong) UIButton *btnUnSend;
@property (nonatomic, strong) UIButton *btnUnReceive;
@property (nonatomic, strong) UIButton *btnAll;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIView *vBottomLine;
@end

@implementation ViewTabOrder

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat m = 10*RATIO_WIDHT320;
        CGFloat w = (DEVICEWIDTH - m*6)/5.0;
        
        _btnUnConfirm = [[UIButton alloc]initWithFrame:CGRectMake(m, 0, w, self.height)];
        [_btnUnConfirm setTitle:@"待确定" forState:UIControlStateNormal];
        [_btnUnConfirm setTitleColor:RGB3(153) forState:UIControlStateNormal];
        _btnUnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        [_btnUnConfirm addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnUnConfirm.tag = 100;
        [self addSubview:_btnUnConfirm];
        
        _btnUnAudi = [[UIButton alloc]initWithFrame:CGRectMake(_btnUnConfirm.right+m, 0, w, self.height)];
        [_btnUnAudi setTitle:@"待审核" forState:UIControlStateNormal];
        [_btnUnAudi setTitleColor:RGB3(153) forState:UIControlStateNormal];
        _btnUnAudi.titleLabel.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        [_btnUnAudi addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnUnAudi.tag = 101;
        [self addSubview:_btnUnAudi];
        
        _btnUnSend = [[UIButton alloc]initWithFrame:CGRectMake(_btnUnAudi.right+m, 0, w, self.height)];
        [_btnUnSend setTitle:@"待发货" forState:UIControlStateNormal];
        [_btnUnSend setTitleColor:RGB3(153) forState:UIControlStateNormal];
        _btnUnSend.titleLabel.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        [_btnUnSend addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnUnSend.tag = 102;
        [self addSubview:_btnUnSend];
        
        _btnUnReceive = [[UIButton alloc]initWithFrame:CGRectMake(_btnUnSend.right+m, 0, w, self.height)];
        [_btnUnReceive setTitle:@"待收货" forState:UIControlStateNormal];
        [_btnUnReceive setTitleColor:RGB3(153) forState:UIControlStateNormal];
        _btnUnReceive.titleLabel.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        [_btnUnReceive addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnUnReceive.tag = 103;
        [self addSubview:_btnUnReceive];
        
        _btnAll = [[UIButton alloc]initWithFrame:CGRectMake(_btnUnReceive.right+m, 0, w, self.height)];
        [_btnAll setTitle:@"全部" forState:UIControlStateNormal];
        [_btnAll setTitleColor:RGB3(153) forState:UIControlStateNormal];
        _btnAll.titleLabel.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        [_btnAll addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnAll.tag = 104;
        [self addSubview:_btnAll];
        
        _vBottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, DEVICEWIDTH, 0.5)];
        _vBottomLine.backgroundColor = RGB3(197);
        [self addSubview:_vBottomLine];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectMake(0, _vBottomLine.top - 1.5*RATIO_WIDHT320, 19*RATIO_WIDHT320, 1.5*RATIO_WIDHT320)];
        _vLine.backgroundColor = APP_COLOR;
        [self addSubview:_vLine];
    }
    
    return self;
}

- (void)setCurIndex:(NSInteger)curIndex{
    _curIndex = curIndex;
    NSInteger tag = 100+curIndex;
    UIButton *btn = (UIButton*)[self viewWithTag:tag];
    NSArray *subs = self.subviews;
    for (UIView *v in subs) {
        if([v isKindOfClass:[UIButton class]]){
            NSInteger t = v.tag;
            UIButton *b = (UIButton*)v;
            if(t != tag){
                [b setTitleColor:RGB3(153) forState:UIControlStateNormal];
            }else{
                [b setTitleColor:RGB3(0) forState:UIControlStateNormal];
            }
        }
    }
    
    CGFloat x = btn.left + (btn.width - 19*RATIO_WIDHT320)/2.0;
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.vLine.left = x;
    }];
}

- (void)clickAction:(UIButton*)sender{
    NSInteger index = sender.tag - 100;
    self.curIndex = index;
    if([self.delegate respondsToSelector:@selector(clickTab:)]){
        [self.delegate clickTab:index];
    }
}

- (void)updateData{
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

+ (CGFloat)calHeight{
    return 37*RATIO_WIDHT320;
}

@end
