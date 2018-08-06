//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanCarouseList.h"

@implementation RequestBeanCarouseList

- (NSString*)apiPath{
    return net_goods_carouse_list;
}

- (BOOL)isShowHub{
    return FALSE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanCarouseList

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end


