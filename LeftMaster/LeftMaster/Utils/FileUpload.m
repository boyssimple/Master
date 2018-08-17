//
//  FileUpload.m
//  LeftMaster
//
//  Created by simple on 2018/8/15.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "FileUpload.h"

@interface FileUpload()
@property(nonatomic,strong)NSURLSessionConfiguration *configuration;
@property(nonatomic,strong)AFURLSessionManager *manager;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

static FileUpload * _singleton;
@implementation FileUpload

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
        AFJSONResponseSerializer *resSerializer = [AFJSONResponseSerializer serializer];
        resSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
        self.manager.responseSerializer = resSerializer;
    }
    return self;
}

- (void)upload:(NSString *)url withParam:(NSDictionary*)param withImg:(UIImage*)img successBlock:(void(^)(id resobject))successBlock failurBlock:(void(^)(NSError *error))errorBlock withVC:(UIViewController*)vc{
    
//    MBProgressHUD *hud  =  [[MBProgressHUD alloc]initWithView:vc.view];
//    [vc.view addSubview:hud];
//    hud.tag=1000;
//    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
//    hud.labelText = @"上传中...";
//    hud.square = YES;
//    [hud show:YES];
    __weak typeof(self) weakself = self;
    NSData *data = [self zipNSDataWithImage:img];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"http://%@%@",Base_Url,url] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:data name:@"file" fileName:@"filename.png" mimeType:@"image/jpeg"];
        
    } error:nil];
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [self.manager uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      NSLog(@"%f",uploadProgress.fractionCompleted);
//                      hud.progress = uploadProgress.fractionCompleted/1.0;
//                      hud.labelText = [NSString stringWithFormat:@"已上传%.0f%%",uploadProgress.fractionCompleted*100];
                  } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//                      [hud hide:TRUE];
                      if (error) {
                          NSLog(@"Error: %@", error);
                          if(errorBlock){
                              errorBlock(error);
                          }
                      } else {
                          if(successBlock){
                              successBlock(responseObject);
                          }
                          NSLog(@"Success: %@", responseObject);
                      }
                  }];
    
    [uploadTask resume];
}

- (NSData *)zipNSDataWithImage:(UIImage *)sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>1280||height>1280) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>1280||height<1280){
        CGFloat scale = height/width;
        width = 1280;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<1280||height>1280){
        CGFloat scale = width/height;
        height = 1280;
        width = height*scale;
        //4.宽高都小于1280
    }else{
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.7);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return data;
}
@end
