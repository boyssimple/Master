//
//  ViewGoodsList.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewTotalOrder.h"

@interface ViewTotalOrder()

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UILabel *lbPrice;

@end

@implementation ViewTotalOrder

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB(0, 0, 0);
        _lbTitle.text = @"商品合计";
        [self addSubview:_lbTitle];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbPrice.textColor = APP_COLOR;
        _lbPrice.text = @"¥???.00";
        [self addSubview:_lbPrice];
        
    }
    return self;
}

- (void)updateData:(CGFloat)price{
    self.lbPrice.text = [NSString stringWithFormat:@"¥%.2f",price];
    if(self.lbPrice.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9*RATIO_WIDHT320] range:NSMakeRange(self.lbPrice.text.length-3, 3)];
        [self.lbPrice setAttributedText:noteStr];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
    CGRect r = self.lbTitle.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    r.size = size;
    self.lbTitle.frame = r;
    
    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = DEVICEWIDTH - size.width - 9.5*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    r.size = size;
    self.lbPrice.frame = r;
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end


