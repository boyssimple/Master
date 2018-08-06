//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanAddCart.h"

@implementation RequestBeanAddCart
- (NSString*)apiPath{
    return net_user_cart_add;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"处理中...";
}

- (NSString*)cus_id{
    return [AppUser share].CUS_ID;
}


@end

@implementation ResponseBeanAddCart

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end





