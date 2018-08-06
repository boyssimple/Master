//
//  RequestBeanDelCart.h
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanDelCart : AJRequestBeanBase

@property(nonatomic,strong)NSString *car_id;     //购物车ID
@end

@interface ResponseBeanDelCart : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
