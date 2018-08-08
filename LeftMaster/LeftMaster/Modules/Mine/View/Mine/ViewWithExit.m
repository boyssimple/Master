//
//  ViewWithExit.m
//  LeftMaster
//
//  Created by simple on 2018/4/20.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewWithExit.h"
@interface ViewWithExit()
@property (nonatomic, strong) UIButton *btnExit;
@end

@implementation ViewWithExit

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _btnExit = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, DEVICEWIDTH, 45*RATIO_WIDHT320)];
        [_btnExit setTitle:@"退出" forState:UIControlStateNormal];
        [_btnExit setTitleColor:RGB3(51) forState:UIControlStateNormal];
        _btnExit.titleLabel.font = [UIFont boldSystemFontOfSize:14*RATIO_WIDHT320];
        [_btnExit addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnExit.backgroundColor = [UIColor whiteColor];
        [self addSubview:_btnExit];
    }
    
    return self;
}

- (void)clickAction:(UIButton*)sender{
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:1];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

+ (CGFloat)calHeight{
    return 45*RATIO_WIDHT320 + 20;
}

@end
