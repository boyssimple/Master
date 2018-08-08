//
//  LaunchAdsManager.m
//  LeftMaster
//
//  Created by simple on 2018/8/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "LaunchAdsManager.h"
#import "FLAnimatedImageView.h"
#import <UIKit/UIKit.h>
#import <FLAnimatedImage.h>

@interface LaunchAdsManager()
@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)UIView *vContent;
@property(nonatomic,strong)FLAnimatedImageView *ivContent;
@property(nonatomic,strong)UIButton *btnSeek;
@property(nonatomic,copy)dispatch_source_t roundTimer;
@property (copy, nonatomic) void (^actionBlock)(void);
@end
@implementation LaunchAdsManager


+(LaunchAdsManager *)shareManager{
    static LaunchAdsManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[LaunchAdsManager alloc] init];
    });
    return instance;
}

- (void)setupLaunchAd:(void(^)(void))calculateBlock{
    _actionBlock = calculateBlock;
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    id downloaded = [defautls objectForKey:@"downloaded"];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    window.rootViewController.view.backgroundColor = [UIColor clearColor];
    window.rootViewController.view.userInteractionEnabled = NO;
    window.windowLevel = UIWindowLevelStatusBar + 1;
    window.hidden = NO;
    window.alpha = 1;
    _window = window;
    /** 添加launchImageView */
    
    _vContent = [[UIView alloc]initWithFrame:_window.frame];
    _ivContent = [[FLAnimatedImageView alloc]initWithFrame:_window.frame];
    _ivContent.backgroundColor = [UIColor whiteColor];
    
    if(downloaded){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:downloaded];
        
        
        NSData *data1 = [NSData dataWithContentsOfFile:filePath];
        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
        if(animatedImage1){
            _ivContent.animatedImage = animatedImage1;
        }else{
            NSData *data1 = [NSData dataWithContentsOfFile:filePath];
            _ivContent.image = [UIImage imageWithData:data1];
        }
    }else{
        NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"image2" withExtension:@"jpg"];
        NSData *data1 = [NSData dataWithContentsOfURL:url1];
        FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
        _ivContent.animatedImage = animatedImage1;
    }
    _ivContent.userInteractionEnabled = TRUE;
    [_vContent addSubview:_ivContent];
    [_window addSubview:_vContent];

    //跳过
    _btnSeek = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-60, 20, 40, 40)];
    [_btnSeek setTitle:@"跳过" forState:UIControlStateNormal];
    _btnSeek.backgroundColor = [UIColor blackColor];
    [_btnSeek setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _btnSeek.titleLabel.font = [UIFont systemFontOfSize:12];
    _btnSeek.alpha = 0.8;
    _btnSeek.layer.cornerRadius = 20;
    [_btnSeek addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_vContent addSubview:_btnSeek];
    
    NSInteger period = 5;
    __block NSInteger t = period;
    _roundTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_roundTimer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_roundTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if(t <= 0){
                // 终止定时器
                dispatch_suspend(_roundTimer);
                [self dismiss];
            }
            
            NSInteger seconds = t % (period+1);
            if(t > 0){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.btnSeek setTitle:[NSString stringWithFormat:@"%ld",seconds] forState:UIControlStateNormal];
                });
            }
            t--;
        });
    });
    dispatch_resume(_roundTimer);
}

- (void)existsUpdate{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://imgsrc.baidu.com/forum/w%3D580/sign=c719dbd8d3b44aed594ebeec831d876a/f9756e600c338744aaf9f7ee580fd9f9d72aa031.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
        [defautls setObject:filePath.relativePath.lastPathComponent forKey:@"downloaded"];
        [defautls synchronize];
        NSLog(@"File downloaded to: %@", filePath.relativePath.lastPathComponent);
    }];
    [downloadTask resume];
    /*
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"" parameters:nil error:nil];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            
        }
    }];
    [dataTask resume];
     */
}

- (void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        _vContent.alpha = 0;
    } completion:^(BOOL finished) {
        [self.window resignKeyWindow];
        [_window removeAllSubviews];
        _window = nil;
        if(_actionBlock){
            dispatch_suspend(_roundTimer);
            _actionBlock();
        }
    }];
}

@end
