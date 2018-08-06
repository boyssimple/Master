//
//  VCMain.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "VCMain.h"
#import "VCProxy.h"

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
@interface VCMain ()<UITabBarControllerDelegate>

@end

@implementation VCMain

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.delegate = self;
    [self createContentPages];
}


- (void) createContentPages {
    
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"VCHome",
                                   kTitleKey  : @"首页",
                                   kImgKey    : @"tab_home_icon_normal",
                                   kSelImgKey : @"tab_home_icon_selected"},
                                 
                                 @{kClassKey  : @"VCTopGoods",
                                   kTitleKey  : @"常购商品",
                                   kImgKey    : @"tab_commodity_icon_normal",
                                   kSelImgKey : @"tab_commodity_icon_selected"},
                                 
                                 @{kClassKey  : @"VCCart",
                                   kTitleKey  : @"购物车",
                                   kImgKey    : @"tab_Shopping-Cart_icon_normal",
                                   kSelImgKey : @"tab_Shopping-Cart_icon_selected"},
                                 
                                 @{kClassKey  : @"VCMine",
                                   kTitleKey  : @"我的",
                                   kImgKey    : @"tab_me_icon_selnormal",
                                   kSelImgKey : @"tab_me_icon_selected"} ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [[UIImage imageNamed:dict[kImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//[UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//[UIImage imageNamed:dict[kSelImgKey]];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(0, 0, 0)} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : APP_COLOR} forState:UIControlStateSelected];
        
        
        [self addChildViewController:nav];
    }];
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
