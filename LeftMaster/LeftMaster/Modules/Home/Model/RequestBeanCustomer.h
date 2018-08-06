//
//  RequestBeanCustomer.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanCustomer : AJRequestBeanBase

@property(nonatomic,strong)NSString *user_login_name;
@property(nonatomic,strong)NSString *customer_name;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end

@interface ResponseBeanCustomer : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
