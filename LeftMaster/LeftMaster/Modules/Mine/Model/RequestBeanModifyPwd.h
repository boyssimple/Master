//
//  RequestBeanModifyPwd.h
//  LeftMaster
//
//  Created by simple on 2018/4/21.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanModifyPwd : AJRequestBeanBase
@property(nonatomic,strong)NSString *SYSUSER_ID;     //user_id
@property(nonatomic,strong)NSString *OLD_PASSWORD;     //旧密码
@property(nonatomic,strong)NSString *NEW_PASSWORD;     //新密码
@property(nonatomic,strong)NSString *CONFIRM_PASSWORD;     //确认密码
@property(nonatomic,strong)NSString *MOBILE;     //手机号码
@property(nonatomic,assign)NSInteger TYPE;                  //类型1修改密码，2忘记密码
@end

@interface ResponseBeanModifyPwd : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end

