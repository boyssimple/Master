//
//  VCSetPassword.m
//  LeftMaster
//
//  Created by simple on 2018/4/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCEnterpriseAccount.h"
#import "RequestBeanGetWalletPage.h"

@interface VCEnterpriseAccount ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;

@end

@implementation VCEnterpriseAccount

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.title = @"企业帐户";
    [self.view addSubview:self.webView];
}


- (void)loadData{
    RequestBeanGetWalletPage *requestBean = [RequestBeanGetWalletPage new];
    requestBean.eaUserId = [AppUser share].eaUserId_corp;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if(!err){
            // 结果处理
            ResponseBeanGetWalletPage *response = responseBean;
            if(response.success){
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:response.result]];
                [weakself.webView loadRequest:request];
            }else{
                [Utils showToast:response.message with:self.view withTime:0.8];
            }
        }else{
            [Utils showToast:@"网络错误" with:self.view withTime:0.8];
        }
        
    }];
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [Utils hiddenHanding:self.view withTime:0.5];
}

- (UIWebView*)webView{
    if(!_webView){
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
    }
    return _webView;
}



@end


