//
//  CartGoods.m
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AlwaysBuyGoods.h"

@implementation AlwaysBuyGoods


- (void)parse:(NSDictionary*)data{
    self.GOODSTYPE_ID = [data jk_stringForKey:@"GOODSTYPE_ID"];
    self.GOODS_CODE = [data jk_stringForKey:@"GOODS_CODE"];
    self.GOODS_ID = [data jk_stringForKey:@"GOODS_ID"];
    self.GOODS_MARKET_PRICE = [data jk_stringForKey:@"GOODS_MARKET_PRICE"];
    self.GOODS_NAME = [data jk_stringForKey:@"GOODS_NAME"];
    self.GOODS_PIC = [data jk_stringForKey:@"GOODS_PIC"];
    self.GOODS_PRICE = [data jk_floatForKey:@"GOODS_PRICE"];
    self.old_GOODS_PRICE = [data jk_stringForKey:@"GOODS_PRICE"];
    self.GOODS_STOCK = [data jk_integerForKey:@"GOODS_STOCK"];
    self.GOODS_UNIT = [data jk_stringForKey:@"GOODS_UNIT"];
    self.OPER_TYPE = [data jk_integerForKey:@"OPER_TYPE"];
    self.Num = 1;
}

@end
