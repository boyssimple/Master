//
//  VCSetting.m
//  LeftMaster
//
//  Created by simple on 2018/4/22.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCUserInfo.h"
#import "CellUserInfo.h"

@interface VCUserInfo ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,CommonDelegate,UIActionSheetDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)UIImagePickerController *pickerController;
@end

@implementation VCUserInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"个人信息";
    [self.view addSubview:self.table];
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
        [cell updateData:@"头像" with:@"" hiddenArrow:FALSE withType:1];
    }else if(indexPath.row == 1){
        [cell updateData:@"姓名" with:@"张大福" hiddenArrow:FALSE withType:2];
    }else if(indexPath.row == 2){
        [cell updateData:@"手机" with:@"15523935895" hiddenArrow:FALSE withType:2];
    }else if(indexPath.row == 3){
        [cell updateData:@"公司" with:@"河南正威科技有限公司" hiddenArrow:TRUE withType:2];
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
    }
}


- (void)showMethod{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"照片", nil];
    // 显示
    action.tag = 101;
    [action showInView:self.view];
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
    //    [selfupDateHeadIcon:userImage];
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
        _pickerController.allowsEditing = YES;
    }
    return _pickerController;
}


@end
