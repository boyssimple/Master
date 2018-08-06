//
//  WindowGuide.h
//  LeftMaster
//
//  Created by simple on 2018/4/19.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

static UIWindow *guideWindow = nil;
@interface WindowGuide : UIWindow
@property(nonatomic,weak)id<CommonDelegate> delegate;
- (id)init;
- (void)show;
- (void)dismiss;


@end
