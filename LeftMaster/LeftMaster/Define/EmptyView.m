//
//  EmptyView.m
//  LeftMaster
//
//  Created by simple on 2018/8/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "EmptyView.h"

@implementation EmptyView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.image = [UIImage imageNamed:@"wushuju"];
        [self addSubview:_ivImg];
        
        _lbTips = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTips.textColor = [UIColor grayColor];
        _lbTips.font = [UIFont systemFontOfSize:14*RATIO_WIDHT750];
        _lbTips.text = @"暂无数据~";
        _lbTips.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbTips];
    }
    return self;
}

- (void)setImage:(NSString *)image{
    _image = image;
    self.ivImg.image = [UIImage imageNamed:image];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.ivImg.image.size.width;
    if (w > DEVICEWIDTH) {
        w = DEVICEWIDTH;
    }
    
    CGSize size = [self.lbTips sizeThatFits:CGSizeMake(DEVICEWIDTH, 14*RATIO_WIDHT750)];
    
    CGRect r = self.ivImg.frame;
    r.size.width = w;
    r.size.height = self.ivImg.image.size.height;
    r.origin.x = (DEVICEWIDTH - r.size.width)/2.0;
    r.origin.y = (DEVICEHEIGHT - r.size.height - size.height - 20*RATIO_WIDHT750)/2.0 - NAV_STATUS_HEIGHT;
    self.ivImg.frame = r;
    
    r = self.lbTips.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = size.height;
    r.origin.x = 0;
    r.origin.y = self.ivImg.bottom + 20*RATIO_WIDHT750;
    self.lbTips.frame = r;
}


@end
