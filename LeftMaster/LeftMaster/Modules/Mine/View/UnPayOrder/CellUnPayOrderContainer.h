//
//  CellUnPayOrderContainer.h
//  LeftMaster
//
//  Created by simple on 2018/8/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellUnPayOrderContainer : UITableViewCell
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)void(^clickBlock)(NSInteger index);
@end
