//
//  CollCellCategoryHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CollCellCategoryHome.h"

@interface CollCellCategoryHome()
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UILabel *lbName;
@end
@implementation CollCellCategoryHome

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_ivImg];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbName.textColor = RGB(27, 26, 21);
        _lbName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbName];
    }
    return self;
}

- (void)updateData{
    self.lbName.text = @"轮胎";
}

- (void)updateData:(NSDictionary*)data{
    [self.ivImg pt_setImage:[data jk_stringForKey:@"GOODSTYPE_PIC"]];
    self.lbName.text = [data jk_stringForKey:@"GOODSTYPE_NAME"];
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivImg.frame;
    r.size.width = 40*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = (self.width - r.size.width)/2.0;
    r.origin.y = 0;
    self.ivImg.frame = r;
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(40*RATIO_WIDHT320, MAXFLOAT)];
    r = self.self.lbName.frame;
    r.size.height = size.height;
    r.size.width = self.width;
    r.origin.x = 0;
    r.origin.y = self.ivImg.bottom + 10;
    self.lbName.frame = r;
}

+ (CGFloat)calHeight{
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
    lb.text = @"轮胎";
    CGSize size = [lb sizeThatFits:CGSizeMake(40*RATIO_WIDHT320, MAXFLOAT)];
    return 40*RATIO_WIDHT320 + 10 + size.height;
}

@end
