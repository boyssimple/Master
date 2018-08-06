//
//  CartGoods.h
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartGoods:NSObject
@property(nonatomic,strong)NSString *FD_ID;
@property(nonatomic,assign)NSInteger FD_NUM;
@property(nonatomic,strong)NSString *GOODSTYPE_ID;
@property(nonatomic,strong)NSString *GOODS_CODE;
@property(nonatomic,strong)NSString *GOODS_ID;
@property(nonatomic,strong)NSString *GOODS_NAME;
@property(nonatomic,strong)NSString *GOODS_PIC;
@property(nonatomic,assign)CGFloat GOODS_PRICE;
@property(nonatomic,assign)NSInteger GOODS_STOCK;
@property(nonatomic,strong)NSString *GOODS_UNIT;
@property(nonatomic,assign)BOOL selected;

- (void)parse:(NSDictionary*)data;
@end
