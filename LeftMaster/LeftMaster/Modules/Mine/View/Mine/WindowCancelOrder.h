//
//  WindowCancelOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/24.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WindowCancelOrderDelegate;
static UIWindow *cancelOrderWindow = nil;
@interface WindowCancelOrder : UIWindow
@property(nonatomic,weak)id<WindowCancelOrderDelegate> delegate;
- (id)init;
- (void)show;
- (void)dismiss;
@end

@protocol WindowCancelOrderDelegate<NSObject>
- (void)selectReason:(NSString*)reason;
@end
