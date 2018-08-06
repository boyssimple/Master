//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanCartList.h"

@implementation RequestBeanCartList

-(NSInteger)page_size{
    return 10;
}

- (NSString*)apiPath{
    return net_user_cart_list;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanCartList

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end







