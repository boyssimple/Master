//
//  ViewHeaderMine.m
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewHeaderMine.h"
#import "ViewBtnHeaderMine.h"
#import "VCOrderList.h"
#import "VCLogin.h"
#import "AppDelegate.h"

@interface ViewHeaderMine()
@property(nonatomic,strong)UIImageView *ivBg;
@property(nonatomic,strong)UIImageView *ivLogo;
@property(nonatomic,strong)UILabel *lbCompany;
@property(nonatomic,strong)UILabel *lbName;

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIButton *btnAll;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)ViewBtnHeaderMine *vConfirm;
@property(nonatomic,strong)ViewBtnHeaderMine *vAudution;
@property(nonatomic,strong)ViewBtnHeaderMine *vUnSend;
@property(nonatomic,strong)ViewBtnHeaderMine *vUnReceive;
@end
@implementation ViewHeaderMine

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _ivBg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivBg.image = [UIImage imageNamed:@"me_bg"];
        _ivBg.userInteractionEnabled = YES;
        [self addSubview:_ivBg];
        
        _ivLogo = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivLogo.image = [UIImage imageNamed:@"logo"];
        _ivLogo.userInteractionEnabled = YES;
        _ivLogo.layer.borderColor = RGB(206, 2, 206).CGColor;
        _ivLogo.layer.borderWidth = 1.f;
        _ivLogo.layer.cornerRadius = 25*RATIO_WIDHT320;
        _ivLogo.backgroundColor = [UIColor whiteColor];
        _ivLogo.clipsToBounds = YES;
        [_ivBg addSubview:_ivLogo];
        UITapGestureRecognizer *longtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(longAction:)];
        [_ivLogo addGestureRecognizer:longtap];
        
        _lbCompany = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCompany.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbCompany.textColor = [UIColor whiteColor];
        [_ivBg addSubview:_lbCompany];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbName.textColor = [UIColor whiteColor];
        [_ivBg addSubview:_lbName];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB3(51);
        _lbTitle.text = @"我的订单";
        [self addSubview:_lbTitle];
        
        _btnAll = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnAll setTitle:@"全部订单" forState:UIControlStateNormal];
        [_btnAll setImage:[UIImage imageNamed:@"home_news_more"] forState:UIControlStateNormal];
        [_btnAll setTitleColor:RGB3(102) forState:UIControlStateNormal];
        _btnAll.titleLabel.font = [UIFont boldSystemFontOfSize:10*RATIO_WIDHT320];
        _btnAll.tag = 100;
        [_btnAll addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnAll];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
        
        
        _vConfirm = [[ViewBtnHeaderMine alloc]initWithFrame:CGRectZero];
        [_vConfirm updateData:@"me_icon_1" with:@"待确认"];
        _vConfirm.tag = 200;
        [self addSubview:_vConfirm];
        
        UITapGestureRecognizer *tap0 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoOrderList:)];
        [_vConfirm addGestureRecognizer:tap0];
        
        _vAudution = [[ViewBtnHeaderMine alloc]initWithFrame:CGRectZero];
        [_vAudution updateData:@"me_icon_1" with:@"待审核"];
        _vAudution.tag = 201;
        [self addSubview:_vAudution];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoOrderList:)];
        [_vAudution addGestureRecognizer:tap];
        
        _vUnSend = [[ViewBtnHeaderMine alloc]initWithFrame:CGRectZero];
        [_vUnSend updateData:@"me_icon_2" with:@"待发货"];
        _vUnSend.tag = 202;
        [self addSubview:_vUnSend];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoOrderList:)];
        [_vUnSend addGestureRecognizer:tap2];
        
        _vUnReceive = [[ViewBtnHeaderMine alloc]initWithFrame:CGRectZero];
        [_vUnReceive updateData:@"me_icon_3" with:@"待收货"];
        _vUnReceive.tag = 203;
        [self addSubview:_vUnReceive];
        
        UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoOrderList:)];
        [_vUnReceive addGestureRecognizer:tap3];
    }
    return self;
}

- (void)setImage:(UIImage *)img{
    self.ivLogo.image = img;
}

- (void)longAction:(UIGestureRecognizer *)gestrue
{
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:0];
    }
}

- (void)updateData:(NSInteger)index withCount:(NSInteger)count{
    if (index == 0) {
        [self.vConfirm update:count];
    }else if(index == 1){
        [self.vAudution update:count];
    }else if(index == 2){
        [self.vUnSend update:count];
    }else if(index == 3){
        [self.vUnReceive update:count];
    }
}


- (void)updateData{
    self.lbCompany.text = [AppUser share].CUS_NAME;
    self.lbName.text = [AppUser share].SYSUSER_NAME;
    [self.vUnReceive update:8];
}

- (void)gotoOrderList:(UIGestureRecognizer*)ges{
    NSInteger tag = ges.view.tag - 200;
    
    VCOrderList *vc = [[VCOrderList alloc]init];
    vc.curIndex = tag;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickAction:(UIButton*)sender{
    if(sender.tag == 100){
        VCOrderList *vc = [[VCOrderList alloc]init];
        vc.curIndex = 4;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivBg.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.width;
    r.size.height = 100*RATIO_WIDHT320;
    self.ivBg.frame = r;
    
    r = self.ivLogo.frame;
    r.size.width = 50*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.ivBg.height - r.size.height)/2.0;
    self.ivLogo.frame = r;
    
    CGSize size = [self.lbCompany sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320 - self.ivLogo.right, MAXFLOAT)];
    r = self.lbCompany.frame;
    r.origin.x = self.ivLogo.right + 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size.height = size.height;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320 - self.ivLogo.right;
    self.lbCompany.frame = r;
    
    CGFloat y = 0;
    if(self.lbCompany.height > 0){
        y = 10*RATIO_WIDHT320;
    }
    size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbName.frame;
    r.origin.x = self.ivLogo.right + 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size = size;
    self.lbName.frame = r;
    
    self.lbCompany.top = self.ivLogo.top + (self.ivLogo.height-(self.lbCompany.height + y + self.lbName.height))/2.0;
    self.lbName.top = self.lbCompany.bottom + y;
    
    
    size = [self.lbTitle sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
    r = self.lbTitle.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.ivBg.bottom + 12*RATIO_WIDHT320;
    r.size = size;
    self.lbTitle.frame = r;
    
    size = [self.btnAll.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.btnAll.frame;
    r.size.width = size.width + 10*RATIO_WIDHT320;
    r.size.height = self.lbTitle.height + 24*RATIO_WIDHT320;
    r.origin.y = self.ivBg.bottom;
    r.origin.x = self.width - r.size.width - 10*RATIO_WIDHT320;
    self.btnAll.frame = r;
    
    r = self.btnAll.imageView.frame;
    r.size.width = 10*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnAll.imageView.frame = r;
    
    [self.btnAll setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.btnAll.imageView.size.width, 0, self.btnAll.imageView.size.width)];
    [self.btnAll setImageEdgeInsets:UIEdgeInsetsMake(0, size.width, 0, -size.width)];

    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.lbTitle.bottom + 12*RATIO_WIDHT320;
    self.vLine.frame = r;
    
    CGFloat w = DEVICEWIDTH / 4.0;
    r = self.vConfirm.frame;
    r.size.width = w;
    r.size.height = [ViewBtnHeaderMine calHeight];
    r.origin.x = 0;
    r.origin.y = self.vLine.bottom;
    self.vConfirm.frame = r;
    
    r = self.vAudution.frame;
    r.size.width = w;
    r.size.height = [ViewBtnHeaderMine calHeight];
    r.origin.x = self.vConfirm.right;
    r.origin.y = self.vLine.bottom;
    self.vAudution.frame = r;
    
    r = self.vUnSend.frame;
    r.size.width = w;
    r.size.height = [ViewBtnHeaderMine calHeight];
    r.origin.x = self.vAudution.right;
    r.origin.y = self.vLine.bottom;
    self.vUnSend.frame = r;
    
    r = self.vUnReceive.frame;
    r.size.width = w;
    r.size.height = [ViewBtnHeaderMine calHeight];
    r.origin.x = self.vUnSend.right;
    r.origin.y = self.vLine.bottom;
    self.vUnReceive.frame = r;
}

+ (CGFloat)calHeight{
    return 100*RATIO_WIDHT320 + 38*RATIO_WIDHT320 + 0.5 + [ViewBtnHeaderMine calHeight];
}

@end
