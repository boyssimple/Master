//
//  ViewTabAccount.h
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewTabAccountDelegate;
@interface ViewTabAccount : UIView
@property(nonatomic,strong)NSArray *dataSource;
@property (nonatomic, weak) id<ViewTabAccountDelegate> delegate;
@property (nonatomic, assign) NSInteger curIndex;
@end

@protocol ViewTabAccountDelegate<NSObject>
- (void)clickTab:(NSInteger)index;
@end
