//
//  CollCellCategoryHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CollCellNewHome.h"

@interface CollCellNewHome()
@property(nonatomic,strong)UIView *vBg;
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UIImageView *ivNew;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UILabel *lbHasGoods;
@end
@implementation CollCellNewHome

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        _vBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vBg.layer.borderColor = RGB3(230).CGColor;
        _vBg.layer.borderWidth = 0.5f;
        _vBg.layer.cornerRadius = 10.f;
        _vBg.layer.masksToBounds = YES;
        _vBg.clipsToBounds = YES;
        [self.contentView addSubview:_vBg];
        
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.image = [UIImage imageNamed:@""];
        _ivImg.userInteractionEnabled = YES;
        [_vBg addSubview:_ivImg];
        
        _ivNew = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivNew.image = [UIImage imageNamed:@"news"];
        _ivNew.userInteractionEnabled = YES;
        [_vBg addSubview:_ivNew];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [_vBg addSubview:_vLine];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:10*RATIO_WIDHT320];
        _lbName.textColor = [UIColor blackColor];
        _lbName.textAlignment = NSTextAlignmentCenter;
        [_vBg addSubview:_lbName];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbPrice.textColor = RGB3(26);
        [_vBg addSubview:_lbPrice];
        
        _lbHasGoods = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbHasGoods.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbHasGoods.textColor = RGB3(26);
        [_vBg addSubview:_lbHasGoods];
    }
    return self;
}

- (void)updateData{
    [self.ivImg pt_setImage:@"http://pic1.win4000.com/wallpaper/2017-12-19/5a387cb8439ea.jpg"];
    self.lbName.text = @"轮胎";
    self.lbPrice.text = @"¥?/个";
    self.lbHasGoods.text = @"有货";
    if(self.lbPrice.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-2)];
        [self.lbPrice setAttributedText:noteStr];
    }
}

- (void)updateData:(NSDictionary*)data{
    [self.ivImg pt_setImage:[data jk_stringForKey:@"GOODS_PIC"]];
    self.lbName.text = [data jk_stringForKey:@"GOODS_NAME"];
    if ([data jk_floatForKey:@"GOODS_PRICE"] == 0) {
        self.lbPrice.text = [NSString stringWithFormat:@"¥?/%@",[data jk_stringForKey:@"GOODS_UNIT"]];
    }else{
        self.lbPrice.text = [NSString stringWithFormat:@"¥%.2f/%@",[data jk_floatForKey:@"GOODS_PRICE"],[data jk_stringForKey:@"GOODS_UNIT"]];
        
    }
    if([data jk_integerForKey:@"GOODS_STOCK"] > 0){
        self.lbHasGoods.text = @"有货";
    }else{
        self.lbHasGoods.text = @"无货";
    }
    
    NSInteger length = [data jk_stringForKey:@"GOODS_UNIT"].length + 1;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-length)];
    [self.lbPrice setAttributedText:noteStr];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.vBg.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.width;
    r.size.height = self.height;
    self.vBg.frame = r;
    
    r = self.ivImg.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.vBg.width;
    r.size.height = 120*RATIO_WIDHT320;
    self.ivImg.frame = r;
    
    
    r = self.ivNew.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = 32*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.ivNew.frame = r;

    r = self.vLine.frame;
    r.origin.x = 0;
    r.origin.y = self.ivImg.bottom;
    r.size.width = self.contentView.width;
    r.size.height = 0.5;
    self.vLine.frame = r;

    CGSize size = [self.lbName sizeThatFits:CGSizeMake(self.vBg.width - 10*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbName.frame;
    r.origin.x = 5*RATIO_WIDHT320;
    r.origin.y = self.vLine.bottom+11*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = self.vBg.width - 10*RATIO_WIDHT320;
    self.lbName.frame = r;

    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.size = size;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.vBg.height - r.size.height - 10*RATIO_WIDHT320;
    self.lbPrice.frame = r;

    size = [self.lbHasGoods sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbHasGoods.frame;
    r.size = size;
    r.origin.x = self.vBg.width - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.vBg.height - r.size.height - 10*RATIO_WIDHT320;
    self.lbHasGoods.frame = r;
    
}

+ (CGFloat)calHeight{
    return 189*RATIO_WIDHT320;
}

@end

