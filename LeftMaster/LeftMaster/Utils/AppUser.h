//
//  AppUser.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUser : NSObject
@property(nonatomic,assign)NSInteger ACCOUNT_TYPE;  //账号类型（业务员：1 0  ; 客户:20）
@property(nonatomic,strong)NSString *COMPANY_NAME;  //所属公司名称
@property(nonatomic,strong)NSString *COMPANY_PATH;
@property(nonatomic,strong)NSString *CUS_ID;        //客户ID(账号类型为业务员时有效)
@property(nonatomic,strong)NSString *CUS_NAME;      //客户名称(账号类型为业务员时有效)
@property(nonatomic,strong)NSString *DEPART_ID;     //部门ID
@property(nonatomic,strong)NSString *DEPART_NAME;   //所属部门名称
@property(nonatomic,strong)NSString *SYSUSER_ACCOUNT;//用户登录名
@property(nonatomic,strong)NSString *SYSUSER_ID;     //userId
@property(nonatomic,strong)NSString *SYSUSER_MOBILE;//用户手机
@property(nonatomic,strong)NSString *SYSUSER_NAME;  //用户名称
@property(nonatomic,strong)NSString *SYSUSER_COMPANYID;  //公司ID
@property(nonatomic,assign)NSInteger SYSUSER_SEX;   //性别
@property(nonatomic,assign)BOOL isSalesman;         //是否业务员
@property(nonatomic,assign)BOOL isModifyPwd;         //是否需要修改密码

- (void)parse:(NSDictionary*)data;

+ (instancetype)share;

@end
