//
//  CellGoods.h
//  LeftMaster
//
//  Created by simple on 2018/4/22.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellGoods : UITableViewCell
@property(nonatomic,strong)NSArray *dataSouce;
+ (CGFloat)calHeight:(NSArray*)arrays;
@end
