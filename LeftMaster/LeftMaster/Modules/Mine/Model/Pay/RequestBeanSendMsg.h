//
//  RequestBeanSendMsg.h
//  LeftMaster
//
//  Created by simple on 2018/8/18.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanSendMsg : AJRequestBeanBase

@property(nonatomic,strong)NSString *mobile;

@end

@interface ResponseBeanSendMsg : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSDictionary *data;
@end
