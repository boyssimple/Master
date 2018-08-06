//
//  RequestBeanSms.h
//  LeftMaster
//
//  Created by simple on 2018/4/20.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanSms : AJRequestBeanBase
@property(nonatomic,strong)NSString *mobile;     //手机号
@end

@interface ResponseBeanSms : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSString *RANDOM;
@property(nonatomic,strong)NSDictionary *data;
@end


