//
//  VCWebView.m
//  LeftMaster
//
//  Created by simple on 2018/8/17.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCWebView.h"

@interface VCWebView ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation VCWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [_webView loadRequest:request];
    [Utils showHanding:@"加载中..." with:self.view];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [Utils hiddenHanding:self.view withTime:0.5];
}

@end
