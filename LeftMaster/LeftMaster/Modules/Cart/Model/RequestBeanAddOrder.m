//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanAddOrder.h"

@implementation RequestBeanAddOrder

- (NSString*)apiPath{
    return net_save_order;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"处理中...";
}
//
//- (HTTP_METHOD)httpMethod
//{
//    return HTTP_METHOD_POST;
//}

@end

@implementation ResponseBeanAddOrder

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end





