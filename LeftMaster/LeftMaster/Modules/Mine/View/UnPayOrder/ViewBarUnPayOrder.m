//
//  ViewTotalCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewBarUnPayOrder.h"
@interface ViewBarUnPayOrder()

@property(nonatomic,strong)UIButton *btnCheck;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UIButton *btnOrder;
@end

@implementation ViewBarUnPayOrder

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _btnCheck = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnCheck.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _btnCheck.tag = 100;
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_normal"] forState:UIControlStateNormal];
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_selected"] forState:UIControlStateSelected];
        [_btnCheck addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnCheck];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbCount.textColor = RGB(0, 0, 0);
        _lbCount.text = @"全部";
        [self addSubview:_lbCount];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbPrice.textColor = APP_COLOR;
        [self addSubview:_lbPrice];
        
        _btnOrder = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnOrder.titleLabel.font = [UIFont boldSystemFontOfSize:16*RATIO_WIDHT320];
        _btnOrder.tag = 101;
        [_btnOrder setTitle:@"去结算" forState:UIControlStateNormal];
        [_btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnOrder.backgroundColor = [UIColor redColor];
        [_btnOrder addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnOrder];
    }
    return self;
}


- (void)clickAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if(self.clickBlock){
        if (tag == 100) {
            self.btnCheck.selected = !self.btnCheck.selected;
            self.clickBlock(0,self.btnCheck.selected);
        }else if(tag == 101){
            self.clickBlock(1,FALSE);
        }
    }
}

- (void)updateDataPrice:(CGFloat)total{
    self.lbPrice.text = [NSString stringWithFormat:@"合计：%.2f",total];
    
    if(self.lbPrice.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16*RATIO_WIDHT320] range:NSMakeRange(0, 3)];
        [self.lbPrice setAttributedText:noteStr];
    }
    [self setNeedsLayout];
}

- (void)updateData{
    self.lbPrice.text = @"合计：0.00";
    
    if(self.lbPrice.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16*RATIO_WIDHT320] range:NSMakeRange(0, 3)];
        [self.lbPrice setAttributedText:noteStr];
    }
}

- (void)updateCal:(NSInteger)num{
    if(num > 0){
        [self.btnOrder setTitle:[NSString stringWithFormat:@"去结算(%ld)",num] forState:UIControlStateNormal];
    }else{
        [self.btnOrder setTitle:@"去结算" forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.btnCheck.frame;
    r.size.width = 35*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.btnCheck.frame = r;
    
    r = self.btnCheck.imageView.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnCheck.imageView.frame = r;
    
    CGSize size = [self.lbCount sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbCount.frame;
    r.origin.x = self.btnCheck.right;
    r.origin.y = (self.height - size.height)/2.0;
    r.size = size;
    self.lbCount.frame = r;
    
    
    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = self.lbCount.right + 15*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    r.size = size;
    self.lbPrice.frame = r;
    
    r = self.btnOrder.frame;
    r.size.width = 120*RATIO_WIDHT320;
    r.size.height = self.height;
    r.origin.x = DEVICEWIDTH - r.size.width;
    r.origin.y = 0;
    self.btnOrder.frame = r;
    
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end
