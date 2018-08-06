//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellCategory.h"

@interface CellCategory()
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UIView *vLine;

@end
@implementation CellCategory

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Shopping-Cart_icon_normal
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbName.textColor = RGB(0, 0, 0);
        _lbName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_lbName];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self.contentView addSubview:_vLine];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (_isSelected) {
        self.lbName.textColor = APP_COLOR;
    }else{
        self.lbName.textColor = RGB3(0);
    }
}

- (void)clickAction:(UIButton*)sender{
    
}

- (void)updateData:(NSDictionary*)data{
    if(data){
        self.lbName.text = [data jk_stringForKey:@"GOODSTYPE_NAME"];
    }
}

- (void)updateData{
    self.lbName.text = @"固特异";
}

- (void)layoutSubviews{
    [super layoutSubviews];CGRect r = self.lbName.frame;
    r.origin.x = 0;
    r.origin.y = 0;
    r.size.width = self.width;
    r.size.height = self.height - 0.5;
    self.lbName.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 43*RATIO_WIDHT320;
}

@end

