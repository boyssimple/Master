//
//  ViewOrderCheckAccount.m
//  LeftMaster
//
//  Created by simple on 2018/4/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewOrderCheckAccount.h"

@interface ViewOrderCheckAccount()
@property(nonatomic,strong)UILabel *lbYear;
@property(nonatomic,strong)UILabel *lbPayAmount;
@property(nonatomic,strong)UILabel *lbPayedAmount;
@property(nonatomic,strong)UILabel *lbAmount;
@property(nonatomic,strong)UILabel *lbValue;
@property(nonatomic,strong)UIView *vLine;
@end
@implementation ViewOrderCheckAccount

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lbYear = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbYear.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbYear.textColor = RGB(0, 0, 0);
        _lbYear.text = @"年月";
        _lbYear.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbYear];
        
        _lbPayAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPayAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPayAmount.textColor = RGB(0, 0, 0);
        _lbPayAmount.text = @"应付金额";
        _lbPayAmount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbPayAmount];
        
        _lbPayedAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPayedAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPayedAmount.textColor = RGB(0, 0, 0);
        _lbPayedAmount.text = @"已付金额";
        _lbPayedAmount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbPayedAmount];
        
        _lbAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbAmount.textColor = RGB(0, 0, 0);
        _lbAmount.text = @"欠款总金额";
        _lbAmount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbAmount];
        
        _lbValue = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbValue.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbValue.textColor = RGB(0, 0, 0);
        _lbValue.text = @"征信值";
        _lbValue.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbValue];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(231);
        [self addSubview:_vLine];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = DEVICEWIDTH / 5.0;
    CGRect r = self.lbYear.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbYear.frame = r;
    
    r = self.lbPayAmount.frame;
    r.origin.x = w;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbPayAmount.frame = r;
    
    r = self.lbPayedAmount.frame;
    r.origin.x = 2*w;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbPayedAmount.frame = r;
    
    r = self.lbAmount.frame;
    r.origin.x = 3*w;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbAmount.frame = r;
    
    r = self.lbValue.frame;
    r.origin.x = 4*w;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbValue.frame = r;
    
    r = self.vLine.frame;
    r.origin.x = 0;
    r.origin.y = self.height - 0.5;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    self.vLine.frame = r;
}


+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end
