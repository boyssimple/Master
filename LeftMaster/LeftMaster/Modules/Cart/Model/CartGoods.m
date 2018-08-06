//
//  CartGoods.m
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CartGoods.h"

@implementation CartGoods


- (void)parse:(NSDictionary*)data{
    self.FD_ID = [data jk_stringForKey:@"FD_ID"];
    self.FD_NUM = [data jk_integerForKey:@"FD_NUM"];
    self.GOODSTYPE_ID = [data jk_stringForKey:@"GOODSTYPE_ID"];
    self.GOODS_CODE = [data jk_stringForKey:@"GOODS_CODE"];
    self.GOODS_ID = [data jk_stringForKey:@"GOODS_ID"];
    self.GOODS_NAME = [data jk_stringForKey:@"GOODS_NAME"];
    self.GOODS_PIC = [data jk_stringForKey:@"GOODS_PIC"];
    self.GOODS_PRICE = [data jk_floatForKey:@"GOODS_PRICE"];
    self.GOODS_STOCK = [data jk_integerForKey:@"GOODS_STOCK"];
    self.GOODS_UNIT = [data jk_stringForKey:@"GOODS_UNIT"];
}

@end
