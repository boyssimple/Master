//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanRegisterAccount.h"

@implementation RequestBeanRegisterAccount


- (NSString*)apiPath{
    return net_shop_enterprise_platform_register;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"注册中...";
}



@end

@implementation ResponseBeanRegisterAccount

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end






