//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellUnPayOrderContainer.h"

@interface CellUnPayOrderContainer()
@property(nonatomic,strong)UIButton *btnCheck;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UILabel *lbAmount;
@property(nonatomic,strong)UILabel *lbDate;
@property(nonatomic,strong)UILabel *lbPerson;
@property(nonatomic,strong)UILabel *lbPhone;
@property(nonatomic,strong)UIView *vLineTwo;

@end
@implementation CellUnPayOrderContainer

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _btnCheck = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnCheck.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _btnCheck.tag = 100;
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_normal"] forState:UIControlStateNormal];
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_selected"] forState:UIControlStateSelected];
        [_btnCheck addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnCheck];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbNo.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lbNo];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = APP_Gray_COLOR;
        [self.contentView addSubview:_vLine];
        
        _lbAmount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbAmount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbAmount.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lbAmount];
        
        _lbDate = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbDate.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbDate.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lbDate];
        
        _lbPerson = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPerson.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPerson.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lbPerson];
        
        _lbPhone = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPhone.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbPhone.textColor = [UIColor blackColor];
        [self.contentView addSubview:_lbPhone];
        
        _vLineTwo = [[UIView alloc]initWithFrame:CGRectZero];
        _vLineTwo.backgroundColor = APP_Gray_COLOR;
        [self.contentView addSubview:_vLineTwo];
    }
    return self;
}


- (void)clickAction:(UIButton*)sender{
    if (self.clickBlock) {
        self.clickBlock(self.index);
    }
}

- (void)updateData{
    self.lbNo.text = @"OD201805300010";
    self.lbDate.text = @"下单时间：2018-8-8 15:12";
    self.lbPerson.text = @"下单人：张三";
    self.lbPhone.text = @"15909327516";
    self.lbAmount.text = @"订单金额：¥100";
    if(self.lbAmount.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbAmount.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(5, 4)];
        [self.lbAmount setAttributedText:noteStr];
    }
}

- (void)updateData:(NSDictionary*)data{
    self.lbNo.text = [data jk_stringForKey:@"FD_NO"];
    self.lbDate.text = [NSString stringWithFormat:@"下单时间：%@",[data jk_stringForKey:@"FD_ORDER_DATE"]];
    self.lbPerson.text = [NSString stringWithFormat:@"下单人：%@",[data jk_stringForKey:@"SYSUSER_NAME"]];
    self.lbPhone.text = [data jk_stringForKey:@"SYSUSER_MOBILE"];
    self.lbAmount.text = [NSString stringWithFormat:@"订单金额：¥%.2f",[data jk_floatForKey:@"FD_TOTAL_PRICE"]];
    NSString *str = [NSString stringWithFormat:@"¥%.2f",[data jk_floatForKey:@"FD_TOTAL_PRICE"]];
    if(self.lbAmount.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbAmount.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(5, str.length)];
        [self.lbAmount setAttributedText:noteStr];
    }
    
    self.btnCheck.selected = [data jk_boolForKey:@"selected"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.btnCheck.frame;
    r.size.width = 35*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = 0;
    self.btnCheck.frame = r;
    
    r = self.btnCheck.imageView.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnCheck.imageView.frame = r;
    
    CGSize size = [self.lbNo sizeThatFits:CGSizeMake(DEVICEWIDTH - 10*RATIO_WIDHT320 - self.btnCheck.right, MAXFLOAT)];
    r = self.lbNo.frame;
    r.size.height = size.height;
    r.size.width = DEVICEWIDTH - 10*RATIO_WIDHT320 - self.btnCheck.right;
    r.origin.x = self.btnCheck.right;
    r.origin.y = self.btnCheck.top + (self.btnCheck.height - r.size.height)/2.0;
    self.lbNo.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.btnCheck.bottom;
    self.vLine.frame = r;
    
    size = [self.lbAmount sizeThatFits:CGSizeMake(DEVICEWIDTH - 10*RATIO_WIDHT320 - self.btnCheck.right, MAXFLOAT)];
    r = self.lbAmount.frame;
    r.size.height = size.height;
    r.size.width = DEVICEWIDTH - 10*RATIO_WIDHT320 - self.btnCheck.right;
    r.origin.x = self.lbNo.left;
    r.origin.y = self.vLine.bottom + 15*RATIO_WIDHT320;
    self.lbAmount.frame = r;
    
    size = [self.lbDate sizeThatFits:CGSizeMake(self.lbNo.width, MAXFLOAT)];
    r = self.lbDate.frame;
    r.size.height = size.height;
    r.size.width = self.lbNo.width;
    r.origin.x = self.lbNo.left;
    r.origin.y = self.lbAmount.bottom + 15*RATIO_WIDHT320;
    self.lbDate.frame = r;
    
    size = [self.lbPerson sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbPerson.frame;
    r.size = size;
    r.origin.x = self.lbNo.left;
    r.origin.y = self.lbDate.bottom + 15*RATIO_WIDHT320;
    self.lbPerson.frame = r;
    
    size = [self.lbPhone sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbPhone.frame;
    r.size = size;
    r.origin.x = self.lbPerson.right + 40*RATIO_WIDHT320;
    r.origin.y = self.lbDate.bottom + 15*RATIO_WIDHT320;
    self.lbPhone.frame = r;
    
    r = self.vLineTwo.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 5*RATIO_WIDHT320;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLineTwo.frame = r;
}

+ (CGFloat)calHeight{
    return 140*RATIO_WIDHT320 + 0.5;
}

@end
