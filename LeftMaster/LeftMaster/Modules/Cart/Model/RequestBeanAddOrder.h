//
//  RequestBeanAddOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanAddOrder : AJRequestBeanBase
@property(nonatomic,strong)NSString *oderInfo; //订单信息
@end

@interface ResponseBeanAddOrder : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
