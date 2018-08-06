//
//  RequestBeanVision.h
//  LeftMaster
//
//  Created by simple on 2018/6/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanVision : AJRequestBeanBase

@property(nonatomic,assign)NSInteger APP_TYPE;
@end 

@interface ResponseBeanVision : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
