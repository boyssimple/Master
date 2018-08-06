//
//  RequestBeanBillOrg.h
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanBillOrg : AJRequestBeanBase

@property(nonatomic,strong)NSString *cus_id;     //客户ID
@end

@interface ResponseBeanBillOrg : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
