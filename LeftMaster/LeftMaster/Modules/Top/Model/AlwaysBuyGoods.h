//
//  AlwaysBuyGoods.h
//  LeftMaster
//
//  Created by simple on 2018/4/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlwaysBuyGoods : NSObject

@property(nonatomic,strong)NSString *GOODSTYPE_ID;
@property(nonatomic,strong)NSString *GOODS_CODE;
@property(nonatomic,strong)NSString *GOODS_ID;
@property(nonatomic,strong)NSString *GOODS_MARKET_PRICE;
@property(nonatomic,strong)NSString *GOODS_NAME;
@property(nonatomic,strong)NSString *GOODS_PIC;
@property(nonatomic,assign)CGFloat GOODS_PRICE;
@property(nonatomic,strong)NSString *old_GOODS_PRICE;
@property(nonatomic,assign)NSInteger GOODS_STOCK;
@property(nonatomic,strong)NSString *GOODS_UNIT;
@property(nonatomic,assign)NSInteger OPER_TYPE;
@property(nonatomic,assign)NSInteger Num;
@property(nonatomic,assign)BOOL selected;

- (void)parse:(NSDictionary*)data;
@end
