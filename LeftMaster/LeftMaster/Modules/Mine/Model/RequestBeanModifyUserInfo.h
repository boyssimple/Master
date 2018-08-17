//
//  RequestBeanModifyUserInfo.h
//  LeftMaster
//
//  Created by simple on 2018/8/15.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanModifyUserInfo : AJRequestBeanBase
@property(nonatomic,strong)NSString *SYSUSER_ID;
@property(nonatomic,strong)NSString *SYSUSER_NAME;//用户名
@property(nonatomic,strong)NSString *SYSUSER_MOBILE;//用户手机号
@end

@interface ResponseBeanModifyUserInfo : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
