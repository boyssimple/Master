//
//  CellUserInfo.h
//  LeftMaster
//
//  Created by simple on 2018/8/13.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellUserInfo : UITableViewCell
- (void)updateData:(NSString*)name with:(NSString*)text hiddenArrow:(BOOL)show withType:(NSInteger)type;
+ (CGFloat)calHeightTWo;
@end
