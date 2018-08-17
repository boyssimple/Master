//
//  RequestBeanLogin.m
//  LeftMaster
//
//  Created by simple on 2018/4/10.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "RequestBeanUploadImg.h"

@implementation RequestBeanUploadImg


- (NSString*)apiPath{
    return net_userPhotoUpload;
}

- (BOOL)isShowHub{
    return TRUE;
}

- (HTTP_METHOD)httpMetho{
    return HTTP_METHOD_POST;
}

+ (NSArray<NSString *> *)ignoredPropertyNames
{
    return @[@"img"];
}


- (NSString *)hubTips{
    return @"加载中...";
}

- (AFConstructingBlock)constructingBodyBlock{
    NSData *data = UIImageJPEGRepresentation(self.img, 0.8);
    NSString *name = @"img";
    NSString *formKey = @"img";
    NSString *type = @"applicaton/octet-stream";
    
    return AJConstructingBlockDefine {
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    };
}

@end

@implementation ResponseBeanUploadImg

- (BOOL)checkSuccess{
    if (self.success) { 
        return TRUE;
    }
    return FALSE;
}

@end






