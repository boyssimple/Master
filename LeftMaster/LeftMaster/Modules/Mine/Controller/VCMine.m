//
//  VCMine.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCMine.h"
#import "ViewHeaderMine.h"
#import "CellMine.h"
#import "VCNotice.h"
#import "VCOrderCheckAccount.h"
#import "ViewWithExit.h"
#import "VCSetting.h"
#import "RequestBeanOrderNum.h"
#import "VCProxyCustmer.h"
#import "VCAccountContainer.h"

@interface VCMine ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,CommonDelegate,UIActionSheetDelegate,
            UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewHeaderMine *header;
@property(nonatomic,strong)ViewWithExit *footer;
@property(nonatomic,strong)UIImagePickerController *pickerController;
@end

@implementation VCMine

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    [self.view addSubview:self.table];
    [self observeNotification:REFRESH_MINE_INFO];
}

- (void)loadData{
    [self loadOrderNum];
    [self.header updateData];
    [self.table reloadData];
    int64_t delayInSeconds = 0.6;
    __weak typeof(self) weakself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakself.table.mj_header endRefreshing];
    });
}

- (void)handleNotification:(NSNotification *)notification{
    [self loadData];
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

- (void)viewWillAppear:(BOOL)animated{
    [self loadOrderNum];
}

- (void)loadOrderNum{
    [self loadData:0];
    [self loadData:1];
    [self loadData:2];
    [self loadData:3];
}

- (void)loadData:(NSInteger)type{
    RequestBeanOrderNum *requestBean = [RequestBeanOrderNum new];
    requestBean.order_status = type;
    requestBean.user_id = [AppUser share].SYSUSER_ID;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if (!err) {
            // 结果处理
            ResponseBeanOrderNum *response = responseBean;
            if(response.success){
                [weakself.header updateData:type withCount:response.num];
            }
        }
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([AppUser share].isSalesman){
        return 5;
    }else{
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellMine calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellMine";
    CellMine *cell = (CellMine*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellMine alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.row == 0){
        [cell updateData:@"通知消息" with:@""];
    }else if(indexPath.row == 1){
        [cell updateData:@"订单对账" with:@""];
    }else if(indexPath.row == 2){
        [cell updateData:@"联系客服" with:@"400-1696444"];
    }
    
    if([AppUser share].isSalesman){
        if(indexPath.row == 3){
            [cell updateData:@"当前客户" with:[AppUser share].CUS_NAME];
        }else if(indexPath.row == 4){
            [cell updateData:@"设置" with:@""];
        }
    }else{
        if(indexPath.row == 3){
            [cell updateData:@"设置" with:@""];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
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
        VCNotice *vc = [[VCNotice alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 1){
        VCAccountContainer *vc = [[VCAccountContainer alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 2){
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"400-1696444"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }else{
        if([AppUser share].isSalesman){
            if(indexPath.row == 3){
                VCProxyCustmer*vc = [[VCProxyCustmer alloc]init];
                vc.type = 1;
                vc.hidesBottomBarWhenPushed = TRUE;
                [self.navigationController pushViewController:vc animated:TRUE];
            }else if(indexPath.row == 4){
                VCSetting *vc = [[VCSetting alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            if(indexPath.row == 3){
                VCSetting *vc = [[VCSetting alloc]init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
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

#pragma mark - CommonDelegate
- (void)clickActionWithIndex:(NSInteger)index{
    if (index == 0) {
        [self showModifyAvatar];
    }
}

//用户选中图片之后的回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"%s,info == %@",__func__,info);
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.header setImage:image];
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
        _table.backgroundColor = [UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = APP_Gray_COLOR;
        _table.tableHeaderView = self.header;
        __weak typeof(self) weakself = self;
        
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakself loadData];
        }];
    }
    return _table;
}


- (ViewHeaderMine*)header{
    if(!_header){
        _header = [[ViewHeaderMine alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewHeaderMine calHeight])];
        _header.delegate = self;
        [_header updateData];
    }
    return _header;
}


- (void)showModifyAvatar{
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"修改头像" otherButtonTitles:nil, nil];
    // 显示
    action.tag = 100;
    [action showInView:self.view];
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
