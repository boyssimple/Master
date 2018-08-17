//
//  NetManager.m
//  LeftMaster
//
//  Created by simple on 2018/8/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "NetManager.h"
#import <CommonCrypto/CommonDigest.h>


@interface NetManager()
@property(nonatomic,strong)NSURLSessionConfiguration *configuration;
@property(nonatomic,strong)AFURLSessionManager *manager;
@end

static NetManager * _singleton;
@implementation NetManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_singleton) {
            _singleton = [[self alloc] init];
        }
    });
    return _singleton;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:_configuration];
    }
    return self;
}

- (void)requestPost:(NSString*)urlStr withParams:(NSDictionary*)param successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock{
    [self request:@"POST" withUrl:urlStr withParams:param successBlock:successBlock failurBlock:errorBlock];
}

- (void)requestGet:(NSString*)urlStr withParams:(NSDictionary*)param successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock{
    [self request:@"GET" withUrl:urlStr withParams:param successBlock:successBlock failurBlock:errorBlock];
}

- (void)request:(NSString *)method withUrl:(NSString*)urlStr withParams:(NSDictionary*)param successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock{
    NSMutableDictionary *newParam = [param mutableCopy];
    [newParam setObject:@"18082916013301600472" forKey:@"requestNo"];
    [newParam setObject:urlStr forKey:@"service"];
    [newParam setObject:@"18082916013301600472" forKey:@"partnerId"];
    [newParam setObject:@"MD5" forKey:@"signType"];
    [newParam setObject:@"748f0bcf8d02e2977fa1e7c345db9b80" forKey:@"sign"];
    NSString *url = [NSString stringWithFormat:@"http://open.qizhangtong.com:8810"];
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:url parameters:param error:nil];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if(errorBlock){
                errorBlock(error);
            }
            NSLog(@"Error: %@", error);
        } else {
            if(successBlock){
                successBlock(responseObject);
            }
            NSLog(@"结果:%@",responseObject);
        }
    }];
    [dataTask resume];
}

- (NSString *)signStr:(NSDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![[dict objectForKey:categoryId] isEqualToString:@"sign"]
            && ![[dict objectForKey:categoryId] isEqualToString:@"key"]
            )
        {
            if(contentString.length != 0){
                [contentString appendFormat:@"&"];
            }
            [contentString appendFormat:@"%@=%@", categoryId, [dict objectForKey:categoryId]];
        }
    }
    //HMACMD5
//    NSString *signStr = [SignTool HMACMD5WithString:contentString WithKey:APPSECRET];
    return contentString;
}

#pragma mark - 32位 小写
-(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

@end
