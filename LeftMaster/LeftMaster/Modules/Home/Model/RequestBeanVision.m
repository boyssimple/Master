//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanVision.h"

@implementation RequestBeanVision

- (NSString*)apiPath{
    return net_app_version;
}

- (BOOL)isShowHub{
    return FALSE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

@end

@implementation ResponseBeanVision

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end


