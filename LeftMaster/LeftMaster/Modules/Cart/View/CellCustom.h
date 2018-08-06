//
//  CellCustom.h
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custom.h"

@interface CellCustom : UITableViewCell
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,weak)id<CommonDelegate> delegate;

- (void)updateData:(Custom*)data;
@end
