//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellUserInfo.h"

@interface CellUserInfo()
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIImageView *ivArrow;

@property(nonatomic,strong)UIImageView *ivAvatar;
@property(nonatomic,strong)UILabel *lbText;
@property(nonatomic,strong)UIView *vLine;

@property(nonatomic,assign)BOOL show;
@property(nonatomic,assign)NSInteger type;
@end
@implementation CellUserInfo

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Shopping-Cart_icon_normal
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont boldSystemFontOfSize:12*RATIO_WIDHT320];
        _lbTitle.textColor = RGB3(51);
        [self.contentView addSubview:_lbTitle];
        
        _lbText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbText.font = [UIFont boldSystemFontOfSize:10*RATIO_WIDHT320];
        _lbText.textColor = [UIColor blackColor];
        _lbText.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lbText];
        
        _ivArrow = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivArrow.userInteractionEnabled = YES;
        _ivArrow.image = [UIImage imageNamed:@"home_news_more"];
        [self.contentView addSubview:_ivArrow];
        
        _ivAvatar = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivAvatar.userInteractionEnabled = YES;
        _ivAvatar.layer.cornerRadius = 25*RATIO_WIDHT320;
        _ivAvatar.image = [UIImage imageNamed:@"User_Default"];
        [self.contentView addSubview:_ivAvatar];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self.contentView addSubview:_vLine];
    }
    return self;
}

- (void)updateData:(NSString*)name with:(NSString*)text hiddenArrow:(BOOL)show withType:(NSInteger)type{
    self.lbTitle.text = name;
    self.lbText.text = text;
    self.ivArrow.hidden = show;
    self.type = type;
    self.show = show;
    if(self.type == 1){
        self.ivAvatar.hidden = FALSE;
    }else{
        self.ivAvatar.hidden = TRUE;
    }
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
    
    r = self.lbTitle.frame;
    r.size.width = self.ivArrow.left - 20*RATIO_WIDHT320 - self.lbTitle.right;
    r.size.height = self.height;
    r.origin.x = self.ivArrow.left - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = 0;
    self.lbText.frame = r;
    
    if(self.show){
        self.lbText.x = DEVICEWIDTH - 10*RATIO_WIDHT320 - self.lbText.width;
    }
    
    r = self.ivAvatar.frame;
    r.size.width = 50*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = self.ivArrow.left - r.size.width - 10*RATIO_WIDHT320;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.ivAvatar.frame = r;
    
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

+ (CGFloat)calHeightTWo{
    return 70*RATIO_WIDHT320;
}
@end


