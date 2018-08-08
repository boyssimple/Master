//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellNotice.h"

@interface CellNotice()
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,strong)UIImageView *ivArrow;
@property(nonatomic,strong)UIView *vLine;
@end
@implementation CellNotice

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.userInteractionEnabled = YES;
        _ivImg.image = [UIImage imageNamed:@"icon_1"];
        [self.contentView addSubview:_ivImg];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB3(51);
        [self.contentView addSubview:_lbTitle];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbText.textColor = RGB3(102);
//        [self.contentView addSubview:_lbText];
        
        _lbCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbCount.font = [UIFont boldSystemFontOfSize:8*RATIO_WIDHT320];
        _lbCount.textColor = RGB3(255);
        _lbCount.backgroundColor = APP_COLOR;
        _lbCount.textAlignment = NSTextAlignmentCenter;
        _lbCount.layer.cornerRadius = 5*RATIO_WIDHT320;
        _lbCount.layer.masksToBounds = YES;
        [self.contentView addSubview:_lbCount];
        
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

- (void)updateData:(NSString*)icon withTitle:(NSString*)title withCount:(NSInteger)count{
    self.ivImg.image = [UIImage imageNamed:icon];
    self.lbTitle.text = title;
    if(count <= 0){
        self.lbCount.hidden = YES;
    }else{
        self.lbCount.hidden = NO;
        if(count > 10){
            self.lbCount.text = @"10+";
        }else{
            self.lbCount.text = [NSString stringWithFormat:@"%zi",count];
        }
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivImg.frame;
    r.size.width = 40*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.ivImg.frame = r;
    
    CGFloat w = DEVICEWIDTH - 46*RATIO_WIDHT320;
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(w - (self.ivImg.right + 7*RATIO_WIDHT320), MAXFLOAT)];
    r = self.lbTitle.frame;
    r.size.height = size.height;
    r.size.width = w - (self.ivImg.right + 7*RATIO_WIDHT320);
    r.origin.x = self.ivImg.right + 7*RATIO_WIDHT320;
    r.origin.y = self.ivImg.top + (self.ivImg.height - r.size.height)/2.0;
    self.lbTitle.frame = r;
    
    
    size = [self.lbText sizeThatFits:CGSizeMake(self.lbTitle.width, MAXFLOAT)];
    r = self.lbText.frame;
    r.size.height = size.height;
    r.size.width = self.lbTitle.width;
    r.origin.x = self.lbTitle.left;
    r.origin.y = self.lbTitle.bottom + 10*RATIO_WIDHT320;
    self.lbText.frame = r;
    
    r = self.ivArrow.frame;
    r.size.width = 10*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    self.ivArrow.frame = r;
    
    r = self.lbCount.frame;
    r.size.height = 10*RATIO_WIDHT320;
    r.size.width = 20*RATIO_WIDHT320;
    r.origin.x = self.ivArrow.left - r.size.width - 3*RATIO_WIDHT320;
    r.origin.y = (self.height - size.height)/2.0;
    self.lbCount.frame = r;
    
    r = self.vLine.frame;
    r.size.width = 275*RATIO_WIDHT320;
    r.size.height = 0.5;
    r.origin.x = DEVICEWIDTH - r.size.width;
    r.origin.y = self.height - r.size.height;
    self.vLine.frame = r;
}

+ (CGFloat)calHeight{
    return 72*RATIO_WIDHT320 + 0.5;
}

@end



