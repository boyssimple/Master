//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellOrderList.h"

@interface CellOrderList()
@property(nonatomic,strong)UIView *vDot;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UILabel *lbStatus;
@property(nonatomic,strong)UIView *vBg;
@property(nonatomic,strong)UILabel *lbCompany;

@property(nonatomic,strong)UILabel *lbOrderAmount;
@property(nonatomic,strong)UILabel *lbOrderAmountText;

@property(nonatomic,strong)UILabel *lbOrder;
@property(nonatomic,strong)UILabel *lbOrderText;

@property(nonatomic,strong)UILabel *lbCotact;
@property(nonatomic,strong)UILabel *lbCotactText;

@property(nonatomic,strong)UILabel *lbOrderTime;
@property(nonatomic,strong)UILabel *lbOrderTimeText;

@property(nonatomic,strong)UIButton *btnAgain;
@property(nonatomic,strong)UIButton *btnReceive;
@property(nonatomic,strong)UIButton *btnConfirm;
@property(nonatomic,strong)UIButton *btnCancel;

@end
@implementation CellOrderList

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _vDot = [[UIView alloc]initWithFrame:CGRectZero];
        _vDot.backgroundColor = APP_COLOR;
        _vDot.layer.cornerRadius = 3.5*RATIO_WIDHT320*0.5;
        _vDot.layer.masksToBounds = YES;
        [self.contentView addSubview:_vDot];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont boldSystemFontOfSize:15*RATIO_WIDHT320];
        _lbNo.textColor = RGB(0, 0, 0);
        [self addSubview:_lbNo];
        
        _lbStatus = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbStatus.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbStatus.textColor = RGB3(153);
        [self addSubview:_lbStatus];
        
        _vBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vBg.backgroundColor = RGB3(247);
        _vBg.layer.cornerRadius = 3.f;
        _vBg.layer.masksToBounds = YES;
        [self.contentView addSubview:_vBg];
        
        _lbCompany = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCompany.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbCompany.textColor = RGB3(0);
        [_vBg addSubview:_lbCompany];
        
        _lbOrderAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderAmount.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderAmount.textColor = RGB3(102);
        _lbOrderAmount.text = @"订单金额";
        [_vBg addSubview:_lbOrderAmount];
        
        _lbOrderAmountText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderAmountText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderAmountText.textColor = RGB3(102);
        [_vBg addSubview:_lbOrderAmountText];
        
        _lbOrder = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrder.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrder.textColor = RGB3(102);
        _lbOrder.text = @"订单人";
        [_vBg addSubview:_lbOrder];
        
        _lbOrderText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderText.textColor = RGB3(102);
        [_vBg addSubview:_lbOrderText];
        
        _lbCotact = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCotact.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbCotact.textColor = RGB3(102);
        _lbCotact.text = @"联系方式";
        [_vBg addSubview:_lbCotact];
        
        _lbCotactText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCotactText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbCotactText.textColor = RGB3(102);
        [_vBg addSubview:_lbCotactText];
        
        _lbOrderTime = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderTime.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderTime.textColor = RGB3(102);
        _lbOrderTime.text = @"下单时间";
        [_vBg addSubview:_lbOrderTime];
        
        _lbOrderTimeText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbOrderTimeText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbOrderTimeText.textColor = RGB3(102);
        [_vBg addSubview:_lbOrderTimeText];
        
        _btnReceive = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnReceive setTitle:@"签收" forState:UIControlStateNormal];
        _btnReceive.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnReceive setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnReceive.tag = 100;
        [_btnReceive addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnReceive.backgroundColor = APP_COLOR;
        [_vBg addSubview:_btnReceive];
        
        _btnCancel = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnCancel.tag = 101;
        [_btnCancel addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnCancel.backgroundColor = APP_COLOR;
        [_vBg addSubview:_btnCancel];
        
        _btnConfirm = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnConfirm.tag = 102;
        [_btnConfirm addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.backgroundColor = APP_COLOR;
        [_vBg addSubview:_btnConfirm];
        
        _btnAgain = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnAgain setTitle:@"再来一单" forState:UIControlStateNormal];
        _btnAgain.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnAgain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnAgain.tag = 103;
        [_btnAgain addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnAgain.backgroundColor = APP_COLOR;
        [_vBg addSubview:_btnAgain];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self.contentView addSubview:_vLine];
    }
    return self;
}


- (void)clickAction:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex: withDataIndex:)]) {
        [self.delegate clickActionWithIndex:sender.tag-100 withDataIndex:self.index];
    }
}

- (void)updateData:(NSDictionary*)data{
    self.lbNo.text = [data jk_stringForKey:@"FD_NO"];
    self.lbStatus.text = [data jk_stringForKey:@"FD_ORDER_STATUS_NAME"];
    self.lbCompany.text = [data jk_stringForKey:@"fd_name"];
    
    self.lbOrderAmountText.text = [NSString stringWithFormat:@"¥%@",[data jk_stringForKey:@"FD_TOTAL_PRICE"]];
    self.lbOrderText.text = [data jk_stringForKey:@"SYSUSER_NAME"];
    
    self.lbCotactText.text = [data jk_stringForKey:@"SYSUSER_MOBILE"];
    self.lbOrderTimeText.text = [data jk_stringForKey:@"FD_ORDER_DATE"];

    self.status = [data jk_integerForKey:@"FD_ORDER_STATUS"];
    self.btnConfirm.hidden = YES;
    self.btnReceive.hidden = YES;
    self.btnCancel.hidden = YES;
    if(self.status == 0){
        if(![AppUser share].isSalesman){
            self.btnConfirm.hidden = NO;
        }
        self.btnCancel.hidden = NO;
    }else if(self.status == 1){
        self.btnCancel.hidden = NO;
    }else if(self.status == 3){
        self.btnReceive.hidden = NO;
    }
}

- (void)updateData{
    self.lbNo.text = @"DH.20180118.001";
    self.lbStatus.text = @"待审核";
    self.lbCompany.text = @"重庆江北机械有限公司";
    
    self.lbOrderAmountText.text = @"¥???.00";
    self.lbOrderText.text = @"管理员";
    self.lbCotactText.text = @"15909327516";
    self.lbOrderTimeText.text = @"2018-01-18";
    
    self.btnConfirm.hidden = YES;
    self.btnReceive.hidden = YES;
    self.btnCancel.hidden = YES;
    if(self.status == 0){
        if(![AppUser share].isSalesman){
            self.btnConfirm.hidden = NO;
        }
        self.btnCancel.hidden = NO;
    }else if(self.status == 1){
        self.btnCancel.hidden = NO;
    }else if(self.status == 3){
        self.btnReceive.hidden = NO;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect r = self.vDot.frame;
    r.size.width = 3.5*RATIO_WIDHT320;
    r.size.height = r.size.width ;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    self.vDot.frame = r;
    
    CGSize size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 15*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.origin.x = self.vDot.right +5*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    r.size = size;
    self.lbNo.frame = r;
    
    self.vDot.top = self.lbNo.top + (self.lbNo.height - self.vDot.height)/2.0;
    
    size = [self.lbStatus sizeThatFits:CGSizeMake(MAXFLOAT, 15*RATIO_WIDHT320)];
    r = self.lbStatus.frame;
    r.origin.x = DEVICEWIDTH - size.width - 20*RATIO_WIDHT320;
    r.origin.y = self.lbNo.top + (self.lbNo.height - size.height)/2.0;
    r.size = size;
    self.lbStatus.frame = r;
    
    r = self.vBg.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 100*RATIO_WIDHT320 ;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbNo.bottom + 6*RATIO_WIDHT320;
    self.vBg.frame = r;
    
    size = [self.lbCompany sizeThatFits:CGSizeMake(self.vBg.width - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbCompany.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 10*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = self.vBg.width - 20*RATIO_WIDHT320;
    self.lbCompany.frame = r;
    
    size = [self.lbOrderAmount sizeThatFits:CGSizeMake(55*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbOrderAmount.frame;
    r.origin.x = 20*RATIO_WIDHT320;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = 55*RATIO_WIDHT320;
    self.lbOrderAmount.frame = r;
    
    size = [self.lbOrderAmountText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbOrderAmountText.frame;
    r.origin.x = self.lbOrderAmount.right;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderAmountText.frame = r;
    
    size = [self.lbOrder sizeThatFits:CGSizeMake(self.lbOrderAmount.width, MAXFLOAT)];
    r = self.lbOrder.frame;
    r.size.height = size.height;
    r.size.width = self.lbOrderAmount.width;
    r.origin.x = self.vBg.width - r.size.width - 75*RATIO_WIDHT320;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    self.lbOrder.frame = r;
    
    size = [self.lbOrderText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbOrderText.frame;
    r.origin.x = self.lbOrder.right;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderText.frame = r;
    
    size = [self.lbCotact sizeThatFits:CGSizeMake(self.lbOrderAmount.width, MAXFLOAT)];
    r = self.lbCotact.frame;
    r.size.height = size.height;
    r.size.width = self.lbOrderAmount.width;
    r.origin.x = self.vBg.width - r.size.width - 75*RATIO_WIDHT320;
    r.origin.y = self.lbOrder.bottom + 8*RATIO_WIDHT320;
    self.lbCotact.frame = r;
    
    size = [self.lbCotactText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbCotactText.frame;
    r.origin.x = self.lbCotact.right;
    r.origin.y = self.lbOrder.bottom + 8*RATIO_WIDHT320;
    r.size = size;
    self.lbCotactText.frame = r;
    
    size = [self.lbOrderTime sizeThatFits:CGSizeMake(self.lbOrderAmount.width, MAXFLOAT)];
    r = self.lbOrderTime.frame;
    r.size.height = size.height;
    r.size.width = self.lbOrderAmount.width;
    r.origin.x = self.lbOrderAmount.left;
    r.origin.y = self.lbOrderAmount.bottom + 8*RATIO_WIDHT320;
    self.lbOrderTime.frame = r;
    
    size = [self.lbOrderTimeText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbOrderTimeText.frame;
    r.origin.x = self.lbOrderTime.right;
    r.origin.y = self.lbOrderAmount.bottom + 8*RATIO_WIDHT320;
    r.size = size;
    self.lbOrderTimeText.frame = r;
    
    r = self.btnReceive.frame;
    r.size.width = 35*RATIO_WIDHT320;
    r.size.height = 18*RATIO_WIDHT320;
    r.origin.x = self.vBg.width - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbOrderTime.bottom + 8*RATIO_WIDHT320;
    self.btnReceive.frame = r;
    
    r = self.btnCancel.frame;
    r.size.width = 35*RATIO_WIDHT320;
    r.size.height = 18*RATIO_WIDHT320;
    r.origin.x = self.vBg.width - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbOrderTime.bottom + 8*RATIO_WIDHT320;
    self.btnCancel.frame = r;
    
    r = self.btnConfirm.frame;
    r.size.width = 35*RATIO_WIDHT320;
    r.size.height = 18*RATIO_WIDHT320;
    r.origin.x = self.vBg.width - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbOrderTime.bottom + 8*RATIO_WIDHT320;
    self.btnConfirm.frame = r;
    
    r = self.btnAgain.frame;
    r.size.width = 45*RATIO_WIDHT320;
    r.size.height = 18*RATIO_WIDHT320;
    r.origin.x = self.vBg.width - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbOrderTime.bottom + 8*RATIO_WIDHT320;
    self.btnAgain.frame = r;
    
    if (self.status == 0) {
        self.btnCancel.left = self.vBg.width - self.btnCancel.width - 10*RATIO_WIDHT320;
        if(![AppUser share].isSalesman){
            self.btnConfirm.hidden = NO;
            self.btnConfirm.left = self.btnCancel.left - 10*RATIO_WIDHT320 - self.btnConfirm.width;
            self.btnAgain.left = self.btnConfirm.left - 10*RATIO_WIDHT320 - self.btnAgain.width;
        }else{
            self.btnAgain.left = self.btnCancel.left - 10*RATIO_WIDHT320 - self.btnAgain.width;
        }
    }else if(self.status == 1){
        self.btnCancel.left = self.vBg.width - self.btnCancel.width - 10*RATIO_WIDHT320;
        self.btnAgain.left = self.btnCancel.left - 10*RATIO_WIDHT320 - self.btnAgain.width;
    }else if(self.status == 2){
        self.btnAgain.left = self.vBg.width - self.btnAgain.width - 10*RATIO_WIDHT320;
    }else if(self.status == 3){
        self.btnReceive.left = self.vBg.width - self.btnReceive.width - 10*RATIO_WIDHT320;
        self.btnAgain.left = self.btnReceive.left - 10*RATIO_WIDHT320 - self.btnAgain.width;
    }else if(self.status == 4 || self.status == 5 || self.status == 6){//已完成
        self.btnAgain.left = self.vBg.width - self.btnAgain.width - 10*RATIO_WIDHT320;
    }
    
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 0.5;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.vBg.bottom + 15*RATIO_WIDHT320;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 150*RATIO_WIDHT320;
}

@end



