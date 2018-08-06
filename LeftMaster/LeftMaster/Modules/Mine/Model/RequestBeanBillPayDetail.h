//
//  RequestBeanBillPayDetail.h
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//

@interface RequestBeanBillPayDetail : AJRequestBeanBase
@property(nonatomic,strong)NSString *ca_bill_id;
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end

@interface ResponseBeanBillPayDetail : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
