//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanModifyUserInfo.h"

@implementation RequestBeanModifyUserInfo


- (NSString*)apiPath{
    return net_updateUserInfo;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
}



@end

@implementation ResponseBeanModifyUserInfo

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end






