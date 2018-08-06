//
//  ViewBtnGoods.h
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewBtnGoods : UIView
@property(nonatomic,weak)id<CommonDelegate> delegate;
@property (nonatomic, assign) NSInteger count;
- (void)startAnimation;
@end
