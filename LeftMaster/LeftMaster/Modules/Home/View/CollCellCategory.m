//
//  CollCellCategoryHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CollCellCategory.h"

@interface CollCellCategory()
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UILabel *lbName;
@end
@implementation CollCellCategory

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_ivImg];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:8*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbName];
    }
    return self;
}


- (void)updateData:(NSDictionary*)data{
    [self.ivImg pt_setImage:[data jk_stringForKey:@"GOODSTYPE_PIC"]];
    self.lbName.text = [data jk_stringForKey:@"GOODSTYPE_NAME"];
}

- (void)updateData{
    [self.ivImg pt_setImage:@"http://pic1.win4000.com/wallpaper/2017-12-19/5a387cb8439ea.jpg"];
    self.lbName.text = @"275 50轮胎";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivImg.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = 73*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.ivImg.frame = r;
    
    r = self.self.lbName.frame;
    r.origin.x = 0;
    r.origin.y = self.ivImg.bottom + 4;
    r.size.height = 8*RATIO_WIDHT320;
    r.size.width = 73*RATIO_WIDHT320;
    self.lbName.frame = r;
}

+ (CGFloat)calHeight{
    return 73*RATIO_WIDHT320 + 4+8*RATIO_WIDHT320;
}

@end

