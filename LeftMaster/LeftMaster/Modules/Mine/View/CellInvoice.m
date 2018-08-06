//
//  CellInvoice.m
//  LeftMaster
//  发货单
//  Created by simple on 2018/4/12.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellInvoice.h"

@interface CellInvoice()
@property (nonatomic, strong) UIImageView *ivImg;
@property (nonatomic, strong) UILabel *lbName;
@property (nonatomic, strong) UILabel *lbNameText;
@property (nonatomic, strong) UIView *vLine;
//发货单号
@property (nonatomic, strong) UILabel *lbNo;
@property (nonatomic, strong) UILabel *lbNoText;
//订单数量
@property (nonatomic, strong) UILabel *lbCount;
@property (nonatomic, strong) UILabel *lbCountText;


//已货数量
@property (nonatomic, strong) UILabel *lbSendCount;
@property (nonatomic, strong) UILabel *lbSendCountText;


//未货数量
@property (nonatomic, strong) UILabel *lbUnSendCount;
@property (nonatomic, strong) UILabel *lbUnSendCountText;


//发货时间
@property (nonatomic, strong) UILabel *lbSendDate;
@property (nonatomic, strong) UILabel *lbSendDateText;
//发货人
@property (nonatomic, strong) UILabel *lbSender;
@property (nonatomic, strong) UILabel *lbSenderText;
//发货人电话
@property (nonatomic, strong) UILabel *lbReceivePhone;
@property (nonatomic, strong) UILabel *lbReceivePhoneText;
//预计到货时间
@property (nonatomic, strong) UILabel *lbArriveDate;
@property (nonatomic, strong) UILabel *lbArriveDateText;
@end


@implementation CellInvoice

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.image = [UIImage stretchImage:@"order_invoice"];
        _ivImg.userInteractionEnabled = YES;
        [self.contentView addSubview:_ivImg];
        
        _lbName = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbName.textColor = APP_BLACK_COLOR;
        _lbName.text = @"商品名称";
        [self.contentView addSubview:_lbName];
        
        _lbNameText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNameText.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbNameText.textColor = APP_COLOR;
        [self.contentView addSubview:_lbNameText];
        
        _vLine = [[UIView alloc]initWithFrame:CGRectZero];
        _vLine.backgroundColor = RGB3(230);
        [self.contentView addSubview:_vLine];
        
        _lbNo = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNo.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNo.textColor = APP_BLACK_COLOR;
        _lbNo.text = @"发货单号：";
        [self.contentView addSubview:_lbNo];
        
        _lbNoText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbNoText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbNoText.textColor = APP_BLACK_COLOR;
        [self.contentView addSubview:_lbNoText];
        
        _lbSendCount = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbSendCount.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbSendCount.textColor = APP_BLACK_COLOR;
        _lbSendCount.text = @"已发数量：";
        [self.contentView addSubview:_lbSendCount];
        
        _lbSendCountText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbSendCountText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbSendCountText.textColor = APP_COLOR;
        [self.contentView addSubview:_lbSendCountText];
        
        
        _lbSendDate = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbSendDate.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbSendDate.textColor = APP_BLACK_COLOR;
        _lbSendDate.text = @"发货时间：";
        [self.contentView addSubview:_lbSendDate];
        
        _lbSendDateText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbSendDateText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbSendDateText.textColor = APP_BLACK_COLOR;
        [self.contentView addSubview:_lbSendDateText];
        
        
        _lbSender = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbSender.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbSender.textColor = APP_BLACK_COLOR;
        _lbSender.text = @"收货人：";
        [self.contentView addSubview:_lbSender];
        
        _lbSenderText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbSenderText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbSenderText.textColor = APP_BLACK_COLOR;
        [self.contentView addSubview:_lbSenderText];
        
        
        _lbReceivePhone = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbReceivePhone.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbReceivePhone.textColor = APP_BLACK_COLOR;
        _lbReceivePhone.text = @"收货人电话：";
        [self.contentView addSubview:_lbReceivePhone];
        
        _lbReceivePhoneText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbReceivePhoneText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbReceivePhoneText.textColor = APP_BLACK_COLOR;
        [self.contentView addSubview:_lbReceivePhoneText];
        
        
        _lbArriveDate = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbArriveDate.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbArriveDate.textColor = APP_BLACK_COLOR;
        _lbArriveDate.text = @"预计到货时间：";
        [self.contentView addSubview:_lbArriveDate];
        
        _lbArriveDateText = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbArriveDateText.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        _lbArriveDateText.textColor = APP_BLACK_COLOR;
        [self.contentView addSubview:_lbArriveDateText];
    }
    return self;
}

- (void)updateData:(NSDictionary*)data{
    self.lbNameText.text = [data jk_stringForKey:@"GOODS_NAME"];
    self.lbNoText.text = [data jk_stringForKey:@"FD_NO"];
    self.lbSendCountText.text = [NSString stringWithFormat:@"%zi",[data jk_integerForKey:@"FD_SEND_NUM"]];
    self.lbSendDateText.text = [data jk_stringForKey:@"FD_SEND_DATE"];
    self.lbSenderText.text = [data jk_stringForKey:@"FD_REC_USER"];
    self.lbReceivePhoneText.text = [data jk_stringForKey:@"FD_REC_TEL"];
    self.lbArriveDateText.text = [data jk_stringForKey:@"FD_ARRI_TIME_EXP"];
    
}

- (void)updateData{
    self.lbNameText.text = @"275 50 20轮胎";
    self.lbNoText.text = @"DH.2018.0118.0001";
    self.lbCountText.text = @"5个";
    self.lbSendDateText.text = @"2018-01-18 17:35:45";
    self.lbSenderText.text = @"李先生";
    self.lbReceivePhoneText.text = @"15909327516";
    self.lbArriveDateText.text = @"2018-01-19";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivImg.frame;
    r.size.width = 16*RATIO_WIDHT320;
    r.size.height = r.size.width;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 10*RATIO_WIDHT320;
    self.ivImg.frame = r;
    
    CGSize size = [self.lbName sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
    r = self.lbName.frame;
    r.size = size;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.ivImg.top + (self.ivImg.height - size.height)/2.0;
    self.lbName.frame = r;
    
    r = self.lbNameText.frame;
    r.size.width = DEVICEWIDTH - self.lbName.right - 8*RATIO_WIDHT320 - 10*RATIO_WIDHT320;
    r.size.height = self.lbName.height;
    r.origin.x = self.lbName.right + 8*RATIO_WIDHT320;
    r.origin.y = self.lbName.top;
    self.lbNameText.frame = r;
    
    r = self.vLine.frame;
    r.size.width = DEVICEWIDTH;
    r.size.height = 0.5;
    r.origin.x = 0;
    r.origin.y = self.ivImg.bottom + 10*RATIO_WIDHT320;
    self.vLine.frame = r;
    
    size = [self.lbNo sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbNo.frame;
    r.size = size;
    r.origin.x = self.lbName.left;
    r.origin.y = self.vLine.bottom + 15*RATIO_WIDHT320;
    self.lbNo.frame = r;
    
    r = self.lbNoText.frame;
    r.size.width = DEVICEWIDTH - self.lbNo.right - 10*RATIO_WIDHT320;
    r.size.height = self.lbName.height;
    r.origin.x = self.lbNo.right;
    r.origin.y = self.lbNo.top;
    self.lbNoText.frame = r;
    
    size = [self.lbCount sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbCount.frame;
    r.size = size;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbNo.bottom + 10*RATIO_WIDHT320;
    self.lbCount.frame = r;
    
    r = self.lbCountText.frame;
    r.size.width = DEVICEWIDTH - self.lbCount.right - 10*RATIO_WIDHT320;
    r.size.height = self.lbCount.height;
    r.origin.x = self.lbCount.right;
    r.origin.y = self.lbCount.top;
    self.lbCountText.frame = r;
    
    
    size = [self.lbSendCount sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbSendCount.frame;
    r.size = size;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbNo.bottom + 10*RATIO_WIDHT320;
    self.lbSendCount.frame = r;
    
    r = self.lbSendCountText.frame;
    r.size.width = DEVICEWIDTH - self.lbSendCount.right - 10*RATIO_WIDHT320;
    r.size.height = self.lbSendCount.height;
    r.origin.x = self.lbSendCount.right;
    r.origin.y = self.lbSendCount.top;
    self.lbSendCountText.frame = r;
    
    size = [self.lbSendDate sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbSendDate.frame;
    r.size = size;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbSendCount.bottom + 10*RATIO_WIDHT320;
    self.lbSendDate.frame = r;
    
    r = self.lbSendDateText.frame;
    r.size.width = DEVICEWIDTH - self.lbSendDate.right - 10*RATIO_WIDHT320;
    r.size.height = self.lbSendDate.height;
    r.origin.x = self.lbSendDate.right;
    r.origin.y = self.lbSendDate.top;
    self.lbSendDateText.frame = r;
    
    
    size = [self.lbSender sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbSender.frame;
    r.size = size;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbSendDate.bottom + 10*RATIO_WIDHT320;
    self.lbSender.frame = r;
    
    r = self.lbSenderText.frame;
    r.size.width = DEVICEWIDTH - self.lbSender.right - 10*RATIO_WIDHT320;
    r.size.height = self.lbSender.height;
    r.origin.x = self.lbSender.right;
    r.origin.y = self.lbSender.top;
    self.lbSenderText.frame = r;
    
    
    size = [self.lbReceivePhone sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbReceivePhone.frame;
    r.size = size;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbSender.bottom + 10*RATIO_WIDHT320;
    self.lbReceivePhone.frame = r;
    
    r = self.lbReceivePhoneText.frame;
    r.size.width = DEVICEWIDTH - self.lbReceivePhone.right - 10*RATIO_WIDHT320;
    r.size.height = self.lbReceivePhone.height;
    r.origin.x = self.lbReceivePhone.right;
    r.origin.y = self.lbReceivePhone.top;
    self.lbReceivePhoneText.frame = r;
    
    
    size = [self.lbArriveDate sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
    r = self.lbArriveDate.frame;
    r.size = size;
    r.origin.x = self.lbName.left;
    r.origin.y = self.lbReceivePhone.bottom + 10*RATIO_WIDHT320;
    self.lbArriveDate.frame = r;
    
    r = self.lbArriveDateText.frame;
    r.size.width = DEVICEWIDTH - self.lbArriveDate.right - 10*RATIO_WIDHT320;
    r.size.height = self.lbArriveDate.height;
    r.origin.x = self.lbArriveDate.right;
    r.origin.y = self.lbArriveDate.top;
    self.lbArriveDateText.frame = r;
}

+ (CGFloat)calHeight:(NSInteger)status{
    CGFloat height = 36*RATIO_WIDHT320 + 0.5 + 30*RATIO_WIDHT320;
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectZero];
    lb.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
    lb.text = @"内容：";
    CGFloat h =[lb sizeThatFits:CGSizeMake(DEVICEWIDTH, MAXFLOAT)].height;
    height +=  h * 6 + 5*10*RATIO_WIDHT320;
    
    return height;
}

@end
