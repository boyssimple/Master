//
//  RequestBeanCancelOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/24.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanCancelOrder : AJRequestBeanBase
@property(nonatomic,strong)NSString *FD_ID;     //定单ID
@property(nonatomic,strong)NSString *FD_CANEL_USER_ID;     //人ID
@property(nonatomic,strong)NSString *FD_CANEL_REASON;     //取消原因
@end

@interface ResponseBeanCancelOrder : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
