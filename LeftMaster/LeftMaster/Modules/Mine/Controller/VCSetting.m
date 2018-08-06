//
//  VCSetting.m
//  LeftMaster
//
//  Created by simple on 2018/4/22.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCSetting.h"
#import "CellSetting.h"
#import "ViewWithExit.h"
#import "VCLogin.h"
#import "AppDelegate.h"
#import "VCSetPassword.h"

@interface VCSetting ()<UITableViewDelegate,UITableViewDataSource,CommonDelegate>
@property(nonatomic,strong)UITableView *table;
@property(nonatomic,strong)ViewWithExit *footer;
@end

@implementation VCSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMain];
}

- (void)initMain{
    self.title = @"设置";
    [self.view addSubview:self.table];
}

- (BOOL)isAllowedNotification {
    if (ISiOS8Above) {// system is iOS8
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        if (UIUserNotificationTypeNone != setting.types) {
            return YES;
        }
    } else if (ISiOS7Above){
        
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        if(UIRemoteNotificationTypeNone != type)
            return YES;
    }
    return NO;
}

- (void)exitAction{
    [Utils showHanding:@"退出中..." with:self.view];
    __weak typeof(self) weakself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [Utils hiddenHanding:weakself.view withTime:0.1];
        [Utils removeUserInfo];
        VCLogin *vc = [[VCLogin alloc]init];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate restoreRootViewController:[[UINavigationController alloc] initWithRootViewController:vc]];
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CellSetting calHeight];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*identifier = @"CellSetting";
    CellSetting *cell = (CellSetting*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CellSetting alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if(indexPath.section == 0){
        cell.type = 2;
        NSString *text = @"已关闭";
        if ([self isAllowedNotification]) {
            text = @"已开启";
        }
        [cell updateData:@"推送" with:text];
    }else{
        cell.type = 1;
        [cell updateData:@"修改密码" with:@""];
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
//    UIView *footer = (UIView*)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Footer"];
//    if (!footer) {
//        footer = [[UIView alloc]init];
//    }
//    return footer;
    if(section == 0){
        UIView *v = [[UIView alloc] init];
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(12*RATIO_WIDHT320, 0, DEVICEWIDTH-24, 28*RATIO_WIDHT320)];
        lb.textColor = RGB3(153);
        lb.font = FONT(10*RATIO_WIDHT320);
        if (section == 0)
        {
            lb.text = @"请在“设置”－“通知”中进行修改";
        }
        [v addSubview:lb];
        return v;
    }else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        VCSetPassword *vc = [[VCSetPassword alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - CommonDelete
- (void)clickActionWithIndex:(NSInteger)index{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"确定退出？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self exitAction];
    }
}

- (UITableView*)table{
    if(!_table){
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, DEVICEHEIGHT) style:UITableViewStyleGrouped];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = APP_Gray_COLOR;
        _table.tableFooterView = self.footer;
        _table.contentInset = UIEdgeInsetsMake(15*RATIO_WIDHT320, 0, 0, 0);
    }
    return _table;
}


- (ViewWithExit*)footer{
    if(!_footer){
        _footer = [[ViewWithExit alloc]initWithFrame:CGRectMake(0, 0, DEVICEWIDTH, [ViewWithExit calHeight])];
        _footer.delegate = self;
    }
    return _footer;
}



@end
