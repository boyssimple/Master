//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanBillPayDetail.h"

@implementation RequestBeanBillPayDetail


- (NSString*)apiPath{
    return net_account_list_pay_detail;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanBillPayDetail

- (BOOL)checkSuccess{
    if (self.success) { 
        return TRUE;
    }
    return FALSE;
}

@end






