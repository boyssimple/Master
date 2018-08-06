//
//  ViewTotalBottomWriteOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/7.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewTotalBottomWriteOrderDelegate;
@interface ViewTotalBottomWriteOrder : UIView
- (void)updateData:(CGFloat)price;

@property(nonatomic,weak)id<ViewTotalBottomWriteOrderDelegate> delegate;
@end

@protocol ViewTotalBottomWriteOrderDelegate<NSObject>

- (void)clickOrder;

@end
