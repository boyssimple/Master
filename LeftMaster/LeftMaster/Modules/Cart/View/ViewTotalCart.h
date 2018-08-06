//
//  ViewTotalCart.h
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewTotalCartDelegate;
@interface ViewTotalCart : UIView

@property(nonatomic,weak)id<ViewTotalCartDelegate> delegate;
- (void)updateData:(NSInteger)num withPrice:(CGFloat)total;
@end


@protocol ViewTotalCartDelegate<NSObject>

- (void)clickOrder;
- (void)clickCheck:(BOOL)selected;

@end
