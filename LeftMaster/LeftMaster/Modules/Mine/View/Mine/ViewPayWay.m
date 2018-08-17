//
//  ViewPayWay.m
//  LeftMaster
//
//  Created by simple on 2018/8/12.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewPayWay.h"

@implementation ViewPayWay

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _btnCheck = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnCheck.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _btnCheck.tag = 100;
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_normal"] forState:UIControlStateNormal];
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_selected"] forState:UIControlStateSelected];
        [_btnCheck addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnCheck];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbTitle.textColor = [UIColor blackColor];
        [self addSubview:_lbTitle];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(231);
        [self addSubview:_vLine];
        
        _lbDesc = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbDesc.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbDesc.textColor = [UIColor grayColor];
        [self addSubview:_lbDesc];
    }
    return self;
}

- (void)clickAction{
    self.btnCheck.selected = !self.btnCheck.selected;
    if (self.clickBlock) {
        self.clickBlock(self.tag,self.btnCheck.selected);
    }
}

- (void)updateData:(NSString*)title withDesc:(NSString*)desc{
    self.lbTitle.text = title;
    self.lbDesc.text = desc;
    [self setNeedsLayout];
}

- (void)updateDataWithDesc:(NSString*)desc{
    self.lbDesc.text = desc;
    [self setNeedsLayout];
}

- (void)updateData{
    self.lbTitle.text = @"立即支付";
    self.lbDesc.text = @"立即支付可让您购买的宝贝早日到您身边";
    [self setNeedsLayout];
}

- (void)enabled:(BOOL)enabled{
    self.btnCheck.enabled = enabled;
    if(!enabled){
        self.lbTitle.textColor = [UIColor grayColor];
    }else{
        self.lbTitle.textColor = [UIColor blackColor];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    CGRect r = self.btnCheck.frame;
    r.size.width = 35*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = DEVICEWIDTH - r.size.width;
    r.origin.y = (40*RATIO_WIDHT320 - r.size.height)/2.0;
    self.btnCheck.frame = r;
    
    r = self.btnCheck.imageView.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnCheck.imageView.frame = r;
    
    r = self.lbTitle.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size.width = DEVICEWIDTH - self.btnCheck.width - 20*RATIO_WIDHT320;
    r.size.height = 40*RATIO_WIDHT320;
    self.lbTitle.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH - 10*RATIO_WIDHT320;
    r.size.height = 0.5;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbTitle.bottom;
    self.vLine.frame = r;
    
    CGSize size = [self.lbDesc sizeThatFits:CGSizeMake(DEVICEWIDTH-20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbDesc.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.vLine.bottom + 10*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    self.lbDesc.frame = r;
}

+ (CGFloat)calHeight{
    return 70*RATIO_WIDHT320;
}
@end
