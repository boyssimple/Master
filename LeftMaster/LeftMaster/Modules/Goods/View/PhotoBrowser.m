//
//  WindowGuide.m
//  LeftMaster
//
//  Created by simple on 2018/4/19.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "PhotoBrowser.h"
#import "CellCancelOrder.h"
#import "ViewHeaderCancelOrder.h"
#import "Reason.h"

@interface PhotoBrowser()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, strong) UIScrollView *mainView;
@property(nonatomic,strong)UIImageView *ivImg;
@property(nonatomic,strong)NSString *url;
@end

@implementation PhotoBrowser

- (id)init:(NSString*)url
{
    self = [super initWithFrame:(CGRect) {{0.f,0.f}, [[UIScreen mainScreen] bounds].size}];
    if (self) {
        self.windowLevel = UIWindowLevelAlert;
        photoWindow = self;
        _url = url;
        [self setupSubviews];
    }
    
    return self;
}


- (void)setupSubviews{
    _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
    _grayView.backgroundColor = [UIColor blackColor];
    _grayView.alpha = 0;
    _grayView.userInteractionEnabled = YES;
    [self addSubview:_grayView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [_grayView addGestureRecognizer:tap];
    
    _mainView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.userInteractionEnabled = TRUE;
    _mainView.delegate = self;
    [self addSubview:_mainView];
    
    _ivImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
    _ivImg.userInteractionEnabled = YES;
    [_mainView addSubview:_ivImg];
    __weak typeof(self) weakself = self;
    [_ivImg sd_setImageWithURL:[NSURL URLWithString:self.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGSize size = image.size;
        CGFloat w = size.width;
        CGFloat r = w / DEVICEWIDTH;
        if (w > DEVICEWIDTH) {
            r = DEVICEWIDTH / w;
        }
        if (w > DEVICEWIDTH) {
            w = DEVICEWIDTH;
        }
        CGFloat h = size.height * r;
        CGRect f = weakself.ivImg.frame;
        f.size.width = w;
        f.size.height = h;
        f.origin.x = (DEVICEWIDTH - w)/2.0;
        f.origin.y = (DEVICEHEIGHT - h)/2.0;
        
    }];
}

- (void)show {
    [self makeKeyAndVisible];
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakself.grayView.alpha = 1;
        weakself.mainView.alpha = 1;
    }];
}

- (void)dismiss {
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.3 animations:^{
        photoWindow.alpha = 0;
        weakself.mainView.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            weakself.grayView.alpha = 0;
        } completion:^(BOOL finished) {
            [photoWindow removeAllSubviews];
            photoWindow = nil;
            [self resignKeyWindow];
        }];
    }];
    
}

@end
