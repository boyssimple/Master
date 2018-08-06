//
//  VCSetPassword.m
//  LeftMaster
//
//  Created by simple on 2018/4/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCModifyPassword.h"
#import "RequestBeanModifyPwd.h"
#import "VCLogin.h"
#import "AppDelegate.h"

@interface VCModifyPassword ()<UIAlertViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *mainScroll;
@property(nonatomic,strong)UIView *vOldBg;
@property(nonatomic,strong)UIView *vNewBg;
@property(nonatomic,strong)UIView *vConfirmBg;
@property(nonatomic,strong)UILabel *lbOldPwd;
@property(nonatomic,strong)UITextField *tfOldPwd;
@property(nonatomic,strong)UIView *vLine;

@property(nonatomic,strong)UILabel *lbNewPwd;
@property(nonatomic,strong)UITextField *tfNewPwd;
@property(nonatomic,strong)UIView *vLineTwo;

@property(nonatomic,strong)UILabel *lbConfirmPwd;
@property(nonatomic,strong)UITextField *tfConfirmPwd;
@property(nonatomic,strong)UIView *vLineThree;

@property(nonatomic,strong)UIButton *btnNext;
@end

@implementation VCModifyPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"设置密码";
    [self.view addSubview:self.mainScroll];
}

- (void)clickAction:(UIButton*)sender{
    [self modifyEvent];
}

- (void)modifyEvent{
    [self.view endEditing:YES];
    NSString *oldPwd = [self.tfOldPwd.text trim];
    NSString *newPwd = [self.tfNewPwd.text trim];
    NSString *confirmPwd = [self.tfConfirmPwd.text trim];
    if(oldPwd.length == 0 || oldPwd.length < 6){
        [Utils showToast:@"请输入原密码" with:self.view withTime:0.8];
        return;
    }
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
    requestBean.SYSUSER_ID = [AppUser share].SYSUSER_ID;
    requestBean.OLD_PASSWORD = oldPwd;
    requestBean.NEW_PASSWORD = newPwd;
    requestBean.TYPE = 1;
    requestBean.CONFIRM_PASSWORD = confirmPwd;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if(!err){
            // 结果处理
            ResponseBeanModifyPwd *response = responseBean;
            if(response.success){
                [Utils hiddenHanding:self.view withTime:0.5];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"密码修改成功" message:@"请重新登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else{
                [Utils showToast:response.msg with:self.view withTime:0.8];
            }
        }else{
            [Utils showSuccessToast:@"修改失败" with:weakself.view withTime:1];
        }
        
    }];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        VCLogin *vc = [[VCLogin alloc]init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate restoreRootViewController:[[UINavigationController alloc] initWithRootViewController:vc]];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (UIScrollView*)mainScroll{
    if(!_mainScroll){
        _mainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT)];
        _mainScroll.alwaysBounceVertical = YES;
        _mainScroll.backgroundColor = APP_Gray_COLOR;
        [_mainScroll addSubview:self.vOldBg];
        [_mainScroll addSubview:self.vNewBg];
        [_mainScroll addSubview:self.vConfirmBg];
        [_mainScroll addSubview:self.btnNext];
        _mainScroll.delegate = self;
    }
    return _mainScroll;
}

- (UIView*)vOldBg{
    if(!_vOldBg){
        _vOldBg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 15*RATIO_WIDHT320, DEVICEWIDTH, 35*RATIO_WIDHT320)];
        _vOldBg.backgroundColor = [UIColor whiteColor];
        [_vOldBg addSubview:self.lbOldPwd];
        [_vOldBg addSubview:self.tfOldPwd];
        [_vOldBg addSubview:self.vLine];
    }
    return _vOldBg;
}

- (UILabel*)lbOldPwd{
    if(!_lbOldPwd){
        _lbOldPwd = [[UILabel alloc]initWithFrame:CGRectMake(10*RATIO_WIDHT320, 0, 100*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _lbOldPwd.text = @"输入原密码";
        _lbOldPwd.textColor = RGB3(0);
        _lbOldPwd.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
    }
    return _lbOldPwd;
}

- (UITextField*)tfOldPwd{
    if(!_tfOldPwd){
        _tfOldPwd = [[UITextField alloc]initWithFrame:CGRectMake(self.lbOldPwd.right, 0, DEVICEWIDTH - self.lbOldPwd.right - 10*RATIO_WIDHT320, 35*RATIO_WIDHT320)];
        _tfOldPwd.placeholder = @"输入原密码";
        _tfOldPwd.textColor = RGB3(153);
        _tfOldPwd.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _tfOldPwd.delegate = self;
    }
    return _tfOldPwd;
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
        _tfNewPwd.delegate = self;
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
        _tfConfirmPwd.delegate = self;
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
        [_btnNext setTitle:@"确定" forState:UIControlStateNormal];
        [_btnNext setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnNext.titleLabel.font = [UIFont systemFontOfSize:17*RATIO_WIDHT320];
        _btnNext.layer.cornerRadius = 4.5f;
        [_btnNext addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnNext;
}



@end
