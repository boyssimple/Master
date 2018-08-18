//
//  RequestBeanPayGoods.h
//  LeftMaster
//
//  Created by simple on 2018/8/18.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanPayGoods : AJRequestBeanBase
@property(nonatomic,strong)NSString *eaUserId;
@property(nonatomic,strong)NSString *merchOrderNo;
@end

@interface ResponseBeanPayGoods : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSDictionary *data;
@end
