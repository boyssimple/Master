//
//  ViewTabOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewTabOrderDelegate;
@interface ViewTabOrder : UIView
@property (nonatomic, weak) id<ViewTabOrderDelegate> delegate;
@property (nonatomic, assign) NSInteger curIndex;
@end

@protocol ViewTabOrderDelegate<NSObject>
- (void)clickTab:(NSInteger)index;
@end
