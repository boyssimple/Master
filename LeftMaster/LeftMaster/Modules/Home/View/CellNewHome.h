//
//  CellNewHome.h
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellNewHome : UITableViewCell
@property (nonatomic, strong) NSArray *dataSource;
+ (CGFloat)calHeight:(NSArray*)arrays;
@end
