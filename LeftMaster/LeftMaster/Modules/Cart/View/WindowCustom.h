//
//  WindowCustom.h
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custom.h"

@protocol WindowCustomDelegate;
static UIWindow *customWindow = nil;
@interface WindowCustom : UIWindow
@property(nonatomic,strong)NSArray *dataSource;
@property(nonatomic,weak)id<WindowCustomDelegate> delegate;
- (id)init:(NSArray*)dataSource;
- (void)show;
- (void)dismiss;
@end

@protocol WindowCustomDelegate<NSObject>
- (void)selectCustom:(Custom*)cust;
@end
