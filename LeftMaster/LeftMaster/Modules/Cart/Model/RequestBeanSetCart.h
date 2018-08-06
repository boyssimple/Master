//
//  RequestBeanSetCart.h
//  LeftMaster
//
//  Created by simple on 2018/5/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanSetCart : AJRequestBeanBase

@property(nonatomic,strong)NSString *car_id;     //订单ID
@property(nonatomic,assign)NSInteger num;     //数量
@end

@interface ResponseBeanSetCart : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
