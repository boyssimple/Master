//
//  NetManager.h
//  LeftMaster
//
//  Created by simple on 2018/8/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetManager : NSObject
+ (instancetype)sharedInstance;

- (void)requestPost:(NSString*)urlStr withParams:(NSDictionary*)param successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock;
- (void)requestGet:(NSString*)urlStr withParams:(NSDictionary*)param successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock;
@end
