//
//  ViewGoodsList.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewGoodsList.h"

@interface ViewGoodsList()

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIView *vListBg;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,strong)UIImageView *ivArrow;

@end

@implementation ViewGoodsList

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB(0, 0, 0);
        _lbTitle.text = @"商品清单";
        [self addSubview:_lbTitle];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
        
        _vListBg = [[UIView alloc]initWithFrame:CGRectZero];
//        _vListBg.backgroundColor = [UIColor redColor];
        [self addSubview:_vListBg];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbCount.textColor = RGB3(102);
        [self addSubview:_lbCount];
        
        _ivArrow = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivArrow.image = [UIImage imageNamed:@"Shopping-Cart_news_more"];
        _ivArrow.userInteractionEnabled = YES;
        [self addSubview:_ivArrow];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    [self updateData];
}

- (void)updateData{
    self.lbCount.text = [NSString stringWithFormat:@"共计%zi个商品",self.dataSource.count];
    [self.vListBg removeAllSubviews];
    CGFloat w = 40*RATIO_WIDHT320;
    CGFloat m = 5*RATIO_WIDHT320;
    NSInteger num = 4;
    if(self.dataSource.count < num){
        num = self.dataSource.count;
    }
    for (NSInteger i = 0; i < num; i++) {
        CartGoods *data = [self.dataSource objectAtIndex:i];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(i*w + i*m, 0, w, w)];
        img.layer.borderColor = RGB3(240).CGColor;
        img.layer.borderWidth = 0.5;
        img.layer.cornerRadius = 3.f;
        img.layer.masksToBounds = YES;
        img.userInteractionEnabled = TRUE;
        [img pt_setImage:data.GOODS_PIC];
        [self.vListBg addSubview:img];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbTitle.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 12*RATIO_WIDHT320;
    r.size.width = self.width - 20*RATIO_WIDHT320;
    r.size.height = 14*RATIO_WIDHT320;
    self.lbTitle.frame = r;
    
    r = self.vLine.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbTitle.bottom + 12*RATIO_WIDHT320;
    r.size.width = self.width - 20*RATIO_WIDHT320;
    r.size.height = 0.5;
    self.vLine.frame = r;
    
    r = self.ivArrow.frame;
    r.size.width = 9*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.vLine.bottom + (60*RATIO_WIDHT320 - r.size.height)/2.0;
    self.ivArrow.frame = r;
    
    CGSize size = [self.lbCount sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbCount.frame;
    r.origin.x = self.ivArrow.left - size.width - 3*RATIO_WIDHT320;
    r.origin.y = self.vLine.bottom + (60*RATIO_WIDHT320 - size.height)/2.0;
    r.size = size;
    self.lbCount.frame = r;
    
    r = self.vListBg.frame;
    r.size.width = 190*RATIO_WIDHT320;
    r.size.height = 40*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.vLine.bottom + 10*RATIO_WIDHT320;
    self.vListBg.frame = r;
}

+ (CGFloat)calHeight{
    return 60*RATIO_WIDHT320 + 38*RATIO_WIDHT320 + 0.5;
}

@end
