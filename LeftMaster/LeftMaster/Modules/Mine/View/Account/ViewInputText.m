//
//  ViewInputText.m
//  LeftMaster
//
//  Created by simple on 2018/8/13.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewInputText.h"

@interface ViewInputText()
@property(nonatomic,strong)UIView *vLine;
@end


@implementation ViewInputText

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.textColor = RGB3(0);
        _lbName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        [self addSubview:_lbName];
        
        _tfText = [[UITextField alloc]initWithFrame:CGRectZero];
        _tfText.textColor = RGB3(0);
        _tfText.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        [self addSubview:_tfText];
        
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = APP_Gray_COLOR;
        [self addSubview:_vLine];
        
        _btnButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_btnButton setTitleColor:APP_COLOR forState:UIControlStateNormal];
        _btnButton.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        [_btnButton addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnButton];
    }
    
    return self;
}

- (void)clickAction{
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)updateData{
    if(self.type == 2){
        self.btnButton.hidden = FALSE;
    }else{
        self.btnButton.hidden = TRUE;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbName.frame;
    r.size.width = 100*RATIO_WIDHT320;
    r.size.height = self.height;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 0;
    self.lbName.frame = r;
    
    CGSize size = [self.btnButton.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
    r = self.btnButton.frame;
    r.size.width = size.width+10;
    r.size.height = self.height;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = 0;
    self.btnButton.frame = r;
    
    r = self.tfText.frame;
    r.size.width = DEVICEWIDTH - 10*RATIO_WIDHT320 - self.lbName.right;
    r.size.height = self.height;
    r.origin.x = self.lbName.right;
    r.origin.y = 0;
    self.tfText.frame = r;
    
    if (self.type == 2) {
        self.tfText.width = self.btnButton.left - 10*RATIO_WIDHT320 - self.lbName.right;
    }
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}
@end
