//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellProxy.h"

@interface CellProxy()
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIView *vLine;
@end
@implementation CellProxy

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        [self.contentView addSubview:_lbName];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self addSubview:_vLine];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    
}

- (void)updateData:(NSDictionary*)data{
    self.lbName.text = [data jk_stringForKey:@"customer_name"];
}

- (void)updateData{
    self.lbName.text = @"客户 001";
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if(_isSelected){
        self.contentView.backgroundColor = RGB3(230);
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.lbName.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size.width = DEVICEWIDTH - 60*RATIO_WIDHT320;
    r.size.height = self.height - 0.5;
    self.lbName.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH - 20*RATIO_WIDHT320;
    r.size.height = 0.5;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 34*RATIO_WIDHT320 + 0.5;
}

@end


