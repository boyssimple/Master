//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellOrderRemark.h"

@interface CellOrderRemark()
@property(nonatomic,strong)UILabel *lbText;
@end
@implementation CellOrderRemark

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = RGB3(252);
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbText.textColor = RGB3(51);
        [self.contentView addSubview:_lbText];
    }
    return self;
}

- (void)updateData:(NSString*)text{
    self.lbText.text = text;
}

- (void)updateData{
    self.lbText.text = @"记得发顺丰，谢谢!";
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGSize size = [self.lbText sizeThatFits:CGSizeMake(DEVICEWIDTH - 73*RATIO_WIDHT320, MAXFLOAT)];
    CGRect r = self.lbText.frame;
    r.origin.x = 36*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    r.size = size;
    self.lbText.frame = r;
}

+ (CGFloat)calHeight:(NSString*)text{
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    lb.text = text;
    CGSize size = [lb sizeThatFits:CGSizeMake(DEVICEWIDTH - 73*RATIO_WIDHT320,MAXFLOAT)];
    CGFloat height = size.height;
    if (text && text.length > 0) {
        height += 30*RATIO_WIDHT320;
    }
    return height;
}

@end






