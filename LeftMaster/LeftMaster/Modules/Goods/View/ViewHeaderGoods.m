//
//  ViewHeaderGoods.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewHeaderGoods.h"
#import "ViewProductRole.h"
@interface ViewHeaderGoods()<CommonDelegate>
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UILabel *lbNoText;
@property(nonatomic,strong)UILabel *lbTopPrice;
@property(nonatomic,strong)UILabel *lbTopPriceText;
@property(nonatomic,strong)UILabel *lbRole;
@property(nonatomic,strong)UILabel *lbStatus;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UIView  *vCountBg;
@property(nonatomic,strong)UIButton *btnMinus;
@property(nonatomic,strong)UIButton *btnAdd;
@property(nonatomic,strong)UITextField *tfCount;
@property(nonatomic,strong)UIView  *vLine;
@property(nonatomic,strong)UILabel *lbDetail;
@property(nonatomic,strong)ViewProductRole  *vRole;

@property(nonatomic,strong)NSDictionary *data;
@end

@implementation ViewHeaderGoods

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.numberOfLines = 0;
        _lbName.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_lbName];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNo.textColor = RGB3(153);
        _lbNo.text = @"商品编码号";
        [self addSubview:_lbNo];
        
        _lbNoText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNoText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNoText.textColor = RGB3(51);
        [self addSubview:_lbNoText];
        
        _vRole = [[ViewProductRole alloc]initWithFrame:CGRectZero];
        _vRole.delegate = self;
        [self addSubview:_vRole];
        
        _lbTopPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTopPrice.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbTopPrice.textColor = RGB3(153);
        _lbTopPrice.text = @"市场价";
        [self addSubview:_lbTopPrice];
        
        _lbTopPriceText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTopPriceText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbTopPriceText.textColor = RGB3(51);
        [self addSubview:_lbTopPriceText];
        
        
        _lbRole = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbRole.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbRole.textColor = RGB(255, 0, 0);
        [self addSubview:_lbRole];
        
        _lbStatus = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbStatus.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbStatus.textColor = RGB3(153);
        [self addSubview:_lbStatus];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:20*RATIO_WIDHT320];
        _lbPrice.textColor = RGB(0, 0, 0);
        [self addSubview:_lbPrice];
        
        _vCountBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vCountBg.layer.borderColor = RGB3(197).CGColor;
        _vCountBg.layer.borderWidth = 0.5f;
        _vCountBg.layer.cornerRadius = 3.f;
        _vCountBg.layer.masksToBounds = YES;
        _vCountBg.clipsToBounds = YES;
        [self addSubview:_vCountBg];
        
        _btnMinus = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnMinus.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnMinus setTitle:@"-" forState:UIControlStateNormal];
        [_btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
        _btnMinus.tag = 103;
        [_btnMinus addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_vCountBg addSubview:_btnMinus];
        
        _btnAdd = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnAdd.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnAdd setTitle:@"+" forState:UIControlStateNormal];
        [_btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnAdd.tag = 104;
        [_btnAdd addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_vCountBg addSubview:_btnAdd];
        
        _tfCount = [[UITextField alloc]initWithFrame:CGRectZero];
        _tfCount.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _tfCount.textColor = RGB(0, 0, 0);
        _tfCount.textAlignment = NSTextAlignmentCenter;
        _tfCount.text = @"1";
        _tfCount.keyboardType = UIKeyboardTypeNumberPad;
        [_tfCount addTarget:self action:@selector(contextChange:) forControlEvents:UIControlEventEditingChanged];
        [_vCountBg addSubview:_tfCount];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(231);
        [self addSubview:_vLine];
        
        _lbDetail = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbDetail.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbDetail.textColor = RGB3(26);
        _lbDetail.text = @"商品详情";
        [self addSubview:_lbDetail];
    }
    return self;
}


- (void)contextChange:(UITextField*)textField{
    NSString *text = textField.text ;
    NSInteger count = 0;
    if (text) {
        count = [text integerValue];
    }
    if (count > 1) {
        [self.btnMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [self.btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
    }
    
    if([self.delegate respondsToSelector:@selector(inputCount:)]){
        [self.delegate inputCount:count];
    }
    
}
- (void)clickAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 101) {
        sender.selected = !sender.selected;
    }else if(tag == 102){
        
    }else if(tag == 103){
        NSString *str = self.tfCount.text;
        if ([str integerValue] > 1) {
            NSInteger c = [str integerValue];
            if(c > 1){
                self.tfCount.text = [NSString stringWithFormat:@"%zi",c-1];
                if([self.delegate respondsToSelector:@selector(minusCount)]){
                    [self.delegate minusCount];
                }
            }
            
            if(c-1 == 1){
                [self.btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
            }
        }
    }else if(tag == 104){
        NSString *str = self.tfCount.text;
        NSInteger c = [str integerValue]+1;
        self.tfCount.text = [NSString stringWithFormat:@"%zi",c];
        if (c > 1) {
            [self.btnMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if([self.delegate respondsToSelector:@selector(addCount)]){
            [self.delegate addCount];
        }
    }
}

- (void)updateData:(NSDictionary*)data with:(NSString*)ID{
    if(data){
        self.data = data;
        self.lbName.text = [data jk_stringForKey:@"GOODS_NAME"];
        self.lbNoText.text = [data jk_stringForKey:@"GOODS_CODE"];
        self.lbTopPriceText.text = [NSString stringWithFormat:@"%.2f/%@",[data jk_floatForKey:@"GOODS_MARKET_PRICE"],[data jk_stringForKey:@"GOODS_UNIT"]];
        
        NSString *str = [data jk_stringForKey:@"GOODS_MARKET_PRICE"];
        if (!str || [str isEqualToString:@"0"] || [str isEqualToString:@"?"] || [str isEqualToString:@""]) {
            self.lbTopPrice.hidden = YES;
            self.lbTopPriceText.hidden = YES;
        }else{
            self.lbTopPrice.hidden = NO;
            self.lbTopPriceText.hidden = NO;
        }
        
        self.lbRole.text = [NSString stringWithFormat:@"库存：%ld",[data jk_integerForKey:@"GOODS_STOCK"]];
        if([data jk_integerForKey:@"GOODS_STOCK"] > 0){
            self.lbStatus.text = @" | 库存充足";
        }else{
            self.lbStatus.text = @" | 库存不足";
        }
        NSInteger count = 1;
        if ([data jk_floatForKey:@"GOODS_PRICE"] == 0) {
            self.lbPrice.text = [NSString stringWithFormat:@"¥?/%@",[data jk_stringForKey:@"GOODS_UNIT"]];
        }else{
            self.lbPrice.text = [NSString stringWithFormat:@"¥%.2f/%@",[data jk_floatForKey:@"GOODS_PRICE"],[data jk_stringForKey:@"GOODS_UNIT"]];
            count = [NSString stringWithFormat:@"%.2f",[data jk_floatForKey:@"GOODS_PRICE"]].length - 2;
        }
        NSInteger length = [data jk_stringForKey:@"GOODS_UNIT"].length + 1;
        if (self.lbPrice.text.length > 0) {
            
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
            // 改变颜色
            [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-length)];
            
            [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*RATIO_WIDHT320] range:NSMakeRange(0, 1)];
            [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20*RATIO_WIDHT320] range:NSMakeRange(1, count)];
            [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*RATIO_WIDHT320] range:NSMakeRange(self.lbPrice.text.length - length, length)];
            [self.lbPrice setAttributedText:noteStr];
        }
        
        
        
        //产品规格  GOODS_GOODSSPECS
        /*
        商品规格数组(OTHER_GOODS_ID
               :商品 ID，GOODS_SPEC_NAME
               :规格名称)
         
         */
        NSArray *datas = [data jk_arrayForKey:@"GOODS_GOODSSPECS"];
        if (datas.count > 0) {
            [self.vRole updateData:datas withID:ID];
        }
    }
}

- (void)updateData{
    self.lbName.text = @"AP GOLD LF汽车机油";
    self.lbNoText.text = @"1M3ZC1161";
    self.lbTopPriceText.text = @"???/瓶";
    
    self.lbRole.text = @"?起订";
    self.lbStatus.text = @" | 库存充足";
    self.lbPrice.text = @"¥???.00/瓶";
    
    if(self.lbPrice.text.length > 1){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-2)];
        
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*RATIO_WIDHT320] range:NSMakeRange(0, 1)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20*RATIO_WIDHT320] range:NSMakeRange(1, self.lbPrice.text.length - 5)];
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13*RATIO_WIDHT320] range:NSMakeRange(self.lbPrice.text.length - 4, 4)];
        [self.lbPrice setAttributedText:noteStr];
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
    CGRect r = self.lbName.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 12*RATIO_WIDHT320;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbName.bottom + 12*RATIO_WIDHT320;
    r.size = size;
    self.lbNo.frame = r;
    
    size = [self.lbNoText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNoText.frame;
    r.origin.x = self.lbNo.right + 20*RATIO_WIDHT320;
    r.origin.y = self.lbNo.top;
    r.size = size;
    self.lbNoText.frame = r;
    
    size = [self.lbRole sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbRole.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbNo.bottom + 18*RATIO_WIDHT320;
    r.size = size;
    self.lbRole.frame = r;
    
    size = [self.lbStatus sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbStatus.frame;
    r.origin.x = self.lbRole.right;
    r.origin.y = self.lbRole.top;
    r.size = size;
    self.lbStatus.frame = r;
    
    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 20*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbRole.bottom + 23*RATIO_WIDHT320;
    r.size = size;
    self.lbPrice.frame = r;
    
    r = self.vCountBg.frame;
    r.size.width = 88*RATIO_WIDHT320;
    r.size.height = 22*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbPrice.top + (self.lbPrice.height - r.size.height)/2.0;
    self.vCountBg.frame = r;
    
    r = self.btnMinus.frame;
    r.size.width = 22*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = 0;
    self.btnMinus.frame = r;
    
    r = self.btnAdd.frame;
    r.size.width = 22*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.vCountBg.width - r.size.width;
    r.origin.y = 0;
    self.btnAdd.frame = r;
    
    r = self.tfCount.frame;
    r.size.width = 44*RATIO_WIDHT320;
    r.size.height = self.vCountBg.height;
    r.origin.x = self.btnMinus.right;
    r.origin.y = 0;
    self.tfCount.frame = r;
    
    r = self.vRole.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbPrice.bottom + 12*RATIO_WIDHT320;
    r.size.width = DEVICEWIDTH;
    self.vRole.frame = r;
    
    CGFloat h = 0;
    if (self.data) {
        NSArray *datas = [self.data jk_arrayForKey:@"GOODS_GOODSSPECS"];
        if (datas.count > 0) {
            h = [ViewProductRole calHeight:datas];
        }
    }
    self.vRole.height = h;
    
    r = self.lbDetail.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 40*RATIO_WIDHT320;
    r.origin.x = 10;
    r.origin.y = self.height - r.size.height;
    self.lbDetail.frame = r;
    
    
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 10*RATIO_WIDHT320;
    r.origin.x = 0;
    r.origin.y = self.lbDetail.top - r.size.height;
    self.vLine.frame = r;
}


/*

- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
    CGRect r = self.lbName.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 12*RATIO_WIDHT320;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.lbName.bottom + 12*RATIO_WIDHT320;
    r.size = size;
    self.lbNo.frame = r;
    
    size = [self.lbNoText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNoText.frame;
    r.origin.x = self.lbNo.right + 20*RATIO_WIDHT320;
    r.origin.y = self.lbNo.top;
    r.size = size;
    self.lbNoText.frame = r;
    
    CGFloat y = self.lbNo.bottom;
    
    if (self.data) {
        NSArray *datas = [self.data jk_arrayForKey:@"GOODS_GOODSSPECS"];
        if (datas.count > 0) {
            y += 12*RATIO_WIDHT320;
        }
    }
    
    r = self.vRole.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = y;
    r.size.width = DEVICEWIDTH;
    self.vRole.frame = r;
    
    CGFloat h = 0;
    if (self.data) {
        NSArray *datas = [self.data jk_arrayForKey:@"GOODS_GOODSSPECS"];
        if (datas.count > 0) {
            h = [ViewProductRole calHeight:datas];
        }
    }
    self.vRole.height = h;
    if (self.data) {
        NSArray *datas = [self.data jk_arrayForKey:@"GOODS_GOODSSPECS"];
        if (datas.count > 0) {
            y += h;
        }
    }
    
    size = [self.lbTopPrice sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbTopPrice.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = y;
    r.size = size;
    self.lbTopPrice.frame = r;
    
    size = [self.lbTopPriceText sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbTopPriceText.frame;
    r.origin.x = self.lbTopPrice.right + 20*RATIO_WIDHT320;
    r.origin.y = self.lbTopPrice.top;
    r.size = size;
    self.lbTopPriceText.frame = r;
    
    
    
    NSString *str = [self.data jk_stringForKey:@"GOODS_MARKET_PRICE"];
    if (!str || [str isEqualToString:@"0"] || [str isEqualToString:@"?"] || [str isEqualToString:@""]) {
        
    }else{
        y += 12*RATIO_WIDHT320 + r.size.height;
    }
    
    size = [self.lbRole sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbRole.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = y + 18*RATIO_WIDHT320;
    r.size = size;
    self.lbRole.frame = r;
    
    size = [self.lbStatus sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbStatus.frame;
    r.origin.x = self.lbRole.right;
    r.origin.y = self.lbRole.top;
    r.size = size;
    self.lbStatus.frame = r;
    
    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 20*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbRole.bottom + 23*RATIO_WIDHT320;
    r.size = size;
    self.lbPrice.frame = r;
    
    r = self.vCountBg.frame;
    r.size.width = 88*RATIO_WIDHT320;
    r.size.height = 22*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.lbPrice.top + (self.lbPrice.height - r.size.height)/2.0;
    self.vCountBg.frame = r;
    
    r = self.btnMinus.frame;
    r.size.width = 22*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = 0;
    self.btnMinus.frame = r;
    
    r = self.btnAdd.frame;
    r.size.width = 22*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.vCountBg.width - r.size.width;
    r.origin.y = 0;
    self.btnAdd.frame = r;
    
    r = self.tfCount.frame;
    r.size.width = 44*RATIO_WIDHT320;
    r.size.height = self.vCountBg.height;
    r.origin.x = self.btnMinus.right;
    r.origin.y = 0;
    self.tfCount.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 10*RATIO_WIDHT320;
    r.origin.x = 0;
    r.origin.y = self.lbPrice.bottom + 17*RATIO_WIDHT320;
    self.vLine.frame = r;
    
    r = self.lbDetail.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 40*RATIO_WIDHT320;
    r.origin.x = 10;
    r.origin.y = self.vLine.bottom;
    self.lbDetail.frame = r;
}
*/

- (void)clickActionWithIndex:(NSInteger)index{
    
    if ([self.delegate respondsToSelector:@selector(clickRole:)]) {
        [self.delegate clickRole:index];
    }
        
}

+ (CGFloat)calHeight:(NSDictionary*)data{
    CGFloat height = 12*RATIO_WIDHT320;
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
    lb.numberOfLines = 0;
    lb.text = [data jk_stringForKey:@"GOODS_NAME"];
    height += [lb sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)].height;
    height += 12*RATIO_WIDHT320;
    
    lb.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"商品编号";
    
    CGFloat h = [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)].height;
    height += h;
    
    NSArray *datas = [data jk_arrayForKey:@"GOODS_GOODSSPECS"];
    if (datas.count > 0) {
        height += 12*RATIO_WIDHT320 + [ViewProductRole calHeight:datas];
    }
    
    NSString *str = [data jk_stringForKey:@"GOODS_MARKET_PRICE"];
    if (!str || [str isEqualToString:@"0"] || [str isEqualToString:@"?"] || [str isEqualToString:@""]) {
        
    }else{
        height += 12*RATIO_WIDHT320 + h;
    }
    //库存
    lb.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
    lb.text = @"库存";
    CGFloat h2 = [lb sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)].height;
    height += h2 + 18*RATIO_WIDHT320;
    
    //价格
    lb.font = [UIFont systemFontOfSize:20*RATIO_WIDHT320];
    lb.text = @"价格";
    CGFloat h3 = [lb sizeThatFits:CGSizeMake(MAXFLOAT, 20*RATIO_WIDHT320)].height;
    height += h3 + 23*RATIO_WIDHT320 + 17*RATIO_WIDHT320;
    
    
    height += 50*RATIO_WIDHT320;//商品详情
    
    return height;
}


/*
+ (CGFloat)calHeight:(NSDictionary*)data{
    CGFloat height = 12*RATIO_WIDHT320;
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
    lb.numberOfLines = 0;
    lb.text = [data jk_stringForKey:@"GOODS_NAME"];
    height += [lb sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)].height;
    height += 12*RATIO_WIDHT320;
    
    lb.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"商品编号";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)].height;
    height += 12*RATIO_WIDHT320;
    
    NSString *str = [data jk_stringForKey:@"GOODS_MARKET_PRICE"];
    if (!str || [str isEqualToString:@"0"] || [str isEqualToString:@"?"] || [str isEqualToString:@""]) {
        
    }else{
        height += height;
    }
    
    
    height += 18*RATIO_WIDHT320;
    lb.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"起订";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)].height;
    
    height += 23*RATIO_WIDHT320;
    
    lb.font = [UIFont systemFontOfSize:20*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"???";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 20*RATIO_WIDHT320)].height;
    height += 17*RATIO_WIDHT320;
    
    height += 50*RATIO_WIDHT320;
    
    NSArray *datas = [data jk_arrayForKey:@"GOODS_GOODSSPECS"];
    if (datas.count > 0) {
        
        height += [ViewProductRole calHeight:datas];
    }
    
    return height;
}



*/
+ (CGFloat)calHeight{
    CGFloat height = 12*RATIO_WIDHT320;
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
    lb.numberOfLines = 0;
    lb.text = @"AP GOLD LF汽车机油";
    lb.lineBreakMode = NSLineBreakByCharWrapping;
    height += [lb sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)].height;
    height += 12*RATIO_WIDHT320;
    
    lb.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"商品编号";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)].height*2;
    
    height += 10*RATIO_WIDHT320;
    
    height += 18*RATIO_WIDHT320;
    lb.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"起订";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)].height;
    
    height += 23*RATIO_WIDHT320;
    
    lb.font = [UIFont systemFontOfSize:20*RATIO_WIDHT320];
    lb.numberOfLines = 1;
    lb.text = @"???";
    height += [lb sizeThatFits:CGSizeMake(MAXFLOAT, 20*RATIO_WIDHT320)].height;
    height += 17*RATIO_WIDHT320;
    
    
    return height + 50*RATIO_WIDHT320 + 12 + [ViewProductRole calHeight];
}

@end
