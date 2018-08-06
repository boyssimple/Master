//
//  RequestBeanLogin.h
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanLogin : AJRequestBeanBase

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *passWord;

@end

@interface ResponseBeanLogin : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
