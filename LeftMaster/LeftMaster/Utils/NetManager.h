//
//  NetManager.h
//  CarNetworking
//
//  Created by yanyu on 2018/8/7.
//  Copyright © 2018年 baojie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject

+(NetManager *)shareInstance;
- (void)requestPost:(NSString *)url param:(NSDictionary*)params withVC:(UIViewController*)vc successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock withShowHUD:(BOOL)show;


- (void)requestGet:(NSString *)url param:(NSDictionary*)params withVC:(UIViewController*)vc successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock withShowHUD:(BOOL)show;
@end
