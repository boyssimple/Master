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
    return net_getUserInfo;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
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






