//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanOrderNum.h"

@implementation RequestBeanOrderNum

- (NSString*)cus_id{
    return [AppUser share].CUS_ID;
}

- (NSString*)apiPath{
    return net_order_query_num;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanOrderNum

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end






