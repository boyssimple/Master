//
//  CellProxy.h
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellProxy : UITableViewCell
@property(nonatomic,assign)BOOL isSelected;
- (void)updateData:(NSDictionary*)data;
@end
