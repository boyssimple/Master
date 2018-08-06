//
//  CellCart.h
//  LeftMaster
//
//  Created by simple on 2018/4/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartGoods.h"


@protocol CellCartDelegate;
@interface CellCart : UITableViewCell
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, weak) id<CommonDelegate> delegate;
@property (nonatomic, weak) id<CellCartDelegate> cellDelegate;
- (void)updateData:(CartGoods*)data;
@end


@protocol CellCartDelegate <NSObject>

- (void)inputCount:(NSInteger)count withDataIndex:(NSInteger)index;

@end
