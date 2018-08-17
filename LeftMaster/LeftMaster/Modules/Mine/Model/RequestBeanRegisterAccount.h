//
//  RequestBeanRegisterAccount.h
//  LeftMaster
//
//  Created by simple on 2018/8/17.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanRegisterAccount : AJRequestBeanBase
@property(nonatomic,strong)NSString *SYSUSER_ID;
@property(nonatomic,strong)NSString *SYSUSER_Name;
@property(nonatomic,strong)NSString *SYSUSER_Card;
@property(nonatomic,strong)NSString *SYSUSER_BankCard;
@property(nonatomic,strong)NSString *SYSUSER_Phone;
@property(nonatomic,strong)NSString *SYSUSER_Code; 
@end

@interface ResponseBeanRegisterAccount : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
