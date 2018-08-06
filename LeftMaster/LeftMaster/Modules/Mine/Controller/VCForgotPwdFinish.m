//
//  VCSetPassword.m
//  LeftMaster
//
//  Created by simple on 2018/4/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCForgotPwdFinish.h"
#import "RequestBeanModifyPwd.h"

@interface VCForgotPwdFinish ()<UIScrollViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScroll;
@property(nonatomic,strong)UIView *vNewBg;
@property(nonatomic,strong)UIView *vConfirmBg;


@property(nonatomic,strong)UILabel *lbNewPwd;
@property(nonatomic,strong)UITextField *tfNewPwd;
@property(nonatomic,strong)UIView *vLineTwo;

@property(nonatomic,strong)UILabel *lbConfirmPwd;
@property(nonatomic,strong)UITextField *tfConfirmPwd;
@property(nonatomic,strong)UIView *vLineThree;

@property(nonatomic,strong)UIButton *btnNext;
@end

@implementation VCForgotPwdFinish

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"设置密码";
    [self.view addSubview:self.mainScroll];
}


- (void)clickAction:(UIButton*)sender{
    [self.view endEditing:YES];
    NSString *newPwd = [self.tfNewPwd.text trim];
    NSString *confirmPwd = [self.tfConfirmPwd.text trim];
    
    if(newPwd.length == 0){
        [Utils showToast:@"请输入新密码" with:self.view withTime:0.8];
        return;
    }
    if(newPwd.length < 6){
        [Utils showToast:@"密码不能少于6位" with:self.view withTime:0.8];
        return;
    }
    if(confirmPwd.length == 0){
        [Utils showToast:@"请输入确认密码" with:self.view withTime:0.8];
        return;
    }
    if(![confirmPwd isEqualToString:newPwd]){
        [Utils showToast:@"确认密码错误" with:self.view withTime:0.8];
        return;
    }
    
    RequestBeanModifyPwd *requestBean = [RequestBeanModifyPwd new];
    requestBean.MOBILE = self.phone;
    requestBean.NEW_PASSWORD = newPwd;
    requestBean.TYPE = 2;
    requestBean.CONFIRM_PASSWORD = confirmPwd;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        ResponseBeanModifyPwd *response = responseBean;
        if(!err){
            // 结果处理
            if(response.success){
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:MISS_PASSWORD_COUNT];
                [userDefaults synchronize];
                [Utils hiddenHanding:self.view withTime:0.5];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"密码设置成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                [Utils showToast:response.msg with:self.view withTime:0.8];
            }
        }else{
            [Utils showSuccessToast:@"设置失败" with:weakself.view withTime:1];
        }
        
    }];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (UIScrollView*)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        _mainScroll.alwaysBounceVertical = YES;
        _mainScroll.backgroundColor = APP_Gray_COLOR;
        [_mainScroll addSubview:self.vNewBg];
        [_mainScroll addSubview:self.vConfirmBg];
        [_mainScroll addSubview:self.btnNext];
        _mainScroll.delegate = self;
    }
    return _mainScroll;
}



- (UIView*)vNewBg{
    if(!_vNewBg){
        _vNewBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 15*RATIO_WIDHT320, DEVICEWIDTH, 35*RATIO_WIDHT320)];
        _vNewBg.backgroundColor = [UIColor whiteColor];
        [_vNewBg addSubview:self.lbNewPwd];
        [_vNewBg addSubview:self.tfNewPwd];
        [_vNewBg addSubview:self.vLineTwo];
    }
    return _vNewBg;
}

- (UILabel*)lbNewPwd{
    if(!_lbNewPwd){
        _lbNewPwd = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, 0, 100*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _lbNewPwd.text = @"输入新密码";
        _lbNewPwd.textColor = RGB3(0);
        _lbNewPwd.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
    }
    return _lbNewPwd;
}

- (UITextField*)tfNewPwd{
    if(!_tfNewPwd){
        _tfNewPwd = [[UITextField alloc]initWithFrame:CGRectMake(self.lbNewPwd.right, 0, DEVICEWIDTH - self.lbNewPwd.right - 10*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _tfNewPwd.placeholder = @"输入新密码";
        _tfNewPwd.textColor = RGB3(153);
        _tfNewPwd.secureTextEntry = YES;
        _tfNewPwd.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
    }
    return _tfNewPwd;
}

- (UIView*)vLineTwo{
    if(!_vLineTwo){
        _vLineTwo = [[UIView alloc]initWithFrame:CGRectMake(0, self.vNewBg.height - 0.5, DEVICEWIDTH, 0.5)];
        _vLineTwo.backgroundColor = RGB3(230);
    }
    return _vLineTwo;
}

- (UIView*)vConfirmBg{
    if(!_vConfirmBg){
        _vConfirmBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.vNewBg.bottom+10*RATIO_WIDHT320, DEVICEWIDTH, 35*RATIO_WIDHT320)];
        _vConfirmBg.backgroundColor = [UIColor whiteColor];
        [_vConfirmBg addSubview:self.lbConfirmPwd];
        [_vConfirmBg addSubview:self.tfConfirmPwd];
        [_vConfirmBg addSubview:self.vLineThree];
    }
    return _vConfirmBg;
}

- (UILabel*)lbConfirmPwd{
    if(!_lbConfirmPwd){
        _lbConfirmPwd = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, 0, 100*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _lbConfirmPwd.text = @"输入确认密码";
        _lbConfirmPwd.textColor = RGB3(0);
        _lbConfirmPwd.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
    }
    return _lbConfirmPwd;
}

- (UITextField*)tfConfirmPwd{
    if(!_tfConfirmPwd){
        _tfConfirmPwd = [[UITextField alloc]initWithFrame:CGRectMake(self.lbConfirmPwd.right, 0, DEVICEWIDTH - self.lbConfirmPwd.right - 10*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _tfConfirmPwd.placeholder = @"输入确认密码";
        _tfConfirmPwd.textColor = RGB3(153);
        _tfConfirmPwd.secureTextEntry = YES;
        _tfConfirmPwd.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
    }
    return _tfConfirmPwd;
}

- (UIView*)vLineThree{
    if(!_vLineThree){
        _vLineThree = [[UIView alloc]initWithFrame:CGRectMake(0, self.vConfirmBg.height - 0.5, DEVICEWIDTH, 0.5)];
        _vLineThree.backgroundColor = RGB3(230);
    }
    return _vLineThree;
}

- (UIButton*)btnNext{
    if(!_btnNext){
        _btnNext = [[UIButton alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, self.vConfirmBg.bottom + 20*RATIO_WIDHT320, DEVICEWIDTH - 20*RATIO_WIDHT320, 45*RATIO_WIDHT320)];
        _btnNext.backgroundColor = APP_COLOR;//RGB3(213)
        [_btnNext setTitle:@"完成" forState:UIControlStateNormal];
        [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnNext.titleLabel.font = [UIFont systemFontOfSize:17*RATIO_WIDHT320];
        _btnNext.layer.cornerRadius = 4.5f;
        [_btnNext addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnNext;
}



@end

