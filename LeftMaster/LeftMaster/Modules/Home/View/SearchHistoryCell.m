//
//  SearchHistoryCell.m
//  UMa
//
//  Created by yanyu on 2018/5/22.
//  Copyright © 2018年 yanyu. All rights reserved.
//

#import "SearchHistoryCell.h"

@interface SearchHistoryCell ()

@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)UIButton *btndelete;
@property(nonatomic,assign)NSInteger indexrow;

@end

@implementation SearchHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = APP_Gray_COLOR;
        [self addSubview:_vLine];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.textColor = RGB3(133);
        _lbText.font = [UIFont systemFontOfSize:15*RATIO_WIDHT750];
        [self.contentView addSubview:_lbText];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.vLine.frame; 
    r.size.width = DEVICEWIDTH - 10*RATIO_WIDHT750;
    r.size.height = 1;
    r.origin.x = 10*RATIO_WIDHT750;
    r.origin.y = 0;
    self.vLine.frame = r;
    
    CGSize size = [self.lbText sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT750, 12*RATIO_WIDHT320)];
    r = self.lbText.frame;
    r.size = size;
    r.origin.x = 10*RATIO_WIDHT750;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.lbText.frame = r;
}

- (void)updateData:(NSString*)text{
    self.lbText.text = text;
}

+ (CGFloat)calHeight{
    return 40*RATIO_WIDHT320;
}

@end
