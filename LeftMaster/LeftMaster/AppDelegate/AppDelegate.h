//
//  AppDelegate.h
//  LeftMaster
//
//  Created by simple on 2018/3/31.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *appcKey = @"396c1c7e98ab4608aab01e0a";
static NSString *channel = @"Publish channel";

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property(nonatomic,assign)BOOL isLogin;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSString *billNo;
@property(nonatomic,strong)NSString *month;


- (void)restoreRootViewController:(UIViewController *)rootViewController;
@end

