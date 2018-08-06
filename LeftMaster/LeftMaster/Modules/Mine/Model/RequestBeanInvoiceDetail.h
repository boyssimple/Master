//
//  RequestBeanInvoiceDetail.h
//  LeftMaster
//
//  Created by simple on 2018/5/21.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanInvoiceDetail : AJRequestBeanBase
@property(nonatomic,strong)NSString *FD_SEND_ID;     //发货单id
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end

@interface ResponseBeanInvoiceDetail : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
