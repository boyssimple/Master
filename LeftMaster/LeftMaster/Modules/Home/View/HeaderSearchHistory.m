//
//  HeaderSearchHistory.m
//  UMa
//
//  Created by yanyu on 2018/5/23.
//  Copyright © 2018年 yanyu. All rights reserved.
//

#import "HeaderSearchHistory.h"

@interface HeaderSearchHistory()
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)UIButton *btnDelete;
@end

@implementation HeaderSearchHistory


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.textColor = UIColorFromRGB(0x393939);
        _lbText.font = [UIFont systemFontOfSize:15*RATIO_WIDHT750];
        _lbText.text = @"历史搜索";
        [self addSubview:_lbText];
        
        _btnDelete = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnDelete setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
        [_btnDelete addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDelete];
    }
    return self;
}

- (void)deleteAction{
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:0];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect r = self.btnDelete.frame;
    r.size.width = 40*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.btnDelete.frame = r;
    
    CGSize size = [self.lbText sizeThatFits:CGSizeMake(self.btnDelete.left - 20*RATIO_WIDHT750, 14*RATIO_WIDHT320)];
    r = self.lbText.frame;
    r.size = size;
    r.origin.x = 10*RATIO_WIDHT750;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.lbText.frame = r;
}

+ (CGFloat)calHeight{
    return 80*RATIO_WIDHT320;
}


@end
