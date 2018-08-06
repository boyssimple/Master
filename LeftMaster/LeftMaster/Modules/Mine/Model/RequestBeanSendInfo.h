//
//  RequestBeanSendInfo.h
//  LeftMaster
//
//  Created by simple on 2018/4/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanSendInfo : AJRequestBeanBase
@property(nonatomic,strong)NSString *FD_ORDER_ID;     //定单ID
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end
//         ResponseBeanSendInfo
@interface ResponseBeanSendInfo : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end

