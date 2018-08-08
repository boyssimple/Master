//
//  ViewHeaderMine.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewSectionMine.h"
@interface ViewSectionMine()
@property(nonatomic,strong)UIImageView *ivBg;
@property(nonatomic,strong)UIImageView *ivLogo;
@property(nonatomic,strong)UILabel *lbCompany;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIButton *btnModifyPwd;
@end
@implementation ViewSectionMine

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _ivBg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivBg.image = [UIImage imageNamed:@"me_bg"];
        _ivBg.userInteractionEnabled = YES;
        [self addSubview:_ivBg];
        
        _ivLogo = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivLogo.image = [UIImage imageNamed:@"logo"];
        _ivLogo.userInteractionEnabled = YES;
        [_ivBg addSubview:_ivLogo];
        
        _lbCompany = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCompany.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbCompany.textColor = [UIColor whiteColor];
        [_ivBg addSubview:_lbCompany];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbName.textColor = [UIColor whiteColor];
        [_ivBg addSubview:_lbName];
        
        _btnModifyPwd = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnModifyPwd setTitle:@"修改密码" forState:UIControlStateNormal];
        [_btnModifyPwd setTitleColor:APP_COLOR forState:UIControlStateNormal];
        _btnModifyPwd.titleLabel.font = [UIFont boldSystemFontOfSize:10*RATIO_WIDHT320];
        [_btnModifyPwd addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnModifyPwd.backgroundColor = [UIColor whiteColor];
        [_ivBg addSubview:_btnModifyPwd];
        
    }
    return self;
}

- (void)updateData{
    self.lbCompany.text = @"重庆XX菲斯机械有限公司";
    self.lbName.text = @"罗先生";
}

- (void)clickAction:(UIButton*)sender{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivBg.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.width;
    r.size.height = self.height;
    self.ivBg.frame = r;
    
    r = self.ivLogo.frame;
    r.size.width = 50*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.ivLogo.frame = r;
    
    CGSize size = [self.lbCompany sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbCompany.frame;
    r.origin.x = self.ivLogo.right + 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size = size;
    self.lbCompany.frame = r;
    
    size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbName.frame;
    r.origin.x = self.ivLogo.right + 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size = size;
    self.lbName.frame = r;
    
    self.lbCompany.top = self.ivLogo.top + (self.ivLogo.height-(self.lbCompany.height + 10*RATIO_WIDHT320 + self.lbName.height))/2.0;
    self.lbName.top = self.lbCompany.bottom + 10*RATIO_WIDHT320;
    
    
    r = self.btnModifyPwd.frame;
    r.size.width = 50*RATIO_WIDHT320;
    r.size.height = 18*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.btnModifyPwd.frame = r;
    
}

+ (CGFloat)calHeight{
    return 100*RATIO_WIDHT320;
}

@end

