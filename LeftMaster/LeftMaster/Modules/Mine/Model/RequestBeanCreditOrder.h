//
//  RequestBeanCreditOrder.h
//  LeftMaster
//
//  Created by simple on 2018/8/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanCreditOrder : AJRequestBeanBase
@property(nonatomic,strong)NSString *cus_id;
@property(nonatomic,strong)NSString *FD_PAY_STATUS;//为空时所有，待付款:1  未付款:2
@end

@interface ResponseBeanCreditOrder : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
