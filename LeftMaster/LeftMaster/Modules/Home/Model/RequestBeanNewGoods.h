//
//  RequestBeanNewGoods.h
//  LeftMaster
//
//  Created by simple on 2018/5/8.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanNewGoods : AJRequestBeanBase

@property(nonatomic,strong)NSString *price_order;
@property(nonatomic,strong)NSString *search_name;
@property(nonatomic,strong)NSString *cus_id;
@property(nonatomic,strong)NSString *company_id;
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end

@interface ResponseBeanNewGoods : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
