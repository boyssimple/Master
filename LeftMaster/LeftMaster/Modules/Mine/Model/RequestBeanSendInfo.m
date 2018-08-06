//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanSendInfo.h"

@implementation RequestBeanSendInfo

- (NSInteger)page_current{
    return 1;
}

- (NSInteger)page_size{
    return 1000;
}

- (NSString*)apiPath{
    return net_order_send_info;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanSendInfo

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end






