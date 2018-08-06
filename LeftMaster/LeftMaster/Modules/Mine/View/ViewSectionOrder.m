//
//  ViewSectionOrder.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewSectionOrder.h"
@interface ViewSectionOrder()
@property(nonatomic,strong)UIImageView *ivIcon;
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIImageView *ivArrow;
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)UIView *vLine;
@end
@implementation ViewSectionOrder

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _ivIcon = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivIcon.userInteractionEnabled = YES;
        [self addSubview:_ivIcon];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB3(51);
        [self addSubview:_lbTitle];
        
        _ivArrow = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivArrow.userInteractionEnabled = YES;
        _ivArrow.image = [UIImage imageNamed:@"home_news_more"];
        [self addSubview:_ivArrow];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
    }
    return self;
}

- (void)updateDataIcon:(NSString*)icon withName:(NSString *)name withHiddenArrow:(BOOL)show{
    self.ivIcon.image = [UIImage imageNamed:icon];
    self.lbTitle.text = name;
    self.ivArrow.hidden = show;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivIcon.frame;
    r.size.width = 16*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.ivIcon.frame = r;
    
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
    r = self.lbTitle.frame;
    r.size = size;
    r.origin.x = self.ivIcon.right + 10*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    self.lbTitle.frame = r;
    
    r = self.ivArrow.frame;
    r.size.width = 10*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.ivArrow.frame = r;
    
    size = [self.lbText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbTitle.frame;
    r.size.width = size.width;
    r.size.height = self.height;
    r.origin.x = self.ivArrow.left - size.width - 8*RATIO_WIDHT320;
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
    return 36*RATIO_WIDHT320;
}

@end
