//
//  CellCancelOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/24.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reason.h"

@interface CellCancelOrder : UITableViewCell
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,weak)id<CommonDelegate> delegate;

- (void)updateData:(Reason*)data;
@end
