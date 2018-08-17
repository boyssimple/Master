//
//  RequestBeanGetUserInfo.h
//  LeftMaster
//
//  Created by simple on 2018/8/16.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanGetUserInfo : AJRequestBeanBase
@property(nonatomic,strong)NSString *SYSUSER_ID;
@end

@interface ResponseBeanGetUserInfo : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
