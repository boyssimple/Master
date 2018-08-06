//
//  CustConfirmView.h
//  TestKeyboard
//
//  Created by simple on 2018/5/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustConfirmViewDelegate;
@interface CustConfirmView : UIView
@property(nonatomic,weak)id<CustConfirmViewDelegate> delegate;
+ (CGFloat)calHeight;
@end

@protocol CustConfirmViewDelegate <NSObject>
- (void)custConfirmSelect;
@end
