//
//  ViewOrderRecGoodsList.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewOrderRecGoodsList.h"
#import "ViewBtnRecGoodsList.h"

@interface ViewOrderRecGoodsList()
@property(nonatomic,strong)ViewBtnRecGoodsList *btnCom;
@property(nonatomic,strong)ViewBtnRecGoodsList *btnPrice;
@property(nonatomic,strong)UIView *vLine;
@end
@implementation ViewOrderRecGoodsList

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        _btnCom = [[ViewBtnRecGoodsList alloc]initWithFrame:CGRectZero];
        _btnCom.tag = 100;
        [_btnCom updateData:@"综合"];
        [self addSubview:_btnCom];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOrder:)];
        [_btnCom addGestureRecognizer:tap];
        
        _btnPrice = [[ViewBtnRecGoodsList alloc]initWithFrame:CGRectZero];
        _btnPrice.tag = 101;
        [_btnPrice updateData:@"价格"];
        [self addSubview:_btnPrice];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickOrder:)];
        [_btnPrice addGestureRecognizer:tap1];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(231);
        [self addSubview:_vLine];
    }
    return self;
}

- (void)clickOrder:(UIGestureRecognizer*)ges{
    ViewBtnRecGoodsList *v = (ViewBtnRecGoodsList*)ges.view;
    self.btnCom.isSelected = NO;
    self.btnPrice.isSelected = NO;
    
    v.isSelected = YES;
    
    v.isAsc = !v.isAsc;
    if ([self.delegate respondsToSelector:@selector(clickOrder:withState:)]) {
        [self.delegate clickOrder:v.tag - 100 withState:v.isAsc];
    }
}



- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.btnCom.frame;
    r.origin.x = 62*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size.width = [ViewBtnRecGoodsList calWidth];
    r.size.height = self.height;
    self.btnCom.frame = r;
    
    r = self.btnPrice.frame;
    r.origin.x = DEVICEWIDTH - [ViewBtnRecGoodsList calWidth] - 62*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size.width = [ViewBtnRecGoodsList calWidth];
    r.size.height = self.height;
    self.btnPrice.frame = r;
    
    r = self.vLine.frame;
    r.origin.x = 0;
    r.origin.y = self.height - 0.5;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 38*RATIO_WIDHT320 + 0.5;
}

@end
