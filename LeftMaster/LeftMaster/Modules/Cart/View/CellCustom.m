//
//  CellCart.m
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellCustom.h"

@interface CellCustom()
@property(nonatomic,strong)UIButton *btnCheck;
@property(nonatomic,strong)UILabel *lbName;

@end
@implementation CellCustom

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //Shopping-Cart_icon_normal
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        _btnCheck = [[UIButton alloc]initWithFrame:CGRectZero];
        _btnCheck.tag = 101;
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_normal"] forState:UIControlStateNormal];
        [_btnCheck setImage:[UIImage imageNamed:@"Shopping-Cart_icon_selected"] forState:UIControlStateSelected];
        [_btnCheck addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_btnCheck];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbName.textColor = [UIColor grayColor];
        _lbName.numberOfLines = 2;
        [self.contentView addSubview:_lbName];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:self.index];
    }
}

- (void)updateData:(Custom*)data{
    self.lbName.text = data.fd_bill_org_name;
    self.btnCheck.selected = data.selected;
}

- (void)updateData{
    self.lbName.text = @"不想买了";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.btnCheck.frame;
    r.size.width = 35*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 0;
    r.origin.y = (self.height - r.size.height)/2.0;
    self.btnCheck.frame = r;
    
    r = self.btnCheck.imageView.frame;
    r.size.width = 15*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.btnCheck.imageView.frame = r;
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(DEVICEWIDTH - 10*RATIO_WIDHT320 - self.btnCheck.right, MAXFLOAT)];
    r = self.lbName.frame;
    r.origin.x = self.btnCheck.right;
    r.origin.y = (self.height - size.height)/2.0;
    r.size = size;
    self.lbName.frame = r;
}

+ (CGFloat)calHeight{
    return 30*RATIO_WIDHT320;
}

@end
