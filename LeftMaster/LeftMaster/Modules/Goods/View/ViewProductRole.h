//
//  ViewProductRole.h
//  LeftMaster
//
//  Created by simple on 2018/5/20.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewProductRole : UIView
@property(nonatomic,weak)id<CommonDelegate> delegate;
- (void)updateData:(NSArray*)dataSource withID:(NSString*)ID;
+ (CGFloat)calHeight:(NSArray*)dataSource;
@end
