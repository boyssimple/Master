//
//  CellOrderInfo.h
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellOrderInfo : UITableViewCell
- (void)updateData:(NSDictionary*)data;
+ (CGFloat)calHeight:(NSDictionary*)data;
@end
