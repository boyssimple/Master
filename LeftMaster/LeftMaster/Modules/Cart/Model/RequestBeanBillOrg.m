//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanBillOrg.h"

@implementation RequestBeanBillOrg

- (NSString*)apiPath{
    return net_order_customer_bill_org;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"处理中...";
}

@end

@implementation ResponseBeanBillOrg

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end





