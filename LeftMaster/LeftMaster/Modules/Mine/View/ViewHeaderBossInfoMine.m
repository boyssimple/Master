//
//  ViewHeaderBossInfoMine.m
//  LeftMaster
//
//  Created by simple on 2018/8/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewHeaderBossInfoMine.h"
#import "VCUnPayOrderList.h"

@interface ViewHeaderBossInfoMine()
@property(nonatomic,strong)UILabel *lbLineOfCredit;
@property(nonatomic,strong)UILabel *lbLineOfCreditText;
@property(nonatomic,strong)UILabel *lbUseOfCredit;
@property(nonatomic,strong)UILabel *lbUseOfCreditText;

@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UILabel *lbMonthArrears;
@property(nonatomic,strong)UILabel *lbMonthArrearsText;

@property(nonatomic,strong)UIButton *btnRight;

@property(nonatomic,strong)UIView *vLineTwo;
@end
@implementation ViewHeaderBossInfoMine

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lbLineOfCredit = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbLineOfCredit.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbLineOfCredit.textColor = RGB(0, 0, 0);
        _lbLineOfCredit.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbLineOfCredit];
        
        _lbLineOfCreditText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbLineOfCreditText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbLineOfCreditText.textColor = [UIColor grayColor];
        _lbLineOfCreditText.text = @"授信额度";
        _lbLineOfCreditText.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbLineOfCreditText];
        
        _lbUseOfCredit = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbUseOfCredit.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbUseOfCredit.textColor = RGB(0, 0, 0);
        _lbUseOfCredit.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbUseOfCredit];
        
        _lbUseOfCreditText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbUseOfCreditText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbUseOfCreditText.textColor = [UIColor grayColor];
        _lbUseOfCreditText.text = @"可用额度";
        _lbUseOfCreditText.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbUseOfCreditText];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = APP_Gray_COLOR;
        [self addSubview:_vLine];
        
        _lbMonthArrears = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbMonthArrears.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbMonthArrears.textColor = RGB(0, 0, 0);
        _lbMonthArrears.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbMonthArrears];
        
        _lbMonthArrearsText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbMonthArrearsText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbMonthArrearsText.textColor = [UIColor grayColor];
        _lbMonthArrearsText.text = @"本月欠款";
        _lbMonthArrearsText.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbMonthArrearsText];
        
        _btnRight = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnRight addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnRight];
        
        _vLineTwo = [[UIView alloc]initWithFrame:CGRectZero];
        _vLineTwo.backgroundColor = APP_Gray_COLOR;
        [self addSubview:_vLineTwo];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    VCUnPayOrderList *vc = [[VCUnPayOrderList alloc]init];
    vc.hidesBottomBarWhenPushed = TRUE;
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)updateData{
    self.lbLineOfCredit.text = @"10000.00";
    self.lbUseOfCredit.text = @"100000.00";
    self.lbMonthArrears.text = @"0.00";
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbMonthArrears sizeThatFits:CGSizeMake(100*RATIO_WIDHT320, MAXFLOAT)];
    CGRect r = self.lbMonthArrears.frame;
    r.size.width = 100*RATIO_WIDHT320;
    r.size.height = size.height;
    r.origin.x = DEVICEWIDTH - r.size.width;
    r.origin.y = 0;
    self.lbMonthArrears.frame = r;
    
    size = [self.lbMonthArrearsText sizeThatFits:CGSizeMake(self.lbMonthArrears.width, MAXFLOAT)];
    r = self.lbMonthArrearsText.frame;
    r.size.width = self.lbMonthArrears.width;
    r.size.height = size.height;
    r.origin.x = self.lbMonthArrears.left;
    r.origin.y = 0;
    self.lbMonthArrearsText.frame = r;
    
    self.lbMonthArrears.top = ((self.height-8*RATIO_WIDHT320) - self.lbMonthArrears.height - 15*RATIO_WIDHT320 - self.lbMonthArrearsText.height)/2.0;
    self.lbMonthArrearsText.top = self.lbMonthArrears.bottom + 15*RATIO_WIDHT320;
    
    r = self.btnRight.frame;
    r.size.width = 100*RATIO_WIDHT320;
    r.size.height = self.height - 8*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width;
    r.origin.y = 0;
    self.btnRight.frame = r;
    
    r = self.vLine.frame;
    r.size.width = 1;
    r.size.height = self.lbMonthArrearsText.bottom - self.lbMonthArrears.top;
    r.origin.x = self.lbMonthArrears.left - r.size.width;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.vLine.frame = r;
    
    CGFloat w = self.vLine.left/2.0;
    size = [self.lbLineOfCredit sizeThatFits:CGSizeMake(w, MAXFLOAT)];
    r = self.lbLineOfCredit.frame;
    r.size.width = w;
    r.size.height = size.height;
    r.origin.x = 0;
    r.origin.y = 0;
    self.lbLineOfCredit.frame = r;
    
    size = [self.lbLineOfCreditText sizeThatFits:CGSizeMake(self.lbLineOfCredit.width, MAXFLOAT)];
    r = self.lbLineOfCreditText.frame;
    r.size.width = self.lbLineOfCredit.width;
    r.size.height = size.height;
    r.origin.x = 0;
    r.origin.y = 0;
    self.lbLineOfCreditText.frame = r;
    
    self.lbLineOfCredit.top = ((self.height-8*RATIO_WIDHT320) - self.lbLineOfCredit.height - 15*RATIO_WIDHT320 - self.lbLineOfCreditText.height)/2.0;
    self.lbLineOfCreditText.top = self.lbLineOfCredit.bottom + 15*RATIO_WIDHT320;
    
    size = [self.lbUseOfCredit sizeThatFits:CGSizeMake(w, MAXFLOAT)];
    r = self.lbUseOfCredit.frame;
    r.size.width = w;
    r.size.height = size.height;
    r.origin.x = w;
    r.origin.y = 0;
    self.lbUseOfCredit.frame = r;
    
    size = [self.lbUseOfCreditText sizeThatFits:CGSizeMake(self.lbLineOfCredit.width, MAXFLOAT)];
    r = self.lbUseOfCreditText.frame;
    r.size.width = self.lbMonthArrears.width;
    r.size.height = size.height;
    r.origin.x = w;
    r.origin.y = 0;
    self.lbUseOfCreditText.frame = r;
    
    self.lbUseOfCredit.top = ((self.height-8*RATIO_WIDHT320) - self.lbUseOfCredit.height - 15*RATIO_WIDHT320 - self.lbUseOfCreditText.height)/2.0;
    self.lbUseOfCreditText.top = self.lbLineOfCredit.bottom + 15*RATIO_WIDHT320;
    
    r = self.vLineTwo.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 8*RATIO_WIDHT320;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLineTwo.frame = r;
}

+ (CGFloat)calHeight{
    return 90*RATIO_WIDHT320;
}
@end
