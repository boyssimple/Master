//
//  VCEnterpriseAccountBind.m
//  LeftMaster
//
//  Created by simple on 2018/8/14.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCEnterpriseAccountBind.h"
#import "ViewInputText.h"

@interface VCEnterpriseAccountBind ()<UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScroll;
@property(nonatomic,strong)UILabel *lbEnperiseName;
@property(nonatomic,strong)UILabel *lbTips;
@property(nonatomic,strong)ViewInputText *vPhone;
@property(nonatomic,strong)ViewInputText *vCode;
@property(nonatomic,strong)UIButton *btnConfirm;
@property (nonatomic, strong) dispatch_source_t _timer;
@property (nonatomic, assign) BOOL isExecuting;
@property (nonatomic, strong) NSString *random;
@end

@implementation VCEnterpriseAccountBind

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)viewDidDisappear:(BOOL)animated{
    if(self._timer){
        dispatch_source_cancel(self._timer);
    }
    self._timer = nil;
}

- (void)initMain{
    self.title = @"企业帐户绑定";
    self.name = @"重庆广电总局局长等职务11";

    [self.view addSubview:self.mainScroll];
    
}

/*
 - (void)sendSmsEvent{
 [self.view endEditing:YES];
 NSString *phone = [self.tfPhone.text trim];
 if(phone.length == 0){
 [Utils showToast:@"请输入手机号码" with:self.view withTime:0.8];
 return;
 }
 if(phone.length != 11){
 [Utils showToast:@"手机号码错误" with:self.view withTime:0.8];
 return;
 }
 
 RequestBeanSms *requestBean = [RequestBeanSms new];
 requestBean.mobile = phone;
 [Utils showHanding:requestBean.hubTips with:self.view];
 __weak typeof(self) weakself = self;
 [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
 if(!err){
 // 结果处理
 ResponseBeanSms *response = responseBean;
 if(response.success){
 weakself.random = response.RANDOM;
 [Utils showSuccessToast:@"已发送" with:weakself.view withTime:0.6];
 [weakself startTimer];
 }else{
 [Utils showToast:response.msg with:self.view withTime:0.8];
 }
 }else{
 [Utils showSuccessToast:@"发送失败" with:weakself.view withTime:1];
 }
 
 }];
 }
 
 - (void)startTimer{
 if(!self.isExecuting){
 self.isExecuting = TRUE;
 [self.btnCheckCode setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
 self.btnCheckCode.enabled = NO;
 NSInteger ts = 60;
 __block NSInteger t = ts;
 
 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
 self._timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
 
 dispatch_source_set_timer(self._timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
 __weak typeof(self) weakself = self;
 dispatch_source_set_event_handler(self._timer, ^{
 
 if(t <= 0){ //倒计时结束，关闭
 dispatch_source_cancel(weakself._timer);
 weakself._timer = nil;
 dispatch_async(dispatch_get_main_queue(), ^{
 [weakself reset];
 });
 }else{
 
 NSInteger seconds = t % (ts+1);
 dispatch_async(dispatch_get_main_queue(), ^{
 
 NSLog(@"执行");
 [weakself.btnCheckCode setTitle:[NSString stringWithFormat:@"%zi秒后重发", seconds] forState:UIControlStateNormal];
 });
 t--;
 }
 });
 dispatch_resume(weakself._timer);
 }
 
 }
 
 - (void)reset{
 [self.btnCheckCode setTitle:@"获取验证码" forState:UIControlStateNormal];
 [self.btnCheckCode setTitleColor:APP_COLOR forState:UIControlStateNormal];
 self.btnCheckCode.enabled = YES;
 self.isExecuting = FALSE;
 }
 
 - (BOOL)textFieldShouldReturn:(UITextField *)textField{
 [textField resignFirstResponder];
 return YES;
 }
 
 - (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
 [self.view endEditing:YES];
 
 }
 
 */


- (void)startTimer{
    if(!self.isExecuting){
        self.isExecuting = TRUE;
        [self.vCode.btnButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.vCode.btnButton.enabled = NO;
        NSInteger ts = 60;
        __block NSInteger t = ts;
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        self._timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        dispatch_source_set_timer(self._timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        __weak typeof(self) weakself = self;
        dispatch_source_set_event_handler(self._timer, ^{
            
            if(t <= 0){ //倒计时结束，关闭
                dispatch_source_cancel(weakself._timer);
                weakself._timer = nil;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself reset];
                });
            }else{
                
                NSInteger seconds = t % (ts+1);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    NSLog(@"执行");
                    [weakself.vCode.btnButton setTitle:[NSString stringWithFormat:@"%zi秒后重发", seconds] forState:UIControlStateNormal];
                });
                t--;
            }
        });
        dispatch_resume(weakself._timer);
    }
    
}

- (void)reset{
    [self.vCode.btnButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.vCode.btnButton setTitleColor:APP_COLOR forState:UIControlStateNormal];
    self.vCode.btnButton.enabled = YES;
    self.isExecuting = FALSE;
}

- (UIScrollView*)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        _mainScroll.alwaysBounceVertical = YES;
        _mainScroll.backgroundColor = [UIColor whiteColor];
        [_mainScroll addSubview:self.lbEnperiseName];
        [_mainScroll addSubview:self.lbTips];
        [_mainScroll addSubview:self.vPhone];
        [_mainScroll addSubview:self.vCode];
        [_mainScroll addSubview:self.btnConfirm];
        _mainScroll.userInteractionEnabled = TRUE;
        _mainScroll.delegate = self;
        _mainScroll.contentSize = CGSizeMake(DEVICEWIDTH, self.btnConfirm.bottom + 20*RATIO_WIDHT320);
        UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
        sigleTapRecognizer.numberOfTapsRequired = 1;
        [_mainScroll addGestureRecognizer:sigleTapRecognizer];
    }
    return _mainScroll;
    
}

- (void)handleTapGesture{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 回收键盘
    [textField resignFirstResponder];
    return YES;
}

- (UILabel*)lbEnperiseName{
    if(!_lbEnperiseName){
        _lbEnperiseName = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, 40*RATIO_WIDHT320, DEVICEWIDTH - 20*RATIO_WIDHT320, 0)];
        _lbEnperiseName.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbEnperiseName.textColor = RGB(0, 0, 0);
        _lbEnperiseName.numberOfLines = 0;
        _lbEnperiseName.textAlignment = NSTextAlignmentCenter;
        _lbEnperiseName.text = self.name;
        CGSize size = [_lbEnperiseName sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
        _lbEnperiseName.height = size.height;
        
    }
    return _lbEnperiseName;
}

- (UILabel*)lbTips{
    if(!_lbTips){
        _lbTips = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, self.lbEnperiseName.bottom + 5*RATIO_WIDHT320, DEVICEWIDTH - 20*RATIO_WIDHT320, 0)];
        _lbTips.font = [UIFont systemFontOfSize:10*RATIO_WIDHT320];
        _lbTips.textColor = [UIColor lightGrayColor];
        _lbTips.numberOfLines = 0;
        _lbTips.textAlignment = NSTextAlignmentCenter;
        _lbTips.text = @"请使用开户手机号获取验证码";
        CGSize size = [_lbTips sizeThatFits:CGSizeMake(DEVICEWIDTH - 20*RATIO_WIDHT320, MAXFLOAT)];
        _lbTips.height = size.height;
        
    }
    return _lbTips;
}

- (ViewInputText*)vPhone{
    if(!_vPhone){
        _vPhone = [[ViewInputText alloc]initWithFrame:CGRectMake(0, self.lbTips.bottom + 40*RATIO_WIDHT320, DEVICEWIDTH, [ViewInputText calHeight])];
        _vPhone.lbName.text = @"开户手机号";
        _vPhone.tfText.text = @"159****7516";
        _vPhone.tfText.textColor = [UIColor lightGrayColor];
        _vPhone.tfText.enabled = FALSE;
        _vPhone.type = 1;
        [_vPhone updateData];
    }
    return _vPhone;
}

- (ViewInputText*)vCode{
    if(!_vCode){
        _vCode = [[ViewInputText alloc]initWithFrame:CGRectMake(0, self.vPhone.bottom, DEVICEWIDTH, [ViewInputText calHeight])];
        _vCode.lbName.text = @"验证码";
        _vCode.tfText.placeholder = @"请输入验证码";
        _vCode.tfText.delegate = self;
        _vCode.type = 2;
        __weak typeof(self) weakself = self;
        _vCode.clickBlock = ^{
            [weakself startTimer];
        };
        [_vCode updateData];
    }
    return _vCode;
}


- (UIButton*)btnConfirm{
    if(!_btnConfirm){
        _btnConfirm = [[UIButton alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, self.vCode.bottom + 50*RATIO_WIDHT320, DEVICEWIDTH - 20*RATIO_WIDHT320, 45*RATIO_WIDHT320)];
        _btnConfirm.backgroundColor = APP_COLOR;//RGB3(213)
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnConfirm.titleLabel.font = [UIFont systemFontOfSize:17*RATIO_WIDHT320];
        _btnConfirm.layer.cornerRadius = 4.5f;
        [_btnConfirm addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnConfirm.tag = 101;
    }
    return _btnConfirm;
}


@end
