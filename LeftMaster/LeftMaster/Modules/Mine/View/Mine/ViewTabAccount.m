//
//  ViewTabOrder.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewTabAccount.h"
@interface ViewTabAccount()
@property (nonatomic, strong) UIButton *btnUnConfirm;
@property (nonatomic, strong) UIButton *btnUnAudi;
@property (nonatomic, strong) UIButton *btnUnSend;
@property (nonatomic, strong) UIButton *btnUnReceive;
@property (nonatomic, strong) UIButton *btnAll;
@property (nonatomic, strong) UIView *vLine;
@property (nonatomic, strong) UIView *vBottomLine;
@end

@implementation ViewTabAccount

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _vBottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, DEVICEWIDTH, 0.5)];
        _vBottomLine.backgroundColor = RGB3(197);
        [self addSubview:_vBottomLine];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectZero];
        [btn setTitle:@"已完成" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT750];
        CGFloat width = [btn.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        _vLine = [[UIView alloc]initWithFrame:CGRectMake(0, _vBottomLine.top - 1.5*RATIO_WIDHT750, width, 1.5*RATIO_WIDHT750)];
        _vLine.backgroundColor = APP_COLOR;
        [self addSubview:_vLine];
    }
    
    return self;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self loadViews];
}
- (void)loadViews{
    CGFloat m = 10*RATIO_WIDHT750;
    CGFloat w = (DEVICEWIDTH - m*(self.dataSource.count+1))/self.dataSource.count;
    for (NSInteger i = 0; i< self.dataSource.count; i++) {
        
        _btnUnConfirm = [[UIButton alloc]initWithFrame:CGRectMake(m*(i+1) + i*w, 0, w, self.height - 5)];
        [_btnUnConfirm setTitle:[self.dataSource objectAtIndex:i] forState:UIControlStateNormal];
        [_btnUnConfirm setTitleColor:RGB3(153) forState:UIControlStateNormal];
        _btnUnConfirm.titleLabel.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT750];
        [_btnUnConfirm addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnUnConfirm.tag = 100+i;
        [self addSubview:_btnUnConfirm];
        
        if (self.curIndex == i) {
            [self setCurIndex:i];
        }
    }
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
                [b setTitleColor:APP_COLOR forState:UIControlStateNormal];
            }
        }
    }
    
    CGFloat x = btn.left + (btn.width - self.vLine.width)/2.0;
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
    return 40*RATIO_WIDHT750;
}

@end
