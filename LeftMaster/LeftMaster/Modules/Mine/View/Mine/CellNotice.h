//
//  CellNotice.h
//  LeftMaster
//
//  Created by simple on 2018/4/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellNotice : UITableViewCell
- (void)updateData:(NSString*)icon withTitle:(NSString*)title withCount:(NSInteger)count;
@end
