//
//  ViewCategory.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewSearchWithHome.h"

@interface ViewSearchWithHome()
@property(nonatomic,strong)UIButton *btnQR;
@property(nonatomic,strong)UIView *vSearchBg;
@property(nonatomic,strong)UILabel *lbTips;
@property(nonatomic,strong)UIImageView *ivSearch;

@property(nonatomic,strong)UIView  *vLine;
@property (nonatomic, assign) bool isExcuting;
@end
@implementation ViewSearchWithHome

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _btnQR = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnQR.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _btnQR.tag = 101;
        [_btnQR setImage:[UIImage imageNamed:@"classification-icon_Scan"] forState:UIControlStateNormal];
        [_btnQR addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnQR];
        
        _vSearchBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vSearchBg.backgroundColor = [UIColor whiteColor];
        _vSearchBg.layer.cornerRadius = 15;
        _vSearchBg.layer.masksToBounds = YES;
        [self addSubview:_vSearchBg];
        
        _ivSearch = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivSearch.image = [UIImage imageNamed:@"classification-icon_search"];
        _ivSearch.userInteractionEnabled = YES;
        [_vSearchBg addSubview:_ivSearch];
        
        _lbTips = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTips.text = @"商品名称、编码、条形码";
        _lbTips.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbTips.textColor = RGB3(200);
        _lbTips.userInteractionEnabled = TRUE;
        [_vSearchBg addSubview:_lbTips];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSearch)];
        [_lbTips addGestureRecognizer:tap];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
    }
    return self;
}



- (void)updateData{
    
}

- (void)clickAction:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:0];
    }
}

- (void)clickSearch{
    
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:1];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.btnQR.frame;
    r.size.width = 43*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.btnQR.frame = r;
    
    r = self.btnQR.imageView.frame;
    r.size.width = 23*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnQR.imageView.frame = r;
    
    
    r = self.vSearchBg.frame;
    r.size.width = DEVICEWIDTH - 10*RATIO_WIDHT320 - self.btnQR.right;
    r.size.height = 30;
    r.origin.x = self.btnQR.right;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.vSearchBg.frame = r;
    
    r = self.ivSearch.frame;
    r.size.width = 12*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.vSearchBg.height - r.size.height)/2.0;
    self.ivSearch.frame = r;
    
    r = self.lbTips.frame;
    r.size.width = self.vSearchBg.width - 10*RATIO_WIDHT320 - self.ivSearch.right - 4*RATIO_WIDHT320;
    r.size.height = self.vSearchBg.height;
    r.origin.x = self.ivSearch.right+4*RATIO_WIDHT320;
    r.origin.y = 0;
    self.lbTips.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 44;
}

@end
