//
//  CellAccountList.h
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CellAccountListDelegate;
@interface CellAccountList : UITableViewCell
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,weak)id<CellAccountListDelegate> delegate;
@property(nonatomic,assign)NSInteger type;//1表示不显示按钮
- (void)updateData:(NSDictionary*)data;
@end

@protocol CellAccountListDelegate<NSObject>

- (void)confirmBill:(NSInteger)index;

@end
