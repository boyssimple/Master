//
//  RequestBeanQueryCartNum.h
//  LeftMaster
//
//  Created by simple on 2018/4/24.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanQueryCartNum : AJRequestBeanBase
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *cus_id;
@end

@interface ResponseBeanQueryCartNum : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,assign)NSInteger num;
@end
