//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanSendMsg.h"

@implementation RequestBeanSendMsg

- (NSString*)apiPath{
    return net_shop_sendRegisterMsg;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"发送中...";
}

@end

@implementation ResponseBeanSendMsg

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end
