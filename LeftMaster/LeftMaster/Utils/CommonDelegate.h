//
//  CommonDelegate.h
//  LeftMaster
//
//  Created by simple on 2018/4/15.
//  Copyright © 2018年 simple. All rights reserved.
//


@protocol CommonDelegate<NSObject>
@optional
- (void)clickActionWithIndex:(NSInteger)index;
- (void)clickActionWithIndex:(NSInteger)index withDataIndex:(NSInteger)dataIndex;
@end
