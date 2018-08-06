//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanQueryCartNum.h"

@implementation RequestBeanQueryCartNum

-(NSInteger)page_size{
    return 10;
}

- (NSString*)apiPath{
    return net_cart_num;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (NSString *)hubTips{
    return @"加载中...";
}

- (NSString*)cus_id{
    return [AppUser share].CUS_ID;
}
@end

@implementation ResponseBeanQueryCartNum

- (BOOL)checkSuccess{
    if (self.success) {
        return TRUE;
    }
    return FALSE;
}

@end





