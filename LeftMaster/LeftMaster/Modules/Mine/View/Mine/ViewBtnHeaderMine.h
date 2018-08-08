//
//  ViewBtnHeaderMine.h
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewBtnHeaderMine : UIView
@property(nonatomic,assign)NSInteger count;
- (void)update:(NSInteger)count;
- (void)updateData:(NSString*)icon with:(NSString*)name;
@end
