//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanAddBatchCart.h"

@implementation RequestBeanAddBatchCart
- (NSString*)apiPath{
    return net_user_cart_batch_add;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"处理中...";
}

@end

@implementation ResponseBeanAddBatchCart

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end





