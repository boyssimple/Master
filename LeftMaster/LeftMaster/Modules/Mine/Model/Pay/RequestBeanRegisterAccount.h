//
//  RequestBeanRegisterAccount.h
//  LeftMaster
//
//  Created by simple on 2018/8/17.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanRegisterAccount : AJRequestBeanBase
@property(nonatomic,strong)NSString *outUserId;//用户ID
@property(nonatomic,strong)NSString *captcha;//验证码
@property(nonatomic,strong)NSString *mobileNo;//手机号
@property(nonatomic,strong)NSString *realName;//姓名
@property(nonatomic,strong)NSString *certNo;//身份证号码
@property(nonatomic,strong)NSString *bankCard;//银行止号
@end

@interface ResponseBeanRegisterAccount : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSDictionary *data;
@end
