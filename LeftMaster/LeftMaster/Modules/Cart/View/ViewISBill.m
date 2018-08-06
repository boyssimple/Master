//
//  ViewGoodsList.m
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewISBill.h"

@interface ViewISBill()<UITextFieldDelegate>

@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIView *vBg;

@property(nonatomic,strong)UILabel *lbIsBill;
@property(nonatomic,strong)UIButton *btnYes;
@property(nonatomic,strong)UIButton *btnNo;
@property(nonatomic,strong)UILabel *lbYes;
@property(nonatomic,strong)UILabel *lbNo;

@property(nonatomic,strong)UILabel *lbCompany;
@property(nonatomic,strong)UIView *vCompany;
@property(nonatomic,strong)UILabel *lbCompanyText;
@property(nonatomic,strong)UILabel *lbVerifyCode;
@property(nonatomic,strong)UIButton *btnArrow;

@end

@implementation ViewISBill

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB(0, 0, 0);
        _lbTitle.text = @"是否开具发票";
        [self addSubview:_lbTitle];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
        
        _vBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vBg.backgroundColor = RGB3(252);
        [self addSubview:_vBg];
        
        _lbIsBill = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbIsBill.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbIsBill.textColor = RGB3(51);
        _lbIsBill.text = @"是否开具发票";
        [_vBg addSubview:_lbIsBill];
        
        _btnYes = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnYes setImage:[UIImage imageNamed:@"order_check_normal"] forState:UIControlStateNormal];
        [_btnYes setImage:[UIImage imageNamed:@"order_check_selected"] forState:UIControlStateSelected];
        [_btnYes addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnYes.tag = 100;
        [_vBg addSubview:_btnYes];
        
        _btnNo = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnNo setImage:[UIImage imageNamed:@"order_check_normal"] forState:UIControlStateNormal];
        [_btnNo setImage:[UIImage imageNamed:@"order_check_selected"] forState:UIControlStateSelected];
        [_btnNo addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnNo.tag = 101;
        [_vBg addSubview:_btnNo];
        
        _lbYes = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbYes.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbYes.textColor = RGB3(51);
        _lbYes.text = @"是";
        [_vBg addSubview:_lbYes];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNo.textColor = RGB3(51);//153
        _lbNo.text = @"否";
        [_vBg addSubview:_lbNo];
        
        _lbCompany = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCompany.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbCompany.textColor = RGB3(51);//153
        _lbCompany.text = @"开票单位：";
        [_vBg addSubview:_lbCompany];
        
        
        _vCompany = [[UIView alloc]initWithFrame:CGRectZero];
        _vCompany.layer.borderColor = RGB3(240).CGColor;
        _vCompany.layer.borderWidth = 0.5;
        _vCompany.backgroundColor = [UIColor whiteColor];
        _vCompany.userInteractionEnabled = TRUE;
        [_vBg addSubview:_vCompany];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectCustom)];
        [_vCompany addGestureRecognizer:tap];
        
        _lbCompanyText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCompanyText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbCompanyText.textColor = RGB3(51);
        [_vCompany addSubview:_lbCompanyText];
        
        _btnArrow = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnArrow setImage:[UIImage imageNamed:@"icon_down_normal"] forState:UIControlStateNormal];
        [_btnArrow setImage:[UIImage imageNamed:@"icon_up_normal"] forState:UIControlStateSelected];
        [_btnArrow addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnArrow.tag = 102;
        [_vCompany addSubview:_btnArrow];
        
        _lbVerifyCode = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbVerifyCode.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbVerifyCode.textColor = RGB3(51);//153
        _lbVerifyCode.text = @"纳税人识别号：";
        [_vBg addSubview:_lbVerifyCode];
    }
    return self;
}

- (void)selectCustom{
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:0];
    }
}

- (void)clickAction:(UIButton*)sender{
    if(sender.tag == 102){
        [self selectCustom];
    }else{
        self.btnYes.selected = FALSE;
        self.btnNo.selected = FALSE;
        self.lbYes.textColor = RGB3(153);
        self.lbNo.textColor = RGB3(153);
        if(sender.tag == 100){
            self.btnYes.selected = TRUE;
            self.lbYes.textColor = RGB3(51);
            if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
                [self.delegate clickActionWithIndex:1];
            }
        }else{
            self.btnNo.selected = TRUE;
            self.lbNo.textColor = RGB3(51);
            if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
                [self.delegate clickActionWithIndex:2];
            }
        }
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)updateData:(Custom*)cust{
    if (cust.fd_default) {
        [self clickAction:self.btnYes];
    }else{
        [self clickAction:self.btnNo];
    }
    _lbCompanyText.text = cust.fd_bill_org_name;
    _lbVerifyCode.text = @"纳税人识别号：暂无";
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbTitle.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 12*RATIO_WIDHT320;
    r.size.width = self.width - 20*RATIO_WIDHT320;
    r.size.height = 14*RATIO_WIDHT320;
    self.lbTitle.frame = r;
    
    r = self.vLine.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbTitle.bottom + 12*RATIO_WIDHT320;
    r.size.width = self.width - 20*RATIO_WIDHT320;
    r.size.height = 0.5;
    self.vLine.frame = r;
    
    r = self.vBg.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = self.height - self.vLine.bottom;
    r.origin.x = 0;
    r.origin.y = self.vLine.bottom;
    self.vBg.frame = r;
    
    CGSize size = [self.lbIsBill sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbIsBill.frame;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    r.size.width = size.width;
    r.size.height = size.height;
    self.lbIsBill.frame = r;
    
    r = self.btnYes.frame;
    r.size.width = 20*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.lbIsBill.right + 5*RATIO_WIDHT320;
    r.origin.y = self.lbIsBill.top + (self.lbIsBill.height - r.size.height)/2.0;
    self.btnYes.frame = r;
    
    r = self.btnYes.imageView.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnYes.imageView.frame = r;
    
    size = [self.lbYes sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbYes.frame;
    r.origin.x = self.btnYes.right + 5*RATIO_WIDHT320;
    r.origin.y = self.btnYes.top + (self.btnYes.height - size.height)/2.0;
    r.size = size;
    self.lbYes.frame = r;
    
    r = self.btnNo.frame;
    r.size.width = 20*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.lbYes.right + 20*RATIO_WIDHT320;
    r.origin.y = self.btnYes.top + (self.btnYes.height - r.size.height)/2.0;
    self.btnNo.frame = r;
    
    r = self.btnNo.imageView.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnNo.imageView.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.origin.x = self.btnNo.right + 5*RATIO_WIDHT320;
    r.origin.y = self.btnNo.top + (self.btnNo.height - size.height)/2.0;
    r.size = size;
    self.lbNo.frame = r;
    
    size = [self.lbCompany sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbCompany.frame;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = self.lbIsBill.bottom + 15*RATIO_WIDHT320;
    r.size = size;
    self.lbCompany.frame = r;
    
    r = self.vCompany.frame;
    r.size.width = 150*RATIO_WIDHT320;
    r.size.height = 20*RATIO_WIDHT320;
    r.origin.x = self.lbCompany.right;
    r.origin.y = self.lbCompany.top + (self.lbCompany.height - r.size.height)/2.0;
    self.vCompany.frame = r;
    
    r = self.lbCompanyText.frame;
    r.size.width = self.vCompany.width - 10 - 20*RATIO_WIDHT320;
    r.size.height = self.vCompany.height;
    r.origin.x = 5;
    r.origin.y = 0;
    self.lbCompanyText.frame = r;
    
    r = self.btnArrow.frame;
    r.size.width = 20*RATIO_WIDHT320;
    r.size.height = 20*RATIO_WIDHT320;
    r.origin.x = self.vCompany.width - r.size.width;
    r.origin.y = (self.vCompany.height - r.size.height)/2.0;
    self.btnArrow.frame = r;
                  
    size = [self.lbVerifyCode sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbVerifyCode.frame;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    r.size = size;
    self.lbVerifyCode.frame = r;
}

+ (CGFloat)calHeight{
    return 40.5*RATIO_WIDHT320 + 100*RATIO_WIDHT320;
}

@end

