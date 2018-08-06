//
//  CellAccountList.m
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellAccountList.h"
@interface CellAccountList()
@property(nonatomic,strong)UILabel *lbCompany;
@property(nonatomic,strong)UILabel *lbStatus;
@property(nonatomic,strong)UILabel *lbYear;
@property(nonatomic,strong)UILabel *lbYearText;
@property(nonatomic,strong)UILabel *lbAmount;
@property(nonatomic,strong)UILabel *lbAmountText;
@property(nonatomic,strong)UILabel *lbPayAmount;
@property(nonatomic,strong)UILabel *lbPayAmountText;



@property(nonatomic,strong)UILabel *lbBegin;
@property(nonatomic,strong)UILabel *lbBeginText;
@property(nonatomic,strong)UILabel *lbEnd;
@property(nonatomic,strong)UILabel *lbEndText;

@property(nonatomic,strong)UIButton *btnConfirm;
@property(nonatomic,strong)UIView *vLine;
@end

@implementation CellAccountList


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbCompany = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCompany.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbCompany.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbCompany];
        
        _lbStatus = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbStatus.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbStatus.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbStatus];
        
        _lbYear = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbYear.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbYear.textColor = APP_BLACK_COLOR;
        _lbYear.text = @"年月";
        [self addSubview:_lbYear];
        
        _lbYearText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbYearText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbYearText.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbYearText];
        
        _lbAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbAmount.textColor = APP_BLACK_COLOR;
        _lbAmount.text = @"订单金额";
        [self addSubview:_lbAmount];
        
        _lbAmountText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAmountText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbAmountText.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbAmountText];
        
        _lbPayAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPayAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPayAmount.textColor = APP_BLACK_COLOR;
        _lbPayAmount.text = @"已付款金额";
        [self addSubview:_lbPayAmount];
        
        _lbPayAmountText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPayAmountText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPayAmountText.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbPayAmountText];
        
        
        _lbBegin = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbBegin.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbBegin.textColor = APP_BLACK_COLOR;
        _lbBegin.text = @"期初余额";
        [self addSubview:_lbBegin];
        
        _lbBeginText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbBeginText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbBeginText.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbBeginText];
        
        _lbEnd = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbEnd.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbEnd.textColor = APP_BLACK_COLOR;
        _lbEnd.text = @"期末余额";
        [self addSubview:_lbEnd];
        
        _lbEndText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbEndText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbEndText.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbEndText];
        
        _btnConfirm = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnConfirm setTitle:@"确认" forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _btnConfirm.backgroundColor = APP_COLOR;
        [_btnConfirm addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnConfirm];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = APP_Gray_COLOR;
        [self addSubview:_vLine];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(confirmBill:)]) {
        [self.delegate confirmBill:self.index];
    }
}

- (void)updateData{
    self.lbCompany.text = @"何南正威有限公司";
    self.lbStatus.text = @"待确认";
    self.lbYearText.text = @"2017-08";
    self.lbAmountText.text = @"¥2000";
    self.lbPayAmountText.text = @"¥2000";
    if(self.type == 1){
        self.btnConfirm.hidden = YES;
    }else{
        self.btnConfirm.hidden = NO;
    }
}

- (void)updateData:(NSDictionary*)data{
    self.lbCompany.text = [data jk_stringForKey:@"FD_CUSTOMER_ID_LABELS"];
    self.lbStatus.text = [data jk_stringForKey:@"FD_CONFIRM_STATUS_NAME"];
    self.lbYearText.text = [data jk_stringForKey:@"FD_MONTH"];
    self.lbAmountText.text = [NSString stringWithFormat:@"¥%@",[data jk_stringForKey:@"FD_ORDER_MONEY"]];
    self.lbPayAmountText.text = [NSString stringWithFormat:@"¥%@",[data jk_stringForKey:@"FD_PAYED_MONEY"]];
    
    self.lbBeginText.text = [NSString stringWithFormat:@"¥%@",[data jk_stringForKey:@"FD_BEGIN_MONEY"]];
    self.lbEndText.text = [NSString stringWithFormat:@"¥%@",[data jk_stringForKey:@"FD_END_MONEY"]];
    
    if(self.type == 1){
        self.btnConfirm.hidden = YES;
    }else{
        self.btnConfirm.hidden = NO;
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbStatus sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    CGRect r = self.lbStatus.frame;
    r.origin.x = DEVICEWIDTH - 10*RATIO_WIDHT320 - size.width;
    r.origin.y = 10*RATIO_WIDHT320;
    r.size = size;
    self.lbStatus.frame = r;
    
    size = [self.lbCompany sizeThatFits:CGSizeMake(self.lbStatus.left - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbCompany.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 10*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = self.lbStatus.left - 20*RATIO_WIDHT320;
    self.lbCompany.frame = r;
    
    self.lbStatus.top = self.lbCompany.top + (self.lbCompany.height - self.lbStatus.height)/2.;
    
    size = [self.lbYear sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbYear.frame;
    r.size.height = size.height;
    r.size.width = 90*RATIO_WIDHT320;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    self.lbYear.frame = r;
    
    size = [self.lbYearText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbYearText.frame;
    r.size = size;
    r.origin.x = self.lbYear.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbCompany.bottom + 15*RATIO_WIDHT320;
    self.lbYearText.frame = r;
    
    size = [self.lbAmount sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbAmount.frame;
    r.size.height = size.height;
    r.size.width = self.lbYear.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbYear.bottom + 10*RATIO_WIDHT320;
    self.lbAmount.frame = r;
    
    size = [self.lbAmountText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbAmountText.frame;
    r.size = size;
    r.origin.x = self.lbYear.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbYear.bottom + 10*RATIO_WIDHT320;
    self.lbAmountText.frame = r;
    
    
    
    size = [self.lbPayAmount sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbPayAmount.frame;
    r.size.height = size.height;
    r.size.width = self.lbYear.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbAmount.bottom + 10*RATIO_WIDHT320;
    self.lbPayAmount.frame = r;
    
    size = [self.lbPayAmountText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbPayAmountText.frame;
    r.size = size;
    r.origin.x = self.lbYear.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbAmount.bottom + 10*RATIO_WIDHT320;
    self.lbPayAmountText.frame = r;
    
    
    
    size = [self.lbBegin sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbBegin.frame;
    r.size.height = size.height;
    r.size.width = self.lbYear.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbPayAmount.bottom + 10*RATIO_WIDHT320;
    self.lbBegin.frame = r;
    
    size = [self.lbBeginText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbBeginText.frame;
    r.size = size;
    r.origin.x = self.lbYear.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbPayAmount.bottom + 10*RATIO_WIDHT320;
    self.lbBeginText.frame = r;
    
    
    size = [self.lbEnd sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbEnd.frame;
    r.size.height = size.height;
    r.size.width = self.lbYear.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbBegin.bottom + 10*RATIO_WIDHT320;
    self.lbEnd.frame = r;
    
    size = [self.lbEndText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbEndText.frame;
    r.size = size;
    r.origin.x = self.lbYear.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbBegin.bottom + 10*RATIO_WIDHT320;
    self.lbEndText.frame = r;
    
    r = self.btnConfirm.frame;
    r.size.width = 50*RATIO_WIDHT320;
    r.size.height = 20*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - 10*RATIO_WIDHT320 - r.size.width;
    r.origin.y = self.lbEnd.top + (self.lbEnd.height - r.size.height)/2.0;
    self.btnConfirm.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 1;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 165*RATIO_WIDHT320;
}

@end
