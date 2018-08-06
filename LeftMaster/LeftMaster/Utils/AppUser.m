//
//  AppUser.m
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AppUser.h"

static AppUser * _user;
@implementation AppUser

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    // 一次函数
    dispatch_once(&onceToken, ^{
        if (_user == nil) {
            _user = [super allocWithZone:zone];
        }
    });
    
    return _user;
}

+ (instancetype)share{
    return  [[self alloc] init];
}

- (void)parse:(NSDictionary*)data{
    self.ACCOUNT_TYPE = [data jk_integerForKey:@"ACCOUNT_TYPE"];
    self.COMPANY_NAME = [data jk_stringForKey:@"COMPANY_NAME"];
    self.COMPANY_PATH = [data jk_stringForKey:@"COMPANY_PATH"];
    self.CUS_ID = [data jk_stringForKey:@"CUS_ID"];
    self.CUS_NAME = [data jk_stringForKey:@"CUS_NAME"];
    self.DEPART_ID = [data jk_stringForKey:@"DEPART_ID"];
    self.DEPART_NAME = [data jk_stringForKey:@"DEPART_NAME"];
    self.SYSUSER_ACCOUNT = [data jk_stringForKey:@"SYSUSER_ACCOUNT"];
    self.SYSUSER_ID = [data jk_stringForKey:@"SYSUSER_ID"];
    self.SYSUSER_MOBILE = [data jk_stringForKey:@"SYSUSER_MOBILE"];
    self.SYSUSER_NAME = [data jk_stringForKey:@"SYSUSER_NAME"];
    self.SYSUSER_SEX = [data jk_integerForKey:@"SYSUSER_SEX"];
    self.SYSUSER_COMPANYID = [data jk_stringForKey:@"SYSUSER_COMPANYID"];
    
    if(self.ACCOUNT_TYPE == 10){
        self.isSalesman = TRUE;
    }else{
        self.isSalesman = FALSE;
    }
}

@end
