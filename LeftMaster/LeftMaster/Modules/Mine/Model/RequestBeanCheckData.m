//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanCheckData.h"

@implementation RequestBeanCheckData

- (NSString*)apiPath{
    return net_order_check_data;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanCheckData

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end






