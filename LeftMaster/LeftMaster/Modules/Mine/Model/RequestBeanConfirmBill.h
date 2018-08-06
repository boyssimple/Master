//
//  RequestBeanConfirmBill.h
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//


@interface RequestBeanConfirmBill : AJRequestBeanBase
@property(nonatomic,strong)NSString *ca_bill_id;
@property(nonatomic,assign)NSInteger billstatus;//1确认
@end

@interface ResponseBeanConfirmBill : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
