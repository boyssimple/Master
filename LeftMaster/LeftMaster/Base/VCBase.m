//
//  VCBase.m
//  LeftMaster
//
//  Created by simple on 2018/4/1.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCBase.h"

@interface VCBase ()

@end

@implementation VCBase

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    
    UIImage *img = [[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *img1 = [[UIImage imageNamed:@"nav_icon_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationController.navigationBar.backIndicatorImage = img;
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = img1;
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
