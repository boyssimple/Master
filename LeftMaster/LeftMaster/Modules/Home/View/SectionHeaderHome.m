//
//  HeaderHome.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "SectionHeaderHome.h"
@interface SectionHeaderHome()
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIButton *btnArrow;
@end
@implementation SectionHeaderHome

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.userInteractionEnabled = YES;
        [self addSubview:_ivImg];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:16*RATIO_WIDHT320];
        _lbName.textColor = RGB3(26);
        [self addSubview:_lbName];
        
        _btnArrow = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnArrow setTitle:@"全部" forState:UIControlStateNormal];
        [_btnArrow setImage:[UIImage imageNamed:@"home_news_more"] forState:UIControlStateNormal];
        _btnArrow.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnArrow setTitleColor:RGB3(102) forState:UIControlStateNormal];
        [_btnArrow addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnArrow];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(231);
        [self addSubview:_vLine];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    if([self.delegate respondsToSelector:@selector(sectionClickShowAll:)]){
        [self.delegate sectionClickShowAll:self.index];
    }
}

- (void)setTitle:(NSString *)title witIcon:(NSString*)icon{
    self.ivImg.image = [UIImage imageNamed:icon];
    self.lbName.text = title;
    if(self.lbName.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbName.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, 2)];
        [self.lbName setAttributedText:noteStr];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivImg.frame;
    r.origin.x = 10;
    r.origin.y = 15*RATIO_WIDHT320;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.ivImg.frame = r;
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, 16*RATIO_WIDHT320)];
    r = self.lbName.frame;
    r.origin.x = self.ivImg.right + 10;
    r.origin.y = (self.height - size.height)/2.0;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.btnArrow.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.btnArrow.frame;
    
    r.size.width = size.width + 10*RATIO_WIDHT320;
    r.size.height = self.height;
    r.origin.y = 0;
    r.origin.x = self.width - r.size.width - 10*RATIO_WIDHT320;
    self.btnArrow.frame = r;
    
    [self.btnArrow setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btnArrow.imageView.size.width, 0, self.btnArrow.imageView.size.width)];
    [self.btnArrow setImageEdgeInsets:UIEdgeInsetsMake(0, size.width, 0, -size.width)];
    
    r = self.vLine.frame;
    r.origin.x = 0;
    r.origin.y = self.height - 0.5;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 45*RATIO_WIDHT320;
}

@end

