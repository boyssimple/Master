//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanNewGoods.h"

@implementation RequestBeanNewGoods

- (NSString*)apiPath{
    return net_goods_new_list;
}

- (BOOL)isShowHub{
    return FALSE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanNewGoods

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end


