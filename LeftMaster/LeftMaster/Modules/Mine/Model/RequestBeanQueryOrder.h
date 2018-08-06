//
//  RequestBeanQueryOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/22.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanQueryOrder : AJRequestBeanBase
@property(nonatomic,strong)NSString *user_id;     //用户ID
@property(nonatomic,strong)NSString *cus_id;     //客户ID
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@property(nonatomic,strong)NSString *order_status;//否(为空时 : 所有,待确认:0,待审核:1,待发货:2,待收货:3)

@property(nonatomic,strong)NSString *search_key;
@end

@interface ResponseBeanQueryOrder : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
