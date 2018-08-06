//
//  ViewTotalCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewTotalBottomWriteOrder.h"

@interface ViewTotalBottomWriteOrder()

@property(nonatomic,strong)UIButton *btnCheck;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UIButton *btnOrder;
@end

@implementation ViewTotalBottomWriteOrder

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbPrice.textColor = APP_COLOR;
        [self addSubview:_lbPrice];
        
        _btnOrder = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnOrder.titleLabel.font = [UIFont boldSystemFontOfSize:16*RATIO_WIDHT320];
        _btnOrder.tag = 100;
        [_btnOrder setTitle:@"提交订单" forState:UIControlStateNormal];
        [_btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnOrder.backgroundColor = [UIColor redColor];
        [_btnOrder addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnOrder];
    }
    return self;
}


- (void)clickAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if(tag == 100){
        if ([self.delegate respondsToSelector:@selector(clickOrder)]) {
            [self.delegate clickOrder];
        }
    }
}


- (void)updateData:(CGFloat)price{
    self.lbPrice.text = [NSString stringWithFormat:@"应付金额:¥%.2f",price];
    
    if(self.lbPrice.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*RATIO_WIDHT320] range:NSMakeRange(self.lbPrice.text.length-3, 3)];
        [self.lbPrice setAttributedText:noteStr];
    }
    [self setNeedsLayout];
}

- (void)updateData{
    self.lbPrice.text = @"应付金额:¥???.00";
    
    if(self.lbPrice.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12*RATIO_WIDHT320] range:NSMakeRange(self.lbPrice.text.length-3, 3)];
        [self.lbPrice setAttributedText:noteStr];
    }
    [self setNeedsLayout];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.btnOrder.frame;
    r.size.width = 120*RATIO_WIDHT320;
    r.size.height = self.height;
    r.origin.x = DEVICEWIDTH - r.size.width;
    r.origin.y = 0;
    self.btnOrder.frame = r;
    
    CGSize size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = self.btnOrder.left - size.width - 20*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    r.size = size;
    self.lbPrice.frame = r;
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end

