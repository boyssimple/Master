//
//  ViewHeaderMine.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewBtnHeaderMine.h"

@interface ViewBtnHeaderMine()
@property(nonatomic,strong)UIImageView *ivIcon;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbCount;
@end
@implementation ViewBtnHeaderMine

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _ivIcon = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivIcon.image = [UIImage imageNamed:@"me_icon_1"];
        _ivIcon.userInteractionEnabled = YES;
        [self addSubview:_ivIcon];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont boldSystemFontOfSize:8*RATIO_WIDHT320];
        _lbCount.textColor = APP_COLOR;
        _lbCount.layer.cornerRadius = 6*RATIO_WIDHT320;
        _lbCount.layer.borderWidth = 1.f;
        _lbCount.layer.borderColor = APP_COLOR.CGColor;
        _lbCount.textAlignment = NSTextAlignmentCenter;
        _lbCount.backgroundColor = [UIColor whiteColor];
        _lbCount.hidden = YES;
        _lbCount.layer.masksToBounds = YES;
        [self addSubview:_lbCount];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:10*RATIO_WIDHT320];
        _lbName.textColor = RGB3(102);
        [self addSubview:_lbName];
        
    }
    return self;
}

- (void)update:(NSInteger)count{
    self.count = count;
    if(count > 0){
        self.lbCount.hidden = NO;
        if(count > 10){
            self.lbCount.text = [NSString stringWithFormat:@"10+"];
        }else{
            self.lbCount.text = [NSString stringWithFormat:@"%zi",count];
        }
    }else{
        self.lbCount.hidden = TRUE;
    }
    
    [self setNeedsLayout];
}

- (void)updateData:(NSString*)icon with:(NSString*)name{
    self.lbName.text = name;
    self.ivIcon.image = [UIImage imageNamed:icon];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivIcon.frame;
    r.size.width = 20*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = (self.width - r.size.width)/2.0;
    r.origin.y = 15*RATIO_WIDHT320;
    self.ivIcon.frame = r;
    
    r = self.lbCount.frame;
    r.size.width = 12*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.ivIcon.left + 14*RATIO_WIDHT320;
    r.origin.y = 9*RATIO_WIDHT320;
    self.lbCount.frame = r;
    
    if (self.count >= 10) {
        CGSize size = [self.lbCount sizeThatFits:CGSizeMake(MAXFLOAT, 8*RATIO_WIDHT320)];
        r = self.lbCount.frame;
        r.size.width = size.width +6*RATIO_WIDHT320;
        r.size.height = 12*RATIO_WIDHT320;
        self.lbCount.frame = r;
    }
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbName.frame;
    r.size.width = size.width;
    r.size.height = 10*RATIO_WIDHT320;
    r.origin.x = (self.width - size.width)/2.0;
    r.origin.y = self.ivIcon.bottom + 10*RATIO_WIDHT320;
    self.lbName.frame = r;
    
}

+ (CGFloat)calHeight{
    return 70*RATIO_WIDHT320;
}

@end


