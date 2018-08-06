//
//  ViewOrderRecGoodsList.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewOrderRecGoodsListDelegate;
@interface ViewOrderRecGoodsList : UIView
@property(nonatomic,weak)id<ViewOrderRecGoodsListDelegate> delegate;
@end

@protocol ViewOrderRecGoodsListDelegate<NSObject>
- (void)clickOrder:(NSInteger)index withState:(BOOL)state;
@end
