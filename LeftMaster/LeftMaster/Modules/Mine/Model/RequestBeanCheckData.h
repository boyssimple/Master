//
//  RequestBeanCheckData.h
//  LeftMaster
//
//  Created by simple on 2018/4/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanCheckData : AJRequestBeanBase
@property(nonatomic,strong)NSString *cus_id;     //cust ID
@property(nonatomic,assign)NSInteger year;
@end

@interface ResponseBeanCheckData : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
