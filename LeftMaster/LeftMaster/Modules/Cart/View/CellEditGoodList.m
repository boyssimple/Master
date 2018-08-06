//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellEditGoodList.h"

@interface CellEditGoodList()
@property(nonatomic,strong)UIButton *btnCheck;
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UIButton *btnDelete;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UIView  *vCountBg;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIButton *btnMinus;
@property(nonatomic,strong)UIButton *btnAdd;
@property(nonatomic,strong)UILabel *lbCount;

@end
@implementation CellEditGoodList

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Shopping-Cart_icon_normal
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_ivImg];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.numberOfLines = 3;
        [self.contentView addSubview:_lbName];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbNo.textColor = RGB3(153);
        [self.contentView addSubview:_lbNo];
        
        _btnDelete = [[UIButton alloc]initWithFrame:CGRectZero];
        [_btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        [_btnDelete setTitleColor:APP_COLOR forState:UIControlStateNormal];
        _btnDelete.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnDelete addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnDelete];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbPrice.textColor = RGB(0, 0, 0);
        [self.contentView addSubview:_lbPrice];
        
        _vCountBg = [[UIView alloc]initWithFrame:CGRectZero];
        _vCountBg.layer.borderColor = RGB3(197).CGColor;
        _vCountBg.layer.borderWidth = 0.5f;
        _vCountBg.layer.cornerRadius = 3.f;
        _vCountBg.layer.masksToBounds = YES;
        _vCountBg.clipsToBounds = YES;
        [self.contentView addSubview:_vCountBg];
        
        _btnMinus = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnMinus.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnMinus setTitle:@"-" forState:UIControlStateNormal];
        [_btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
        _btnMinus.tag = 100;
        [_btnMinus addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_vCountBg addSubview:_btnMinus];
        
        _btnAdd = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnAdd.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnAdd setTitle:@"+" forState:UIControlStateNormal];
        [_btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnAdd.tag = 101;
        [_btnAdd addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_vCountBg addSubview:_btnAdd];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbCount.textColor = RGB(0, 0, 0);
        _lbCount.textAlignment = NSTextAlignmentCenter;
        _lbCount.text = @"1";
        [_vCountBg addSubview:_lbCount];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(245);
        [self.contentView addSubview:_vLine];
    }
    return self;
}


- (void)deleteAction:(UIButton*)sender{
    if([self.delegate respondsToSelector:@selector(clickActionWithIndex: withDataIndex:)]){
        [self.delegate clickActionWithIndex:2 withDataIndex:self.index];
    }
}

- (void)clickAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if(tag == 100){
        NSString *str = self.lbCount.text;
        if ([str integerValue] > 1) {
            NSInteger c = [str integerValue];
            if(c > 1){
                self.lbCount.text = [NSString stringWithFormat:@"%zi",c-1];
                
                if([self.delegate respondsToSelector:@selector(clickActionWithIndex: withDataIndex:)]){
                    [self.delegate clickActionWithIndex:0 withDataIndex:self.index];
                }
            }
            
            if(c-1 == 1){
                [self.btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
            }
        }
    }else if(tag == 101){
        NSString *str = self.lbCount.text;
        NSInteger c = [str integerValue]+1;
        self.lbCount.text = [NSString stringWithFormat:@"%zi",c];
        if (c > 1) {
            [self.btnMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if([self.delegate respondsToSelector:@selector(clickActionWithIndex: withDataIndex:)]){
            [self.delegate clickActionWithIndex:1 withDataIndex:self.index];
        }
    }
}

- (void)updateData:(CartGoods*)data{
    if(data){
        self.btnCheck.selected = data.selected;
        [self.ivImg pt_setImage:data.GOODS_PIC];
        self.lbName.text = data.GOODS_NAME;
        self.lbNo.text = [NSString stringWithFormat:@"商品编码:%@",data.GOODS_CODE];
        
        self.lbCount.text = [NSString stringWithFormat:@"%zi",data.FD_NUM];
        
        [self handle:data.FD_NUM];
        
        self.lbPrice.text = [NSString stringWithFormat:@"¥%.2f/%@",data.GOODS_PRICE,data.GOODS_UNIT];
        
        if(self.lbPrice.text.length > 2){
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
            // 改变颜色
            [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-data.GOODS_UNIT.length)];
            [self.lbPrice setAttributedText:noteStr];
        }
    }
}

- (void)handle:(NSInteger)num{
    if (num > 0) {
        [self.btnMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}

- (void)updateData{
    [self.ivImg pt_setImage:@"http://pic1.win4000.com/wallpaper/2017-12-19/5a387cb8439ea.jpg"];
    self.lbName.text = @"275 50 20轮胎 275 50 20轮胎";
    self.lbPrice.text = @"¥???/个";
    
    if(self.lbPrice.text.length > 2){
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-2)];
        [self.lbPrice setAttributedText:noteStr];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivImg.frame;
    r.size.width = 80*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    self.ivImg.frame = r;
    
    CGSize size = [self.btnDelete.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    size.height = size.height + 10;
    size.width = size.width + 15*RATIO_WIDHT320*2;
    r = self.btnDelete.frame;
    r.origin.x = DEVICEWIDTH - size.width;
    r.origin.y = self.ivImg.top;
    r.size = size;
    self.btnDelete.frame = r;
    
    size = [self.lbName sizeThatFits:CGSizeMake(self.btnDelete.left -self.ivImg.right - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbName.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.ivImg.top - 3.5;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(self.lbName.width, MAXFLOAT)];
    r = self.lbNo.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbName.bottom + 3*RATIO_WIDHT320;
    r.size = size;
    self.lbNo.frame = r;
    
    size = [self.lbPrice sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbPrice.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = self.ivImg.bottom - size.height;
    r.size = size;
    self.lbPrice.frame = r;
    
    r = self.vCountBg.frame;
    r.size.width = 80*RATIO_WIDHT320;
    r.size.height = 20*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.ivImg.bottom - r.size.height;
    self.vCountBg.frame = r;
    
    r = self.btnMinus.frame;
    r.size.width = 20*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = 0;
    self.btnMinus.frame = r;
    
    r = self.btnAdd.frame;
    r.size.width = 20*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.vCountBg.width - r.size.width;
    r.origin.y = 0;
    self.btnAdd.frame = r;
    
    r = self.lbCount.frame;
    r.size.width = 40*RATIO_WIDHT320;
    r.size.height = self.vCountBg.height;
    r.origin.x = self.btnMinus.right;
    r.origin.y = 0;
    self.lbCount.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.ivImg.bottom + 10*RATIO_WIDHT320;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 105*RATIO_WIDHT320 + 0.5;
}

@end
