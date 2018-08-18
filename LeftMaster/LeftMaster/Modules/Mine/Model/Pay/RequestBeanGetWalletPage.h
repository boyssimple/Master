//
//  RequestBeanGetWalletPage.h
//  LeftMaster
//
//  Created by simple on 2018/8/18.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanAddBatchCart.h"

@interface RequestBeanGetWalletPage : AJRequestBeanBase
@property(nonatomic,strong)NSString *eaUserId;//企业用户ID
@end

@interface ResponseBeanGetWalletPage : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSDictionary *data;
@end
