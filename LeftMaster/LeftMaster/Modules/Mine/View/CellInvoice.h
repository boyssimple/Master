//
//  CellInvoice.h
//  LeftMaster
//
//  Created by simple on 2018/4/12.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellInvoice : UITableViewCell
@property(nonatomic,assign)NSInteger status;
- (void)updateData:(NSDictionary*)data;

+ (CGFloat)calHeight:(NSInteger)status;
@end
