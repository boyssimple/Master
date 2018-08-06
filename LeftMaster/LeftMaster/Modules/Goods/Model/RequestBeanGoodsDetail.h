//
//  RequestBeanGoodsDetail.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanGoodsDetail : AJRequestBeanBase

@property(nonatomic,strong)NSString *goods_id;     //商品ID
@property(nonatomic,strong)NSString *cus_id;     //客户ID
@end

@interface ResponseBeanGoodsDetail : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end


