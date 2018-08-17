//
//  FileUpload.h
//  LeftMaster
//
//  Created by simple on 2018/8/15.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUpload : NSObject
+ (instancetype)sharedInstance;
- (void)upload:(NSString *)url withParam:(NSDictionary*)param withImg:(UIImage*)img successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock withVC:(UIViewController*)vc;
@end
