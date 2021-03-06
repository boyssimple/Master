//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellSetting.h"

@interface CellSetting()
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIImageView *ivArrow;
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)UIView *vLine;
@end
@implementation CellSetting

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbTitle.textColor = RGB3(51);
        [self.contentView addSubview:_lbTitle];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont boldSystemFontOfSize:10*RATIO_WIDHT320];
        _lbText.textColor = RGB3(153);
        [self.contentView addSubview:_lbText];
        
        _ivArrow = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivArrow.userInteractionEnabled = YES;
        _ivArrow.image = [UIImage imageNamed:@"home_news_more"];
        [self.contentView addSubview:_ivArrow];
        
    }
    return self;
}

- (void)updateData:(NSString*)name with:(NSString*)text{
    if (self.type == 2) {
        self.ivArrow.hidden = TRUE;
    }else{
        self.ivArrow.hidden = FALSE;
    }
    self.lbTitle.text = name;
    self.lbText.text = text;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
    CGRect r = self.lbTitle.frame;
    r.size = size;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    self.lbTitle.frame = r;
    
    r = self.ivArrow.frame;
    r.size.width = 10*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.ivArrow.frame = r;
    
    size = [self.lbText sizeThatFits:CGSizeMake(MAXFLOAT, 10*RATIO_WIDHT320)];
    r = self.lbTitle.frame;
    r.size.width = size.width;
    r.size.height = self.height;
    r.origin.x = self.ivArrow.left - size.width - 8*RATIO_WIDHT320;
    r.origin.y = 0;
    self.lbText.frame = r;
    
    if(self.type == 2){
        self.lbText.left = DEVICEWIDTH - self.lbText.width - 10*RATIO_WIDHT320;
    }
}

+ (CGFloat)calHeight{
    return 43*RATIO_WIDHT320;
}

@end


