//
//  CellAccountList.m
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellAccountDetail.h"
@interface CellAccountDetail()
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbGoodsNo;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UILabel *lbNum;
@property(nonatomic,strong)UILabel *lbTotal;
@property(nonatomic,strong)UILabel *lbDate;
@property(nonatomic,strong)UIView *vLine;
@end

@implementation CellAccountDetail


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbName];
        
        _lbGoodsNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbGoodsNo.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbGoodsNo.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbGoodsNo];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNo.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbNo];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPrice.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbPrice];
        
        _lbNum = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNum.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNum.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbNum];
        
        _lbTotal = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTotal.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbTotal.textColor = APP_BLACK_COLOR;
        [self addSubview:_lbTotal];
        
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
    self.lbName.text = @"何南正威有限公司";
    self.lbGoodsNo.text = @"待确认";
    self.lbNo.text = @"2017-08";
    self.lbPrice.text = @"¥2000";
    self.lbNum.text = @"¥2000";
    self.lbTotal.text = @"¥2000";
    self.lbDate.text = @"¥2000";
}

- (void)updateData:(NSDictionary*)data{
    
    self.lbName.text = [data jk_stringForKey:@"FD_GOODS_ID_LABELS"];
    self.lbGoodsNo.text = [NSString stringWithFormat:@"商品编码：%@",[data jk_stringForKey:@"FD_GOODS_CODE"]];
    self.lbNo.text = [NSString stringWithFormat:@"单据编号：%@",[data jk_stringForKey:@"BILL_NO"]];
    self.lbPrice.text = [NSString stringWithFormat:@"¥%@/%@",[data jk_stringForKey:@"FD_UNIT_PRICE"],[data jk_stringForKey:@"FD_UNIT_NAME"]];
    self.lbNum.text = [NSString stringWithFormat:@"¥%zi/%@",[data jk_integerForKey:@"FD_NUM"],[data jk_stringForKey:@"FD_UNIT_NAME"]];
    self.lbTotal.text = [NSString stringWithFormat:@"合计金额：¥%@",[data jk_stringForKey:@"FD_TOTAL_PRICE"]];
    self.lbDate.text = [data jk_stringForKey:@"FD_BUSI_TIME"];
    
    NSString *price = [NSString stringWithFormat:@"¥%@",[data jk_stringForKey:@"FD_UNIT_PRICE"]];
    NSInteger length = 0;
    if (price) {
        length += price.length;
    }
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, length)];
    [self.lbPrice setAttributedText:noteStr];
    
    
    NSInteger length2 = @"合计金额：".length;
    NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:self.lbTotal.text];
    [noteStr2 addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(length2, self.lbTotal.text.length-length2)];
    [self.lbTotal setAttributedText:noteStr2];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(DEVICEWIDTH-20*RATIO_WIDHT320, MAXFLOAT)];
    CGRect r = self.lbName.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 10*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    self.lbName.frame = r;
    
    size = [self.lbGoodsNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbGoodsNo.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbName.bottom +10*RATIO_WIDHT320;
    r.size = size;
    self.lbGoodsNo.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbGoodsNo.bottom +10*RATIO_WIDHT320;
    r.size = size;
    self.lbNo.frame = r;
    
    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbNo.bottom +10*RATIO_WIDHT320;
    r.size = size;
    self.lbPrice.frame = r;
    
    size = [self.lbNum sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNum.frame;
    r.origin.x = DEVICEWIDTH - size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbNo.bottom +10*RATIO_WIDHT320;
    r.size = size;
    self.lbNum.frame = r;
    
    size = [self.lbTotal sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbTotal.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbPrice.bottom +10*RATIO_WIDHT320;
    r.size = size;
    self.lbTotal.frame = r;
    
    size = [self.lbDate sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbDate.frame;
    r.origin.x = DEVICEWIDTH - size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbNum.bottom +10*RATIO_WIDHT320;
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
    return 140*RATIO_WIDHT320;
}

@end
