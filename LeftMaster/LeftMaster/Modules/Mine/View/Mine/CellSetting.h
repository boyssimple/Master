//
//  CellSetting.h
//  LeftMaster
//
//  Created by simple on 2018/4/22.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellSetting : UITableViewCell
@property(nonatomic,assign)NSInteger type;          //type:1表示有>  2表示没有
- (void)updateData:(NSString*)name with:(NSString*)text;
@end
