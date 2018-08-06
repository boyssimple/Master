//
//  VCOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCBase.h"

@interface VCOrder : VCBase
@property(nonatomic,strong)NSString *orderId; //status订单状态(待确认:0,待审核:1,待发货:2,待收货:3,已完成:4,审核不通过:5,订单取消:6)
@end
