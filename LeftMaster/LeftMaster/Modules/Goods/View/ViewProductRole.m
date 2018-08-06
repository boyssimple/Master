//
//  ViewProductRole.m
//  LeftMaster
//
//  Created by simple on 2018/5/20.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "ViewProductRole.h"

@implementation ViewProductRole


- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)updateData:(NSArray*)dataSource withID:(NSString*)ID{
//    NSArray *dataSource = @[@"三轮CG125风冷机",@"hello",@"琴儿",@"李军",@"不知道为什么是",@"APP"];
    NSInteger count = [dataSource count];
    CGFloat w = DEVICEWIDTH - 20*RATIO_WIDHT320;
    CGFloat margin = 10*RATIO_WIDHT320;
    CGFloat h = 30*RATIO_WIDHT320;
    
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *lb = [[UIButton alloc]initWithFrame:CGRectZero];
        lb.titleLabel.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        [lb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [lb setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        lb.backgroundColor = RGB3(241);
        NSDictionary *data = [dataSource objectAtIndex:i];
        [lb setTitle:[data jk_stringForKey:@"GOODS_SPEC_NAME"] forState:UIControlStateNormal];
        [lb addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        lb.layer.cornerRadius = h*0.5;
        lb.layer.masksToBounds = TRUE;
        lb.tag = 100+i;
        CGSize size = [lb.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
        CGFloat width = size.width + 20*RATIO_WIDHT320;
        if (width < 50*RATIO_WIDHT320) {
            width = 50*RATIO_WIDHT320;
        }
        if (width > (w - x)) {
            y += h + margin;
            x = 0;
        }
        
        CGRect r = lb.frame;
        r.origin.x = x;
        r.origin.y = y;
        r.size.width = width;
        r.size.height = h;
        lb.frame = r;
        
        x += width + margin;
        
        [self addSubview:lb];
        if (ID && [[data jk_stringForKey:@"OTHER_GOODS_ID"] isEqualToString:ID]) {
            lb.backgroundColor = APP_COLOR;
            lb.selected = TRUE;
        }
    }
}

- (void)clickAction:(UIButton*)sender{
    NSArray *subs = [self subviews];
    for (UIView *v in subs) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton*)v;
            btn.selected = FALSE;
            btn.backgroundColor = RGB3(241);
        }
    }
    sender.selected = TRUE;
    sender.backgroundColor = APP_COLOR;
    
    if ([self.delegate respondsToSelector:@selector(clickActionWithIndex:)]) {
        [self.delegate clickActionWithIndex:sender.tag-100];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}

+ (CGFloat)calHeight:(NSArray*)dataSource{
//    NSArray *dataSource = @[@"三轮CG125风冷机",@"hello",@"琴儿",@"李军",@"不知道为什么是",@"APP"];
    NSInteger count = [dataSource count];
    
    CGFloat height = 0;
    CGFloat w = DEVICEWIDTH - 20*RATIO_WIDHT320;
    CGFloat margin = 10*RATIO_WIDHT320;
    CGFloat h = 30*RATIO_WIDHT320;
    
    CGFloat x = 0;
    CGFloat y = 0;
    for (NSInteger i = 0; i < count; i++) {
        UIButton *lb = [[UIButton alloc]initWithFrame:CGRectZero];
        lb.titleLabel.font = [UIFont systemFontOfSize:12*RATIO_WIDHT320];
        NSDictionary *data = [dataSource objectAtIndex:i];
        [lb setTitle:[data jk_stringForKey:@"GOODS_SPEC_NAME"] forState:UIControlStateNormal];
        CGSize size = [lb sizeThatFits:CGSizeMake(MAXFLOAT, 12*RATIO_WIDHT320)];
        CGFloat width = size.width + 20*RATIO_WIDHT320;
        if (width < 50*RATIO_WIDHT320) {
            width = 50*RATIO_WIDHT320;
        }
        if (width > (w - x)) {
            y += h + margin;
            x = 0;
        }
        
        CGRect r = lb.frame;
        r.origin.x = x;
        r.origin.y = y;
        r.size.width = width;
        r.size.height = h;
        lb.frame = r;
        
        x += width + margin;
    }
    if (count > 0) {
        height += y + h;
    }
    return height;
}

@end
