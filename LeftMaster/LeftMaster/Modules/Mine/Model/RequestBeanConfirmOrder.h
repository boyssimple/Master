//
//  RequestBeanConfirmOrder.h
//  LeftMaster
//
//  Created by simple on 2018/4/24.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanConfirmOrder : AJRequestBeanBase
@property(nonatomic,strong)NSString *FD_ID;     //定单ID
@property(nonatomic,strong)NSString *FD_CREATE_USER_ID;     //确认人ID
@end

@interface ResponseBeanConfirmOrder : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
