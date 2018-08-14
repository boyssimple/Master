//
//  CellEnterpriseList.m
//  LeftMaster
//
//  Created by simple on 2018/8/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellEnterpriseList.h"

@implementation CellEnterpriseList


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        [self addSubview:_lbName];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = APP_Gray_COLOR;
        [self addSubview:_vLine];
    }
    return self;
}

- (void)updateData{
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbName.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = self.height;
    self.lbName.frame = r;
    
    r = self.vLine.frame;
    r.size.width = self.width;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
    
    
    
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end
