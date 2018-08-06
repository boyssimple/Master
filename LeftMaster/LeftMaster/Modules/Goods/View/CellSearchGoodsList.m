//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellSearchGoodsList.h"

@interface CellSearchGoodsList()
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UIImageView *ivNew;
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbNo;
@property(nonatomic,strong)UILabel *lbRole;
@property(nonatomic,strong)UILabel *lbStatus;
@property(nonatomic,strong)UILabel *lbPrice;
@property(nonatomic,strong)UIView *vLine;

@end
@implementation CellSearchGoodsList

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
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
        _lbName.lineBreakMode = NSLineBreakByCharWrapping;
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
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(245);
        [self.contentView addSubview:_vLine];
    }
    return self;
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
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(DEVICEWIDTH -self.ivImg.right - 20*RATIO_WIDHT320, MAXFLOAT)];
    r = self.lbName.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.ivImg.top;
    r.size = size;
    self.lbName.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(DEVICEWIDTH -self.ivImg.right - 20*RATIO_WIDHT320, MAXFLOAT)];
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

