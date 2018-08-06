//
//  RequestBeanAddBatchCart.h
//  LeftMaster
//
//  Created by simple on 2018/5/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanAddBatchCart : AJRequestBeanBase

@property(nonatomic,strong)NSString *user_id;     //用户ID
@property(nonatomic,strong)NSString *cus_id;     //用户ID
@property(nonatomic,strong)NSString *detail;   
@end

@interface ResponseBeanAddBatchCart : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end

