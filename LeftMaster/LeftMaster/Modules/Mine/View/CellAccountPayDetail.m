//
//  CellAccountList.m
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellAccountPayDetail.h"
@interface CellAccountPayDetail()
@property(nonatomic,strong)UILabel *lbAmount;
@property(nonatomic,strong)UILabel *lbAmountText;
@property(nonatomic,strong)UILabel *lbDate;
@property(nonatomic,strong)UIView *vLine;
@end

@implementation CellAccountPayDetail


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbAmount.textColor = APP_BLACK_COLOR;
        _lbAmount.text = @"付款金额：";
        [self addSubview:_lbAmount];
        
        _lbAmountText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAmountText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbAmountText.textColor = APP_COLOR;
        [self addSubview:_lbAmountText];
        
        _lbDate = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbDate.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbDate.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbDate];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = APP_Gray_COLOR;
        [self addSubview:_vLine];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    
}

- (void)updateData{
    self.lbAmountText.text = @"¥1300";
    self.lbDate.text = @"2018-12-11";
}

- (void)updateData:(NSDictionary*)data{
    
    self.lbAmountText.text = [NSString stringWithFormat:@"¥%@",[data jk_stringForKey:@"FD_TOTAL_MONEY"]];
    self.lbDate.text = [data jk_stringForKey:@"FD_BUSI_TIME"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbAmount sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    CGRect r = self.lbAmount.frame;
    r.size.height = size.height;
    r.size.width = size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    self.lbAmount.frame = r;
    
    size = [self.lbAmountText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbAmountText.frame;
    r.size = size;
    r.origin.x = self.lbAmount.right;
    r.origin.y = (self.height - size.height)/2.0;
    self.lbAmountText.frame = r;
    
    size = [self.lbDate sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbDate.frame;
    r.origin.x = DEVICEWIDTH - size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    r.size = size;
    self.lbDate.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 1;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end
