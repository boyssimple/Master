//
//  CellOrderList.h
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellOrderList : UITableViewCell
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<CommonDelegate> delegate;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,assign)NSInteger status;
- (void)updateData:(NSDictionary*)data;
@end
