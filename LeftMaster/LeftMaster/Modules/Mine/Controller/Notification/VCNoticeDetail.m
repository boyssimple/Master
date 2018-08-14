//
//  VCNoticeDetail.m
//  LeftMaster
//
//  Created by simple on 2018/4/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCNoticeDetail.h"

@interface VCNoticeDetail ()
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation VCNoticeDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"详情";
    [self.view addSubview:self.webView];
    
    [self.webView loadHTMLString:[self installHtml:self.content] baseURL:nil];
}


- (NSString*)installHtml:(NSString*)content{
    if(!content){
        content = @"";
    }
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"notice.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#ffffff\">"];
    [html appendString:content];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    return html;
}



- (UIWebView*)webView{
    if(!_webView){
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}
@end
