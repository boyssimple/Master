//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanModifyPwd.h"

@implementation RequestBeanModifyPwd


- (NSString*)apiPath{
    return net_user_update_password;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"发送中...";
}

@end

@implementation ResponseBeanModifyPwd

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end







