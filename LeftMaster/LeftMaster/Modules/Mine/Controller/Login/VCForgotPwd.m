//
//  VCSetPassword.m
//  LeftMaster
//
//  Created by simple on 2018/4/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCForgotPwd.h"
#import "VCForgotPwdFinish.h"
#import "RequestBeanSms.h"

@interface VCForgotPwd ()<UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScroll;
@property(nonatomic,strong)UIView *vOldBg;
@property(nonatomic,strong)UIView *vNewBg;
@property(nonatomic,strong)UIView *vConfirmBg;
@property(nonatomic,strong)UILabel *lbOldPwd;
@property(nonatomic,strong)UITextField *tfPhone;
@property(nonatomic,strong)UIView *vLine;

@property(nonatomic,strong)UILabel *lbNewPwd;
@property(nonatomic,strong)UITextField *tfCheckCode;
@property(nonatomic,strong)UIButton *btnCheckCode;
@property(nonatomic,strong)UIView *vLineTwo;

@property(nonatomic,strong)UIButton *btnNext;
@property (nonatomic, strong) dispatch_source_t _timer;
@property (nonatomic, assign) BOOL isExecuting;
@property (nonatomic, strong) NSString *random;
@end

@implementation VCForgotPwd

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"忘记密码";
    [self.view addSubview:self.mainScroll];
}


- (UIScrollView*)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        _mainScroll.alwaysBounceVertical = YES;
        _mainScroll.backgroundColor = APP_Gray_COLOR;
        [_mainScroll addSubview:self.vOldBg];
        [_mainScroll addSubview:self.vNewBg];
        [_mainScroll addSubview:self.btnNext];
        _mainScroll.delegate = self;
    }
    return _mainScroll;
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

- (void)clickAction:(UIButton*)sender{
    if(sender.tag == 100){
        [self sendSmsEvent];
    }else if(sender.tag == 101){
        NSString *code = [self.tfCheckCode.text trim];
        if(code.length == 0){
            [Utils showToast:@"请输入验证码" with:self.view withTime:0.8];
        }else if([code isEqualToString:self.random]){
            VCForgotPwdFinish *vc = [[VCForgotPwdFinish alloc]init];
            vc.phone = self.tfPhone.text;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [Utils showToast:@"验证码错误" with:self.view withTime:0.8];
        }
    }
}

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

- (UIView*)vOldBg{
    if(!_vOldBg){
        _vOldBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 15*RATIO_WIDHT320, DEVICEWIDTH, 35*RATIO_WIDHT320)];
        _vOldBg.backgroundColor = [UIColor whiteColor];
        [_vOldBg addSubview:self.lbOldPwd];
        [_vOldBg addSubview:self.tfPhone];
        [_vOldBg addSubview:self.vLine];
    }
    return _vOldBg;
}

- (UILabel*)lbOldPwd{
    if(!_lbOldPwd){
        _lbOldPwd = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, 0, 100*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _lbOldPwd.text = @"手机号码";
        _lbOldPwd.textColor = RGB3(0);
        _lbOldPwd.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
    }
    return _lbOldPwd;
}

- (UITextField*)tfPhone{
    if(!_tfPhone){
        _tfPhone = [[UITextField alloc]initWithFrame:CGRectMake(self.lbOldPwd.right, 0, DEVICEWIDTH - self.lbOldPwd.right - 10*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _tfPhone.placeholder = @"请填写手机号码";
        _tfPhone.textColor = RGB3(0);
        _tfPhone.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _tfPhone.keyboardType = UIKeyboardTypePhonePad;
        _tfPhone.delegate = self;
    }
    return _tfPhone;
}

- (UIView*)vLine{
    if(!_vLine){
        _vLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.vOldBg.height - 0.5, DEVICEWIDTH, 0.5)];
        _vLine.backgroundColor = RGB3(230);
    }
    return _vLine;
}



- (UIView*)vNewBg{
    if(!_vNewBg){
        _vNewBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.vOldBg.bottom+10*RATIO_WIDHT320, DEVICEWIDTH, 35*RATIO_WIDHT320)];
        _vNewBg.backgroundColor = [UIColor whiteColor];
        [_vNewBg addSubview:self.lbNewPwd];
        [_vNewBg addSubview:self.btnCheckCode];
        [_vNewBg addSubview:self.tfCheckCode];
        [_vNewBg addSubview:self.vLineTwo];
    }
    return _vNewBg;
}

- (UILabel*)lbNewPwd{
    if(!_lbNewPwd){
        _lbNewPwd = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, 0, 100*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _lbNewPwd.text = @"验证码";
        _lbNewPwd.textColor = RGB3(0);
        _lbNewPwd.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
    }
    return _lbNewPwd;
}

- (UITextField*)tfCheckCode{
    if(!_tfCheckCode){
        _tfCheckCode = [[UITextField alloc]initWithFrame:CGRectMake(self.lbNewPwd.right, 0, DEVICEWIDTH - self.lbNewPwd.right - 10*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _tfCheckCode.placeholder = @"验证码";
        _tfCheckCode.textColor = RGB3(0);
        _tfCheckCode.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _tfCheckCode.delegate = self;
        CGRect r = _tfCheckCode.frame;
        r.size.width = self.btnCheckCode.left - 10*RATIO_WIDHT320 - r.origin.x;
        _tfCheckCode.frame = r;
    }
    return _tfCheckCode;
}

- (UIView*)vLineTwo{
    if(!_vLineTwo){
        _vLineTwo = [[UIView alloc]initWithFrame:CGRectMake(0, self.vOldBg.height - 0.5, DEVICEWIDTH, 0.5)];
        _vLineTwo.backgroundColor = RGB3(230);
    }
    return _vLineTwo;
}

- (UIButton*)btnCheckCode{
    if(!_btnCheckCode){
        _btnCheckCode = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 35*RATIO_WIDHT320)];
        [_btnCheckCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_btnCheckCode setTitleColor:APP_COLOR forState:UIControlStateNormal];
        _btnCheckCode.titleLabel.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        [_btnCheckCode addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnCheckCode.tag = 100;
        _btnCheckCode.titleLabel.textAlignment = NSTextAlignmentRight;
        CGSize size = [_btnCheckCode.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, 14*RATIO_WIDHT320)];
        CGRect r = _btnCheckCode.frame;
        r.size.width = size.width+10;
        r.origin.x = DEVICEWIDTH - r.size.width - 10*RATIO_WIDHT320;
        _btnCheckCode.frame = r;
        _btnCheckCode.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _btnCheckCode;
}



- (UIButton*)btnNext{
    if(!_btnNext){
        _btnNext = [[UIButton alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, self.vNewBg.bottom + 20*RATIO_WIDHT320, DEVICEWIDTH - 20*RATIO_WIDHT320, 45*RATIO_WIDHT320)];
        _btnNext.backgroundColor = APP_COLOR;//RGB3(213)
        [_btnNext setTitle:@"下一步" forState:UIControlStateNormal];
        [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnNext.titleLabel.font = [UIFont systemFontOfSize:17*RATIO_WIDHT320];
        _btnNext.layer.cornerRadius = 4.5f;
        [_btnNext addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnNext.tag = 101;
    }
    return _btnNext;
}



@end


