//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanNotice.h"

@implementation RequestBeanNotice

-(NSInteger)page_size{
    return 10;
}

- (NSString*)apiPath{
    return net_user_msg;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanNotice

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end






