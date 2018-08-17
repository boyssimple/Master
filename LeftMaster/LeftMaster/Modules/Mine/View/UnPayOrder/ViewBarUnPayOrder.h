//
//  ViewBarUnPayOrder.h
//  LeftMaster
//
//  Created by simple on 2018/8/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewBarUnPayOrder : UIView

@property(nonatomic,strong)void(^clickBlock)(NSInteger index,BOOL selected);

- (void)updateDataPrice:(CGFloat)total;
- (void)updateCal:(NSInteger)num;
@end
