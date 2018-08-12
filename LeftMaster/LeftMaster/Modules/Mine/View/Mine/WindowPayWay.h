//
//  WindowPayWay.h
//  LeftMaster
//
//  Created by simple on 2018/8/12.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

static UIWindow *selectPayWayWindow = nil;
@interface WindowPayWay : UIWindow
@property(nonatomic,strong)void(^clickBlock)(NSInteger index);
- (id)init;
- (void)show;
- (void)dismiss;
@end
