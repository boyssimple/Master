//
//  RequestBeanOrderInfo.h
//  LeftMaster
//
//  Created by simple on 2018/4/25.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanOrderInfo : AJRequestBeanBase
@property(nonatomic,strong)NSString *FD_ORDER_ID;     //定单ID
@end

@interface ResponseBeanOrderInfo : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
