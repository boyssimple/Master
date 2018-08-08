//
//  CellOrderCheckAccount.m
//  LeftMaster
//
//  Created by simple on 2018/4/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellOrderCheckAccount.h"

@interface CellOrderCheckAccount()
@property(nonatomic,strong)UILabel *lbYear;
@property(nonatomic,strong)UILabel *lbPayAmount;
@property(nonatomic,strong)UILabel *lbPayedAmount;
@property(nonatomic,strong)UILabel *lbAmount;
@property(nonatomic,strong)UILabel *lbValue;
@end
@implementation CellOrderCheckAccount


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _lbYear = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbYear.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbYear.textColor = RGB(0, 0, 0);
        _lbYear.text = @"年月";
        _lbYear.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbYear];
        
        _lbPayAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPayAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPayAmount.textColor = RGB(0, 0, 0);
        _lbPayAmount.text = @"应付金额";
        _lbPayAmount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbPayAmount];
        
        _lbPayedAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPayedAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPayedAmount.textColor = RGB(0, 0, 0);
        _lbPayedAmount.text = @"已付金额";
        _lbPayedAmount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbPayedAmount];
        
        _lbAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbAmount.textColor = RGB(0, 0, 0);
        _lbAmount.text = @"欠款总金额";
        _lbAmount.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbAmount];
        
        _lbValue = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbValue.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbValue.textColor = RGB(0, 0, 0);
        _lbValue.text = @"征信值";
        _lbValue.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbValue];
    }
    return self;
}

- (void)updateData{
    
}

- (void)updateData:(NSDictionary*)data{
    self.lbYear.text = [data jk_stringForKey:@"NC_DATE"];
    self.lbPayAmount.text = [data jk_stringForKey:@"TOTALPRICE"];
    self.lbPayedAmount.text = [data jk_stringForKey:@"COLLECTION"];
    self.lbAmount.text = [data jk_stringForKey:@"ARREARS"];
    self.lbValue.text = [data jk_stringForKey:@"CREDIT_VALUE"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = DEVICEWIDTH / 5.0;
    CGRect r = self.lbYear.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbYear.frame = r;
    
    r = self.lbPayAmount.frame;
    r.origin.x = w;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbPayAmount.frame = r;
    
    r = self.lbPayedAmount.frame;
    r.origin.x = 2*w;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbPayedAmount.frame = r;
    
    r = self.lbAmount.frame;
    r.origin.x = 3*w;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbAmount.frame = r;
    
    r = self.lbValue.frame;
    r.origin.x = 4*w;
    r.origin.y = 0;
    r.size.width = w;
    r.size.height = self.height;
    self.lbValue.frame = r;
}

+ (CGFloat)calHeight{
    return 30*RATIO_WIDHT320;
}

@end
