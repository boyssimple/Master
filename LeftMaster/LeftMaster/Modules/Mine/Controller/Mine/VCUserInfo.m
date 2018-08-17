//
//  VCSetting.m
//  LeftMaster
//
//  Created by simple on 2018/4/22.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCUserInfo.h"
#import "CellUserInfo.h"
#import "RequestBeanUploadImg.h"
#import "RequestBeanModifyUserInfo.h"
#import "FileUpload.h"
#import "RequestBeanGetUserInfo.h"

@interface VCUserInfo ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,CommonDelegate,UIActionSheetDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIImagePickerController *pickerController;
@property(nonatomic,strong)NSDictionary *data;
@property(nonatomic,strong)NSDictionary *updataResult;
@end

@implementation VCUserInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
    [self loadData];
}

- (void)initMain{
    self.title = @"个人信息";
    [self.view addSubview:self.table];
}



- (void)uploadImg:(UIImage *)img{
    __weak typeof(self) weakself = self;
    [Utils showHanding:@"上传中..." with:self.view];
    NSDictionary *param = @{@"SYSUSER_ID":[AppUser share].SYSUSER_ID};
    [[FileUpload sharedInstance] upload:net_userPhotoUpload withParam:param withImg:img successBlock:^(id resobject) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if(resobject){
            BOOL success = [resobject jk_boolForKey:@"success"];
            if(success){
                self.updataResult = resobject;
                [Utils showToast:@"修改成功" with:weakself.view withTime:2];
                [weakself loadData];
            }else{
                [Utils showToast:@"上传失败" with:weakself.view withTime:1.5];
            }
        }
    } failurBlock:^(NSError *error) {
        [Utils showToast:@"网络错误" with:weakself.view withTime:1.5];
        
    } withVC:self];
}

- (void)loadData{
    
    RequestBeanGetUserInfo *requestBean = [RequestBeanGetUserInfo new];
    requestBean.SYSUSER_ID = [AppUser share].SYSUSER_ID;
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        if (!err) {
            // 结果处理
            ResponseBeanGetUserInfo *response = responseBean;
            if(response.success){
                weakself.data = response.data;
                [weakself.table reloadData];
            }else{
                
            }
        }
    }];
}


- (void)modify:(NSString*)name{
    
    RequestBeanModifyUserInfo *requestBean = [RequestBeanModifyUserInfo new];
    requestBean.SYSUSER_ID = [AppUser share].SYSUSER_ID;
    requestBean.SYSUSER_NAME = name;
    if(self.data){
        requestBean.SYSUSER_MOBILE = [self.data jk_stringForKey:@"SYSUSER_MOBILE"];
    }
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanModifyUserInfo *response = responseBean;
            if(response.success){
                [weakself loadData];
                [Utils showToast:@"修改成功" with:weakself.view withTime:2];
            }else{
                [Utils showToast:response.msg with:weakself.view withTime:2];
            }
        }
    }];
}



- (void)modifyPhone:(NSString*)phone{
    
    RequestBeanModifyUserInfo *requestBean = [RequestBeanModifyUserInfo new];
    requestBean.SYSUSER_ID = [AppUser share].SYSUSER_ID;
    requestBean.SYSUSER_MOBILE = phone;
    
    if(self.data){
        requestBean.SYSUSER_NAME = [self.data jk_stringForKey:@"SYSUSER_NAME"];
    }
    [Utils showHanding:requestBean.hubTips with:self.view];
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        [Utils hiddenHanding:self.view withTime:0.5];
        [weakself.table.mj_header endRefreshing];
        if (!err) {
            // 结果处理
            ResponseBeanModifyUserInfo *response = responseBean;
            if(response.success){
                [weakself loadData];
                [Utils showToast:@"修改成功" with:weakself.view withTime:2];
            }else{
                [Utils showToast:response.msg with:weakself.view withTime:2];
            }
        }
    }];
}

- (void)showModifyAvatar{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"修改头像" otherButtonTitles:nil, nil];
    // 显示
    action.tag = 100;
    [action showInView:self.view];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"%@",picker);
    [self.pickerController dismissViewControllerAnimated:TRUE completion:^{
        
    }];
}

//跳转到imagePicker里
- (void)makePhoto
{
    self.pickerController.sourceType =UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:self.pickerController animated:YES completion:nil];
}
//跳转到相册
- (void)choosePicture
{
    self.pickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:self.pickerController animated:TRUE completion:nil];
}
//跳转图库
- (void)pictureLibrary
{
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.pickerController animated:TRUE completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return [CellUserInfo calHeightTWo];
    }
    return [CellUserInfo calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellUserInfo";
    CellUserInfo *cell = (CellUserInfo*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellUserInfo alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.row == 0){
        if(self.data){
            NSDictionary *user_photo  = [self.data jk_dictionaryForKey:@"USER_PHOTO_JSON"];
            if(user_photo){
                NSString *url = [user_photo jk_stringForKey:@"getfileurl"];
                if(url){
                    
                    [cell updateData:@"头像" with:@"" hiddenArrow:FALSE withType:1];
                    [cell.ivAvatar pt_setImage:url];
                }
            }
        }else{
            
            [cell updateData:@"头像" with:@"" hiddenArrow:FALSE withType:1];
        }
    }else if(indexPath.row == 1){
        if(self.data){
            [cell updateData:@"姓名" with:[self.data jk_stringForKey:@"SYSUSER_NAME"] hiddenArrow:FALSE withType:2];
        }else{
            [cell updateData:@"姓名" with:@"" hiddenArrow:FALSE withType:2];
        }
    }else if(indexPath.row == 2){
        if(self.data){
            [cell updateData:@"手机" with:[self.data jk_stringForKey:@"SYSUSER_MOBILE"] hiddenArrow:FALSE withType:2];
        }else{
            [cell updateData:@"手机" with:@"" hiddenArrow:FALSE withType:2];
        }
    }else if(indexPath.row == 3){
        [cell updateData:@"公司" with:[AppUser share].COMPANY_NAME hiddenArrow:TRUE withType:2];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.00001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0){
        return 28*RATIO_WIDHT320;
    }
    return 0.00001f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Header"];
    if (!header) {
        header = [[UIView alloc]init];
    }
    return header;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footer = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
    if (!footer) {
        footer = [[UIView alloc]init];
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        [self showModifyAvatar];
    }else if(indexPath.row == 1){
        NSString *name;
        if(self.data){
            name = [self.data jk_stringForKey:@"SYSUSER_NAME"];
        }else{
            name = @"";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改姓名" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *txtName = [alert textFieldAtIndex:0];
        txtName.placeholder = name;
        alert.tag = 200;
        [alert show];
    }else if(indexPath.row == 2){
        NSString *phone;
        if(self.data){
            phone = [self.data jk_stringForKey:@"SYSUSER_MOBILE"];
        }else{
            phone = @"";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"修改手机号" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        UITextField *txtName = [alert textFieldAtIndex:0];
        txtName.placeholder = phone;
        alert.tag = 201;
        [alert show];
        
    }
}


- (void)showMethod{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"照片", nil];
    // 显示
    action.tag = 101;
    [action showInView:self.view];
}
#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 200){
        if(buttonIndex == 1){
            UITextField *txt = [alertView textFieldAtIndex:0];
            [self modify:[txt.text trim]];
        }
    }else if(alertView.tag == 201){
        if(buttonIndex == 1){
            UITextField *txt = [alertView textFieldAtIndex:0];
            [self modifyPhone:[txt.text trim]];
        }
    }
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 100) {
        if (buttonIndex == 0) {
            [self showMethod];
        }
    }else{
        if (buttonIndex == 0) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                NSLog(@"支持相机");
                [self makePhoto];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请在设置-->隐私-->相机，中开启本应用的相机访问权限！！" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"我知道了",nil];
                [alert show];
            }
        }else if(buttonIndex == 1){
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                NSLog(@"支持相册");
                [self choosePicture];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请在设置-->隐私-->照片，中开启本应用的相机访问权限！！" delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"我知道了",nil];
                [alert show];
            }
        }
    }
}


//用户选中图片之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"%s,info == %@",__func__,info);
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    [self.header setImage:image];
    [self.pickerController dismissViewControllerAnimated:TRUE completion:nil];
    
    //    [self.headIconsetImage:userImage];
    //    self.headIcon.contentMode = UIViewContentModeScaleAspectFill;
    //    self.headIcon.clipsToBounds =YES;
    //照片上传
        [self uploadImg:image];
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = APP_Gray_COLOR;
    }
    return _table;
}



- (UIImagePickerController *)pickerController{
    if (!_pickerController) {
        _pickerController = [[UIImagePickerController alloc]init];
        _pickerController.view.backgroundColor = [UIColor orangeColor];
        _pickerController.delegate = self;
        _pickerController.allowsEditing = NO;
    }
    return _pickerController;
}


@end
