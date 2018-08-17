//
//  VCSetPassword.m
//  LeftMaster
//
//  Created by simple on 2018/4/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCUserAccount.h"
#import "ViewInputText.h"
#import "NetManager.h"
#import "RequestBeanRegisterAccount.h"

@interface VCUserAccount ()<UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScroll;
@property(nonatomic,strong)ViewInputText *vName;
@property(nonatomic,strong)ViewInputText *vIdCard;
@property(nonatomic,strong)ViewInputText *vBankCard;
@property(nonatomic,strong)ViewInputText *vPhone;
@property(nonatomic,strong)ViewInputText *vCode;
@property(nonatomic,strong)UIButton *btnNext;
@property (nonatomic, strong) dispatch_source_t _timer;
@property (nonatomic, assign) BOOL isExecuting;
@property (nonatomic, strong) NSString *random;
@end

@implementation VCUserAccount

- (void)dealloc{
}

- (void)viewDidDisappear:(BOOL)animated{
    if(self._timer){
        dispatch_source_cancel(self._timer);
    }
    self._timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"个人帐户";
    [self.view addSubview:self.mainScroll];
}


- (UIScrollView*)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        _mainScroll.alwaysBounceVertical = YES;
        _mainScroll.backgroundColor = APP_Gray_COLOR;
        [_mainScroll addSubview:self.vName];
        [_mainScroll addSubview:self.vIdCard];
        [_mainScroll addSubview:self.vBankCard];
        [_mainScroll addSubview:self.vPhone];
        [_mainScroll addSubview:self.vCode];
        
        [_mainScroll addSubview:self.btnNext];
        
        UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture)];
        sigleTapRecognizer.numberOfTapsRequired = 1;
        [_mainScroll addGestureRecognizer:sigleTapRecognizer];
        
        _mainScroll.delegate = self;
    }
    return _mainScroll;
    
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

- (void)clickAction:(UIButton*)sender{
    if(sender.tag == 100){
//        [self sendSmsEvent];
    }else if(sender.tag == 101){
        NSDictionary *param = @{@"name":@"luowei",@"abc":@"1232",@"abcd":@"中国"};
        [[NetManager sharedInstance] requestPost:@"" withParams:param successBlock:^(id resobject) {
            
        } failurBlock:^(NSError *error) {
            
        }];
        
//        NSString *code = [self.tfCheckCode.text trim];
//        if(code.length == 0){
//            [Utils showToast:@"请输入验证码" with:self.view withTime:0.8];
//        }else if([code isEqualToString:self.random]){
//            VCForgotPwdFinish *vc = [[VCForgotPwdFinish alloc]init];
//            vc.phone = self.tfPhone.text;
//            [self.navigationController pushViewController:vc animated:YES];
//        }else{
//            [Utils showToast:@"验证码错误" with:self.view withTime:0.8];
//        }
    }
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


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // 回收键盘
    [textField resignFirstResponder];
    return YES;
}


- (void)handleTapGesture{
    [self.view endEditing:YES];
}

- (ViewInputText*)vName{
    if(!_vName){
        _vName = [[ViewInputText alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewInputText calHeight])];
        _vName.lbName.text = @"姓名";
        _vName.tfText.placeholder = @"请输入姓名";
        _vName.tfText.delegate = self;
        _vName.type = 1;
        [_vName updateData];
    }
    return _vName;
}

- (ViewInputText*)vIdCard{
    if(!_vIdCard){
        _vIdCard = [[ViewInputText alloc]initWithFrame:CGRectMake(0, self.vName.bottom, DEVICEWIDTH, [ViewInputText calHeight])];
        _vIdCard.lbName.text = @"身份证号";
        _vIdCard.tfText.placeholder = @"请输入身份证号码";
        _vIdCard.tfText.delegate = self;
        
        _vIdCard.type = 1;
        [_vIdCard updateData];
    }
    return _vIdCard;
}

- (ViewInputText*)vBankCard{
    if(!_vBankCard){
        _vBankCard = [[ViewInputText alloc]initWithFrame:CGRectMake(0, self.vIdCard.bottom, DEVICEWIDTH, [ViewInputText calHeight])];
        _vBankCard.lbName.text = @"银行卡号";
        _vBankCard.tfText.placeholder = @"请输入银行卡号";
        _vBankCard.tfText.delegate = self;
        _vBankCard.type = 1;
        [_vBankCard updateData];
    }
    return _vBankCard;
}

- (ViewInputText*)vPhone{
    if(!_vPhone){
        _vPhone = [[ViewInputText alloc]initWithFrame:CGRectMake(0, self.vBankCard.bottom, DEVICEWIDTH, [ViewInputText calHeight])];
        _vPhone.lbName.text = @"预留手机号";
        _vPhone.tfText.placeholder = @"请输入身份证号码";
        _vPhone.tfText.delegate = self;
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


- (UIButton*)btnNext{
    if(!_btnNext){
        _btnNext = [[UIButton alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, self.vCode.bottom + 50*RATIO_WIDHT320, DEVICEWIDTH - 20*RATIO_WIDHT320, 45*RATIO_WIDHT320)];
        _btnNext.backgroundColor = APP_COLOR;//RGB3(213)
        [_btnNext setTitle:@"确定开户" forState:UIControlStateNormal];
        [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnNext.titleLabel.font = [UIFont systemFontOfSize:17*RATIO_WIDHT320];
        _btnNext.layer.cornerRadius = 4.5f;
        [_btnNext addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        _btnNext.tag = 101;
    }
    return _btnNext;
}



@end


