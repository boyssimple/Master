//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellRecGoodsList.h"

@interface CellRecGoodsList()
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UIImageView *ivNew;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UIButton *btnAddCart;
@property(nonatomic,strong)UILabel *lbRole;
@property(nonatomic,strong)UILabel *lbStatus;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UIView  *vCountBg;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIButton *btnMinus;
@property(nonatomic,strong)UIButton *btnAdd;
@property(nonatomic,strong)UITextField *tfCount;

@end
@implementation CellRecGoodsList

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Shopping-Cart_icon_normal
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_ivImg];
        
        _ivNew = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivNew.image = [UIImage imageNamed:@"news"];
        _ivNew.userInteractionEnabled = YES;
        [_ivImg addSubview:_ivNew];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.numberOfLines = 3;
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
        
        _btnAddCart = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnAddCart.titleLabel.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        [_btnAddCart setTitle:@"加入购物车" forState:UIControlStateNormal];
        [_btnAddCart setTitleColor:RGB3(255) forState:UIControlStateNormal];
        _btnAddCart.tag = 102;
        _btnAddCart.backgroundColor = APP_COLOR;
        [_btnAddCart addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnAddCart];
        
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
    
}

- (void)clickAction:(UIButton*)sender{
    NSInteger tag = sender.tag;
    if (tag == 101) {
        sender.selected = !sender.selected;
    }else if(tag == 102){
        [self.vc.view endEditing:TRUE];
        NSString *str = self.tfCount.text;
        NSInteger count = 0;
        if (str) {
            count = [str integerValue];
        }
        if (count > 0) {
            if ([self.joinCartDelegate respondsToSelector:@selector(joinCartClick: withNum:)]) {
                [self.joinCartDelegate joinCartClick:self.index withNum:[self.tfCount.text integerValue]];
            }
        }else{
            self.tfCount.text = @"1";
            [Utils showSuccessToast:@"数量最少1" with:self.vc.view withTime:1];
        }
    }else if(tag == 103){
        [self.vc.view endEditing:TRUE];
        NSString *str = self.tfCount.text;
        if ([str integerValue] > 1) {
            NSInteger c = [str integerValue];
            if(c > 1){
                self.tfCount.text = [NSString stringWithFormat:@"%zi",c-1];
            }
            
            if(c-1 == 1){
                [self.btnMinus setTitleColor:RGB3(197) forState:UIControlStateNormal];
            }
        }
    }else if(tag == 104){
        [self.vc.view endEditing:TRUE];
        NSString *str = self.tfCount.text;
        NSInteger c = [str integerValue]+1;
        self.tfCount.text = [NSString stringWithFormat:@"%zi",c];
        if (c > 1) {
            [self.btnMinus setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

- (void)updateData:(NSDictionary*)data{
    if(data){
        [self.ivImg pt_setImage:[data jk_stringForKey:@"GOODS_PIC"]];
        self.lbName.text = [data jk_stringForKey:@"GOODS_NAME"];
        self.lbNo.text = [NSString stringWithFormat:@"商品编码:%@",[data jk_stringForKey:@"GOODS_CODE"]];
        self.lbRole.text = [NSString stringWithFormat:@"库存:%ld",[data jk_integerForKey:@"GOODS_STOCK"]];
        
        if([data jk_integerForKey:@"GOODS_STOCK"] > 0){
            self.lbStatus.text = @" | 库存充足";
        }else{
            self.lbStatus.text = @" | 库存不足";
        }
        
        if ([data jk_floatForKey:@"GOODS_PRICE"] == 0) {
            self.lbPrice.text = [NSString stringWithFormat:@"¥?/%@",[data jk_stringForKey:@"GOODS_UNIT"]];
        }else{
            self.lbPrice.text = [NSString stringWithFormat:@"¥%.2f/%@",[data jk_floatForKey:@"GOODS_PRICE"],[data jk_stringForKey:@"GOODS_UNIT"]];
            
        }
        NSInteger length = [data jk_stringForKey:@"GOODS_UNIT"].length + 1;
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.lbPrice.text];
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:APP_COLOR range:NSMakeRange(0, self.lbPrice.text.length-length)];
        [self.lbPrice setAttributedText:noteStr];
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
    CGRect r = self.ivImg.frame;
    r.size.width = 100*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    self.ivImg.frame = r;
    
    
    r = self.ivNew.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = 32*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.ivNew.frame = r;
    
    r = self.btnAddCart.frame;
    r.size.width = 61*RATIO_WIDHT320;
    r.size.height = 14*RATIO_WIDHT320;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = self.ivImg.top + 2*RATIO_WIDHT320;
    self.btnAddCart.frame = r;
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(self.btnAddCart.left -self.ivImg.right - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbName.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.ivImg.top;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(self.btnAddCart.left -self.ivImg.right - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbNo.frame;
    r.size = size;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbName.bottom + 3*RATIO_WIDHT320;
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

