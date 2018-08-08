//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellNoticeList.h"

@interface CellNoticeList()
@property(nonatomic,strong)UIView *vDot;
@property(nonatomic,strong)UILabel *lbTime;
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)UIImageView *ivArrow;
@property(nonatomic,strong)UIView *vLine;
@end
@implementation CellNoticeList

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _vDot = [[UIView alloc]initWithFrame:CGRectZero];
        _vDot.backgroundColor = APP_COLOR;
        _vDot.layer.cornerRadius = 3.5*RATIO_WIDHT320*0.5;
        _vDot.layer.masksToBounds = YES;
        [self.contentView addSubview:_vDot];
        
        _lbTime = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTime.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbTime.textColor = RGB3(51);
        [self.contentView addSubview:_lbTime];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
        _lbText.textColor = RGB3(0);
        [self.contentView addSubview:_lbText];
        
        _ivArrow = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivArrow.userInteractionEnabled = YES;
        _ivArrow.image = [UIImage imageNamed:@"home_news_more"];
        [self.contentView addSubview:_ivArrow];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self.contentView addSubview:_vLine];
    }
    return self;
}

- (void)updateData{
    self.lbTime.text = @"2018-01-18 17:55";
    self.lbText.text = @"中国第一家渠道渠道";
}

- (void)updateData:(NSDictionary*)data{
    self.lbTime.text = [data jk_stringForKey:@"FD_CREATE_TIME"];
    self.lbText.text = [data jk_stringForKey:@"FD_NAME"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.vDot.frame;
    r.size.width = 3.5*RATIO_WIDHT320;
    r.size.height = r.size.width ;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    self.vDot.frame = r;
    
    CGSize size = [self.lbTime sizeThatFits:CGSizeMake(MAXFLOAT , 12*RATIO_WIDHT320)];
    r = self.lbTime.frame;
    r.size = size;
    r.origin.x = self.vDot.right + 5*RATIO_WIDHT320;
    r.origin.y = 15*RATIO_WIDHT320;
    self.lbTime.frame = r;
    self.vDot.top = self.lbTime.top + (self.lbTime.height - self.vDot.height)/2.0;
    
    CGFloat w = DEVICEWIDTH - 30*RATIO_WIDHT320;
    size = [self.lbText sizeThatFits:CGSizeMake(w - self.lbTime.left, 14*RATIO_WIDHT320)];
    r = self.lbText.frame;
    r.size.height = size.height;
    r.size.width = w;
    r.origin.x = self.lbTime.left;
    r.origin.y = self.lbTime.bottom + 15*RATIO_WIDHT320;
    self.lbText.frame = r;
    
    r = self.ivArrow.frame;
    r.size.width = 10*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    self.ivArrow.frame = r;
    
    
    r = self.vLine.frame;
    r.size.width = 300*RATIO_WIDHT320;
    r.size.height = 0.5;
    r.origin.x = DEVICEWIDTH - r.size.width;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 77*RATIO_WIDHT320 + 0.5;
}

@end




