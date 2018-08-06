//
//  CartGoods.m
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "Custom.h"

@implementation Custom


- (void)parse:(NSDictionary*)data{
    self.fd_bill_org_id = [data jk_stringForKey:@"fd_bill_org_id"];
    self.fd_bill_org_name = [data jk_stringForKey:@"fd_bill_org_name"];
    self.fd_customer_id = [data jk_stringForKey:@"fd_customer_id"];
    self.fd_default = [data jk_boolForKey:@"fd_default"];
    self.fd_name = [data jk_stringForKey:@"fd_name"];
    self.selected = self.fd_default;
}

@end
