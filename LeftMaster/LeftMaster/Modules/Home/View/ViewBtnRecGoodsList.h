//
//  ViewBtnRecGoodsList.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewBtnRecGoodsList : UIView
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)BOOL isAsc;  //是否升序
+ (CGFloat)calWidth;
- (void)updateData:(NSString*)text;
@end
