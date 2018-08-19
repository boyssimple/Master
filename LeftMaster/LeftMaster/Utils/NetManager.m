//
//  NetManager.m
//  CarNetworking
//
//  Created by yanyu on 2018/8/7.
//  Copyright © 2018年 baojie. All rights reserved.
//

#import "NetManager.h"


static NetManager *_netManager;

@interface NetManager()
@property(nonatomic,strong)NSURLSessionConfiguration *configuration;
@property(nonatomic,strong)AFURLSessionManager *manager;
@end

@implementation NetManager

+(NetManager *)shareInstance
{
    static dispatch_once_t oneToken;
    
    dispatch_once(&oneToken, ^{
        _netManager = [[NetManager alloc]init];
    });
    return _netManager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:_configuration];
    }
    return self;
}

//@"http://192.168.7.81:8086/ld/app/cmd/sendOpenLockCmd"


- (void)requestPost:(NSString *)url param:(NSDictionary*)params withVC:(UIViewController*)vc successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock withShowHUD:(BOOL)show{
    [self requestMethod:@"POST" url:url param:params withVC:vc successBlock:successBlock failurBlock:errorBlock withShowHUD:show];
}


- (void)requestGet:(NSString *)url param:(NSDictionary*)params withVC:(UIViewController*)vc successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock withShowHUD:(BOOL)show{
    [self requestMethod:@"GET" url:url param:params withVC:vc successBlock:successBlock failurBlock:errorBlock withShowHUD:show];
}

- (void)requestMethod:(NSString *)method url:(NSString *)url param:(NSDictionary*)params withVC:(UIViewController*)vc successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock withShowHUD:(BOOL)show{
    NSString *urlStr = [NSString stringWithFormat:@"http://%@%@",Base_Url,url];
    
    NSLog(@"%@\n%@",urlStr,params);
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:urlStr parameters:params error:nil];
    AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    self.manager.responseSerializer = responseSerializer;
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if(errorBlock){
                errorBlock(error);
            }
        } else {
            if(successBlock){
                successBlock(responseObject);
            }
        }
    }];
    [dataTask resume];
}
@end
