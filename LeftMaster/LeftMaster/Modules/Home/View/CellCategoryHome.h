//
//  CellCategoryHome.h
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellCategoryHome : UITableViewCell
@property(nonatomic,strong)NSArray *dataSource;
+ (CGFloat)calHeight:(NSInteger)num;
@end
