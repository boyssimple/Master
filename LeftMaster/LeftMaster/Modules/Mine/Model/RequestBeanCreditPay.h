//
//  RequestBeanCreditPay.h
//  LeftMaster
//
//  Created by simple on 2018/8/12.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanCreditPay : AJRequestBeanBase
@property(nonatomic,strong)NSString *FD_ID;
@property(nonatomic,strong)NSString *FD_SUMIT_USER_ID;//提交人 ID(当前登录人 ID)
@end

@interface ResponseBeanCreditPay : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
