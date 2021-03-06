//
//  ViewCategory.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewCategory.h"

@interface ViewCategory()
@property(nonatomic,strong)UIView *vSearchBg;
@property(nonatomic,strong)UIImageView *ivSearch;

@property(nonatomic,strong)UIImageView *ivCart;
@property(nonatomic,strong)UIView  *vLine;
@property (nonatomic, assign) bool isExcuting;
@end
@implementation ViewCategory

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        _vSearchBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vSearchBg.backgroundColor = RGB3(247);
        _vSearchBg.layer.cornerRadius = 15*RATIO_WIDHT320;
        _vSearchBg.layer.masksToBounds = YES;
        [self addSubview:_vSearchBg];
        
        _ivSearch = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivSearch.image = [UIImage imageNamed:@"classification-icon_search"];
        _ivSearch.userInteractionEnabled = YES;
        [_vSearchBg addSubview:_ivSearch];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.text = @"商品名称、编码、条形码";
        _lbText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_vSearchBg addSubview:_lbText];
        _lbText.userInteractionEnabled = TRUE;
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickSearch)];
        [_lbText addGestureRecognizer:tap1];
        
        _ivCart = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivCart.image = [UIImage imageNamed:@"classification-icon_Shopping-Cart"];
        _ivCart.userInteractionEnabled = YES;
        [self addSubview:_ivCart];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
                [self.delegate clickActionWithIndex:1];
            }
        }];
        [_ivCart addGestureRecognizer:tap];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont systemFontOfSize:8*RATIO_WIDHT320];
        _lbCount.textColor = [UIColor whiteColor];
        _lbCount.numberOfLines = 2;
        _lbCount.backgroundColor = APP_COLOR;
        _lbCount.layer.cornerRadius = 5*RATIO_WIDHT320;
        _lbCount.layer.masksToBounds = YES;
        _lbCount.textAlignment = NSTextAlignmentCenter;
        _lbCount.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
                [self.delegate clickActionWithIndex:1];
            }
        }];
        [_lbCount addGestureRecognizer:tapTwo];
        [self addSubview:_lbCount];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
    }
    return self;
}

- (void)startAnimation{
    if (!self.isExcuting) {
        self.isExcuting = TRUE;
        __weak typeof(self) weakself = self;
        [UIView animateWithDuration:0.1 animations:^{
            weakself.ivCart.top = weakself.ivCart.top - 5;
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                weakself.ivCart.top = weakself.ivCart.top + 5;
            }completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 animations:^{
                    weakself.ivCart.top = weakself.ivCart.top - 5;
                }completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.1 animations:^{
                        weakself.ivCart.top = weakself.ivCart.top + 5;
                    }completion:^(BOOL finished) {
                        self.isExcuting = FALSE;
                    }];
                }];
            }];
        }];
    }
}

- (void)setCount:(NSInteger)count{
    _count = count;
    if (_count > 10) {
        self.lbCount.text = [NSString stringWithFormat:@"10+"];
    }else{
        self.lbCount.text = [NSString stringWithFormat:@"%zi",_count];
    }
    if(_count == 0){
        self.lbCount.hidden = YES;
    }else{
        self.lbCount.hidden = NO;
    }
}

- (void)updateData{
    
}

- (void)clickSearch{
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:2];
    }
}

- (void)clickAction:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:0];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbCount.frame;
    r.size.width = 20*RATIO_WIDHT320;
    r.size.height = 10*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width - 5*RATIO_WIDHT320;
    r.origin.y = 10*RATIO_WIDHT320;
    self.lbCount.frame = r;
    
    r = self.ivCart.frame;
    r.size.width = 23*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = DEVICEWIDTH - r.size.width - 15*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.ivCart.frame = r;
    
    r = self.vSearchBg.frame;
    r.size.width = self.ivCart.left - 15*RATIO_WIDHT320;
    r.size.height = 30*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 5*RATIO_WIDHT320;
    self.vSearchBg.frame = r;
    
    r = self.ivSearch.frame;
    r.size.width = 12*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.vSearchBg.height - r.size.height)/2.0;
    self.ivSearch.frame = r;
    
    r = self.lbText.frame;
    r.size.width = self.vSearchBg.width - 10*RATIO_WIDHT320 - self.ivSearch.right - 4*RATIO_WIDHT320;
    r.size.height = self.vSearchBg.height;
    r.origin.x = self.ivSearch.right+4*RATIO_WIDHT320;
    r.origin.y = 0;
    self.lbText.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end
