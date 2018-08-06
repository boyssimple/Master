//
//  RequestBeanGoodsList.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanGoodsList : AJRequestBeanBase

@property(nonatomic,strong)NSString *goods_type_id;     //商品分类ID
@property(nonatomic,assign)BOOL new_goods;              //是否新品（是：true）
@property(nonatomic,strong)NSString *price_order;       //价格排序（降序：desc; 升序:asc）
@property(nonatomic,strong)NSString *comp_order;        //综合排序（是：true）
@property(nonatomic,strong)NSString *search_name;        //搜索条件
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@property(nonatomic,strong)NSString *cus_id;     //客户ID
@property(nonatomic,strong)NSString *company_id;     //客户ID



@end

@interface ResponseBeanGoodsList : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end

