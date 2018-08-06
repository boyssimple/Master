//
//  ViewBtnRecGoodsList.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewBtnRecGoodsList.h"

@interface ViewBtnRecGoodsList()
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIImageView *ivUp;
@property(nonatomic,strong)UIImageView *ivDown;
@end
@implementation ViewBtnRecGoodsList

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.userInteractionEnabled = YES;
        [self addSubview:_lbName];
        
        _ivUp = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivUp.image = [UIImage imageNamed:@"New-Arrivals_icon_up_normal"];
        _ivUp.userInteractionEnabled = YES;
        [self addSubview:_ivUp];
        
        _ivDown = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivDown.image = [UIImage imageNamed:@"New-Arrivals_icon_down_normal"];
        _ivDown.userInteractionEnabled = YES;
        [self addSubview:_ivDown];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if(_isSelected){
        self.lbName.textColor = APP_COLOR;
    }else{
        self.lbName.textColor = RGB(0, 0, 0);
    }
}

- (void)setIsAsc:(BOOL)isAsc{
    _isAsc = isAsc;
    if(_isAsc){
        self.ivUp.image = [UIImage imageNamed:@"New-Arrivals_icon_up_selected"];
        self.ivDown.image = [UIImage imageNamed:@"New-Arrivals_icon_down_normal"];
    }else{
        self.ivUp.image = [UIImage imageNamed:@"New-Arrivals_icon_up_normal"];
        self.ivDown.image = [UIImage imageNamed:@"New-Arrivals_icon_down_selected"];
    }
}

- (void)updateData:(NSString*)text{
    self.lbName.text = text;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
    CGRect r = self.lbName.frame;
    r.size = size;
    r.origin.x = 0;
    r.origin.y = (self.height - size.height)/2.0;
    self.lbName.frame = r;
    
    r = self.ivUp.frame;
    r.size.width = 5*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.lbName.right + 4*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    self.ivUp.frame = r;
    
    r = self.ivDown.frame;
    r.size.width = 5*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.lbName.right + 4*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    self.ivDown.frame = r;
    
    self.ivUp.top = (self.height - self.ivUp.height - self.ivDown.height)/2.0;
    self.ivDown.top = self.ivUp.bottom;
}

+ (CGFloat)calHeight{
    return 38*RATIO_WIDHT320;
}

+ (CGFloat)calWidth{
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
    lb.text = @"综合";
    CGFloat w = [lb sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)].width;
    return w + 5*RATIO_WIDHT320 + 4*RATIO_WIDHT320;
}

@end
