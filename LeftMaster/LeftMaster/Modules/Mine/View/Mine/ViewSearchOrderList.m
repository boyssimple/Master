//
//  ViewSearchOrderList.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewSearchOrderList.h"

@interface ViewSearchOrderList()
@property(nonatomic,strong)UIView *vSearchBg;
@property(nonatomic,strong)UIImageView *ivSearch;
@end
@implementation ViewSearchOrderList

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _vSearchBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vSearchBg.backgroundColor = RGB3(247);
        _vSearchBg.layer.cornerRadius = 12*RATIO_WIDHT320;
        _vSearchBg.layer.masksToBounds = YES;
        _vSearchBg.layer.borderColor = RGB3(230).CGColor;
        _vSearchBg.layer.borderWidth = 0.5;
        [self addSubview:_vSearchBg];
        
        _ivSearch = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivSearch.image = [UIImage imageNamed:@"classification-icon_search"];
        _ivSearch.userInteractionEnabled = YES;
        [_vSearchBg addSubview:_ivSearch];
        
        _tfText = [[UITextField alloc]initWithFrame:CGRectZero];
        _tfText.placeholder = @"商品名称、编码、条形码";
        _tfText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_vSearchBg addSubview:_tfText];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.vSearchBg.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 24*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 18*RATIO_WIDHT320;
    self.vSearchBg.frame = r;
    
    r = self.ivSearch.frame;
    r.size.width = 12*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.vSearchBg.height - r.size.height)/2.0;
    self.ivSearch.frame = r;
    
    r = self.tfText.frame;
    r.size.width = self.vSearchBg.width - 10*RATIO_WIDHT320 - self.ivSearch.right - 3*RATIO_WIDHT320;
    r.size.height = self.vSearchBg.height;
    r.origin.x = self.ivSearch.right+3*RATIO_WIDHT320;
    r.origin.y = 0;
    self.tfText.frame = r;
}

+ (CGFloat)calHeight{
    return 18*RATIO_WIDHT320 + 24*RATIO_WIDHT320 + 3*RATIO_WIDHT320;
}

@end
