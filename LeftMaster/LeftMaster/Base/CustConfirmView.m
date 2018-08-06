//
//  CustConfirmView.m
//  TestKeyboard
//
//  Created by simple on 2018/5/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CustConfirmView.h"

@interface CustConfirmView()
@property(nonatomic,strong)UIButton *btnCancel;
@property(nonatomic,strong)UIButton *btnConfirm;
@end

@implementation CustConfirmView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        
        _btnCancel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, self.frame.size.height)];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_btnCancel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnCancel.tag = 100;
        [_btnCancel addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnCancel];
        
        
        _btnCancel = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 60, 0, 60, self.frame.size.height)];
        [_btnCancel setTitle:@"完成" forState:UIControlStateNormal];
        [_btnCancel setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        _btnCancel.titleLabel.font = [UIFont systemFontOfSize:14];
        _btnCancel.tag = 101;
        [_btnCancel addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btnCancel];
    }
    return self;
}

- (void)clickAction:(UIButton*)sender{
    [[UIApplication sharedApplication].keyWindow endEditing:TRUE];
    if (sender.tag == 100) {
    }else{
        if ([self.delegate respondsToSelector:@selector(custConfirmSelect)]) {
            [self.delegate custConfirmSelect];
        }
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

+ (CGFloat)calHeight{
    return 50;
}

@end
