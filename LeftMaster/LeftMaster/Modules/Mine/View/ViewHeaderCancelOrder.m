//
//  ViewHeaderCancelOrder.m
//  LeftMaster
//
//  Created by simple on 2018/4/24.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewHeaderCancelOrder.h"

@interface ViewHeaderCancelOrder()
@property(nonatomic,strong)UILabel *lbTips;
@property(nonatomic,strong)UILabel *lbTipsOne;
@end
@implementation ViewHeaderCancelOrder

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lbTips = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTips.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbTips.textColor = RGB3(0);
        _lbTips.numberOfLines = 0;
        _lbTips.text = @"温馨提示:\n1.限时特价、预约资格等购买优惠可能一并取消";
        [self addSubview:_lbTips];
        
        _lbTipsOne = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTipsOne.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbTipsOne.textColor = RGB3(0);
        _lbTipsOne.text = @"请选择取消订单的原因 (必选) :";
        [self addSubview:_lbTipsOne];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbTips sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
    CGRect r = self.lbTips.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 20*RATIO_WIDHT320;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = size.height;
    self.lbTips.frame = r;
    
    size = [self.lbTipsOne sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbTipsOne.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbTips.bottom + 30*RATIO_WIDHT320;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = size.height;
    self.lbTipsOne.frame = r;
}

+ (CGFloat)calHeight{
    CGFloat height = 20*RATIO_WIDHT320;
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    lb.numberOfLines = 0;
    lb.text = @"温馨提示:\n1.限时特价、预约资格等购买优惠可能一并取消";
    CGSize size = [lb sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
    height += size.height;
    
    height += 30*RATIO_WIDHT320;
    lb.numberOfLines = 1;
    lb.text = @"请选择取消订单的原因 (必选) :";
    height += lb.height;
    
    return height + 20*RATIO_WIDHT320;;
}

@end
