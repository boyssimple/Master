//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellAttrGoods.h"

@interface CellAttrGoods()
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UIView *vLineTWo;
@end
@implementation CellAttrGoods

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbName.textColor = RGB3(153);
        _lbName.numberOfLines = 2;
        [self.contentView addSubview:_lbName];
        
        _vLine = [[UILabel alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self.contentView addSubview:_vLine];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbText.textColor = RGB3(153);
        _lbText.numberOfLines = 2;
        _lbText.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentView addSubview:_lbText];
        
        
        _vLineTWo = [[UILabel alloc]initWithFrame:CGRectZero];
        _vLineTWo.backgroundColor = RGB3(230);
        [self.contentView addSubview:_vLineTWo];
    }
    return self;
}

- (void)updateData:(NSDictionary*)data{
    self.lbName.text = [data jk_stringForKey:@"goodsParamName"];
    self.lbText.text = [data jk_stringForKey:@"goodsParamValue"];
}

- (void)updateData{
    self.lbName.text = @"上市时间";
    self.lbText.text = @"2017年";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat w = DEVICEWIDTH - 20*RATIO_WIDHT320;
    CGRect r = self.lbName.frame;
    r.size.width = 100*RATIO_WIDHT320 - 30*RATIO_WIDHT320;
    r.size.height = self.height - 1;;
    r.origin.x = 15*RATIO_WIDHT320;
    r.origin.y = 0;
    self.lbName.frame = r;
    
    r = self.vLine.frame;
    r.size.width = 1;
    r.size.height = self.height - 1;
    r.origin.x = self.lbName.right + 15*RATIO_WIDHT320;
    r.origin.y = 0;
    self.vLine.frame = r;
    
    r = self.lbText.frame;
    r.size.width = w - self.vLine.right - 20*RATIO_WIDHT320;
    r.size.height = self.height - 1;
    r.origin.x = self.vLine.right + 10*RATIO_WIDHT320;
    r.origin.y = 0;
    self.lbText.frame = r;
    
    r = self.vLineTWo.frame;
    r.size.width = w;
    r.size.height = 1;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLineTWo.frame = r;
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320 + 1;
}

@end

