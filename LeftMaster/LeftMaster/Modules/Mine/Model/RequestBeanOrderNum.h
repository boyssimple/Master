//
//  RequestBeanOrderNum.h
//  LeftMaster
//
//  Created by simple on 2018/5/3.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanOrderNum : AJRequestBeanBase
@property(nonatomic,strong)NSString *user_id;     //user ID
@property(nonatomic,strong)NSString *cus_id;     //客户ID
@property(nonatomic,assign)NSInteger order_status;
@end

@interface ResponseBeanOrderNum : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,assign)NSInteger num;
@end
