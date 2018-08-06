//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellCart.h"

@interface CellCart()
@property(nonatomic,strong)UIButton *btnCheck;
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UIButton *btnDel;
@property(nonatomic,strong)UILabel *lbRole;
@property(nonatomic,strong)UILabel *lbStatus;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UIView  *vCountBg;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIButton *btnMinus;
@property(nonatomic,strong)UIButton *btnAdd;
@property(nonatomic,strong)UITextField *tfCount;

@end
@implementation CellCart

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Shopping-Cart_icon_normal
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _btnCheck = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnCheck.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _btnCheck.tag = 100;
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_normal"] forState:UIControlStateNormal];
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_selected"] forState:UIControlStateSelected];
        [_btnCheck addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnCheck];
        
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_ivImg];

        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.numberOfLines = 3;
        [self.contentView addSubview:_lbName];
        [self.contentView addSubview:_lbName];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbNo.textColor = RGB3(153);
        [self.contentView addSubview:_lbNo];
        
        _lbRole = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbRole.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbRole.textColor = RGB(255, 0, 0);
        [self.contentView addSubview:_lbRole];
        
        _lbStatus = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbStatus.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbStatus.textColor = RGB3(153);
        [self.contentView addSubview:_lbStatus];
        
        _lbPrice = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbPrice.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbPrice.textColor = RGB(0, 0, 0);
        [self.contentView addSubview:_lbPrice];
        
        _btnDel = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnDel.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnDel setTitle:@"删除" forState:UIControlStateNormal];
        [_btnDel setTitleColor:APP_COLOR forState:UIControlStateNormal];
        _btnDel.tag = 101;
        [_btnDel addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnDel];
    
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
        _btnMinus.tag = 102;
        [_btnMinus addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_vCountBg addSubview:_btnMinus];
        
        _btnAdd = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnAdd.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnAdd setTitle:@"+" forState:UIControlStateNormal];
        [_btnAdd setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _btnAdd.tag = 103;
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
        _vLine.backgroundColor = RGB3(245);
        [self.contentView addSubview:_vLine];
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
    if([self.cellDelegate respondsToSelector:@selector(inputCount:withDataIndex:)]){
        [self.cellDelegate inputCount:count withDataIndex:self.index];
    }
    
}

- (void)clickAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 100) {
        sender.selected = !sender.selected;
        if([self.delegate respondsToSelector:@selector(clickActionWithIndex: withDataIndex:)]){
            [self.delegate clickActionWithIndex:tag-100 withDataIndex:self.index];
        }
    }else if(tag == 101){
        if([self.delegate respondsToSelector:@selector(clickActionWithIndex: withDataIndex:)]){
            [self.delegate clickActionWithIndex:tag-100 withDataIndex:self.index];
        }
    }else if(tag == 102){
        NSString *str = self.tfCount.text;
        if ([str integerValue] > 1) {
            NSInteger c = [str integerValue];
            if(c > 1){
                self.tfCount.text = [NSString stringWithFormat:@"%zi",c-1];
                
                if([self.delegate respondsToSelector:@selector(clickActionWithIndex: withDataIndex:)]){
                    [self.delegate clickActionWithIndex:tag-100 withDataIndex:self.index];
                }
            }
            
            if(c-1 == 1){
                [self.btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
            }
        }
    }else if(tag == 103){
        NSString *str = self.tfCount.text;
        NSInteger c = [str integerValue]+1;
        self.tfCount.text = [NSString stringWithFormat:@"%zi",c];
        if (c > 1) {
            [self.btnMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        if([self.delegate respondsToSelector:@selector(clickActionWithIndex: withDataIndex:)]){
            [self.delegate clickActionWithIndex:tag-100 withDataIndex:self.index];
        }
    }
}

- (void)updateData:(CartGoods*)data{
    if(data){
        self.btnCheck.selected = data.selected;
        [self.ivImg pt_setImage:data.GOODS_PIC];
        self.lbName.text = data.GOODS_NAME;
        self.lbNo.text = [NSString stringWithFormat:@"商品编码:%@",data.GOODS_CODE];
        self.lbRole.text = [NSString stringWithFormat:@"库存:%ld",data.GOODS_STOCK];
        
        if(data.GOODS_STOCK > 0){
            self.lbStatus.text = @" | 库存充足";
        }else{
            self.lbStatus.text = @" | 库存不足";
        }
        
        self.tfCount.text = [NSString stringWithFormat:@"%zi",data.FD_NUM];
        
        if (data.GOODS_PRICE == 0) {
            self.lbPrice.text = [NSString stringWithFormat:@"¥?/%@",data.GOODS_UNIT];
        }else{
            self.lbPrice.text = [NSString stringWithFormat:@"¥%.2f/%@",data.GOODS_PRICE,data.GOODS_UNIT];
            
        }
        if(self.lbPrice.text.length > 2){
            NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
            // 改变颜色
            [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-data.GOODS_UNIT.length)];
            [self.lbPrice setAttributedText:noteStr];
        }
    }
}

- (void)updateData{
    [self.ivImg pt_setImage:@"http://pic1.win4000.com/wallpaper/2017-12-19/5a387cb8439ea.jpg"];
    self.lbName.text = @"275 50 20轮胎 275 50 20轮胎";
    self.lbRole.text = @"1台起订";
    self.lbStatus.text = @" | 库存充足";
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
    CGRect r = self.btnCheck.frame;
    r.size.width = 35*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.btnCheck.frame = r;
    
    r = self.btnCheck.imageView.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnCheck.imageView.frame = r;
    
    r = self.ivImg.frame;
    r.size.width = 100*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.btnCheck.right;
    r.origin.y = 15*RATIO_WIDHT320;
    self.ivImg.frame = r;
    
    CGSize size = [self.btnDel.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    size.height = size.height + 10;
    size.width = size.width + 15*RATIO_WIDHT320*2;
    r = self.btnDel.frame;
    r.origin.x = DEVICEWIDTH - size.width;
    r.origin.y = self.ivImg.top;
    r.size = size;
    self.btnDel.frame = r;
    
    size = [self.lbName sizeThatFits:CGSizeMake(self.btnDel.left -self.ivImg.right - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbName.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.ivImg.top - 3.5;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(self.btnDel.left -self.ivImg.right - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbNo.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbName.bottom + 3*RATIO_WIDHT320;
    r.size = size;
    self.lbNo.frame = r;
    
    size = [self.lbRole sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbRole.frame;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbNo.bottom + 9*RATIO_WIDHT320;
    r.size = size;
    self.lbRole.frame = r;
    
    size = [self.lbStatus sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbStatus.frame;
    r.origin.x = self.lbRole.right;
    r.origin.y = self.lbNo.bottom + 9*RATIO_WIDHT320;
    r.size = size;
    self.lbStatus.frame = r;
    
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
    
    r = self.tfCount.frame;
    r.size.width = 40*RATIO_WIDHT320;
    r.size.height = self.vCountBg.height;
    r.origin.x = self.btnMinus.right;
    r.origin.y = 0;
    self.tfCount.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.ivImg.bottom + 10*RATIO_WIDHT320;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 125*RATIO_WIDHT320 + 0.5;
}

@end
