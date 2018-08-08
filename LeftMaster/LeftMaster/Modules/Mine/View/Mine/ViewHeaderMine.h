//
//  ViewHeaderMine.h
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewHeaderMine : UIView
@property(nonatomic,weak)id<CommonDelegate> delegate;
- (void)setImage:(UIImage *)img;
- (void)updateData:(NSInteger)index withCount:(NSInteger)count;
@end
