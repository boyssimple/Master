//
//  CellInvoiceDetail.h
//  LeftMaster
//
//  Created by simple on 2018/5/21.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellInvoiceDetail : UITableViewCell
@property(nonatomic,assign)NSInteger status;
- (void)updateData:(NSDictionary*)data;
+ (CGFloat)calHeightWithData:(NSDictionary*)data;

+ (CGFloat)calHeight:(NSInteger)status;
@end
