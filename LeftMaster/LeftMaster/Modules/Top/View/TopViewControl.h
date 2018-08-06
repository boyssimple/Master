//
//  TopViewControl.h
//  LeftMaster
//
//  Created by simple on 2018/5/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopViewControlDelegate;
@interface TopViewControl : UIView

@property(nonatomic,weak)id<TopViewControlDelegate> delegate;
- (void)updateData:(NSInteger)num withPrice:(CGFloat)total;
@end


@protocol TopViewControlDelegate<NSObject>

- (void)clickOrder;
- (void)clickCheck:(BOOL)selected;

@end
