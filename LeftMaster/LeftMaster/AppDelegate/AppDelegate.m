//
//  AppDelegate.m
//  LeftMaster
//
//  Created by simple on 2018/3/31.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AppDelegate.h"
#import "VCMain.h"
#import "VCLogin.h"
#import "VCOrder.h"
#import "VCProxyCustmer.h"
#import "LaunchAdsManager.h"
#import "RequestBeanLogin.h"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.isLogin = FALSE;
    [[LaunchAdsManager shareManager] existsUpdate];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    AJLog(@"%@", documentsPath);
    [AJNetworkConfig shareInstance].hostUrl = Base_Url;//@"192.168.43.142:8080/";//
    //缓存设置
    /*
     AJCacheOptions *cacheOptions = [AJCacheOptions new];
     cacheOptions.cachePath = [documentsPath stringByAppendingPathComponent:@"aj_network_cache"];
     cacheOptions.openCacheGC = YES;
     cacheOptions.globalCacheExpirationSecond = 60;
     cacheOptions.globalCacheGCSecond = 2 * 60;
     [AJNetworkConfig shareInstance].cacheOptions = cacheOptions;
     */
    
    
    //获取登录信息
    NSData *data = [Utils getUserInfo];
    if(data){
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"用户：%@",dictionary);
        [[AppUser share] parse:dictionary];
        if([AppUser share].isSalesman && ![AppUser share].CUS_ID){
            VCProxyCustmer *vc = [[VCProxyCustmer alloc]init];
            self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
        }else{
            [self autoLogin];
            
            VCMain *vc = [[VCMain alloc]init];
            self.window.rootViewController = vc;
        }
        
    }else{
        VCLogin *vc = [[VCLogin alloc]init];
        self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    
    [JPUSHService setupWithOption:launchOptions appKey:appcKey
                          channel:channel
                 apsForProduction:YES
            advertisingIdentifier:nil];
    //JPush 监听登陆成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidLogin:)
                                                 name:kJPFNetworkDidLoginNotification
                                               object:nil];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)autoLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:LOGIN_USER_COUNT];
    NSString *tfPwd = [defaults objectForKey:LOGIN_USER_PASSWORD];
    RequestBeanLogin *requestBean = [RequestBeanLogin new];
    requestBean.userName = userName;
    requestBean.passWord = tfPwd;
    __weak typeof(self) weakself = self;
    [AJNetworkManager requestWithBean:requestBean callBack:^(__kindof AJResponseBeanBase * _Nullable responseBean, AJError * _Nullable err) {
        if(!err){
            // 结果处理
            ResponseBeanLogin *response = responseBean;
            if(response.success){
                //存信息到沙盒
                [Utils saveUserInfo:response.data];
                //解析数据
                [[AppUser share] parse:response.data];
                //设置推送别名
                if (weakself.isLogin) {
                    [JPUSHService setAlias:[AppUser share].SYSUSER_ACCOUNT completion:nil seq:1];
                }
            }
        }else{
            
        }
        
    }];
}

// 登陆后淡入淡出更换rootViewController
- (void)restoreRootViewController:(UIViewController *)rootViewController
{
    typedef void (^Animation)(void);
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    rootViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    Animation animation = ^{
        BOOL oldState = [UIView areAnimationsEnabled];
        [UIView setAnimationsEnabled:NO];
        [UIApplication sharedApplication].keyWindow.rootViewController = rootViewController;
        [UIView setAnimationsEnabled:oldState];
    };
    
    [UIView transitionWithView:window
                      duration:0.5f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:animation
                    completion:nil];
}

- (void)gotoOrderDetailVC:(NSString*)orderId{
    if (orderId) {
        [self postNotification:OPEN_ORDER_LIST withObject:orderId];
    }
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {

    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"注册通知成功");
    NSLog(@"帐号：%@",[AppUser share].SYSUSER_ACCOUNT);
    if ([AppUser share].SYSUSER_MOBILE && ![[AppUser share].SYSUSER_MOBILE isEqualToString:@""]) {
        [JPUSHService setAlias:[AppUser share].SYSUSER_ACCOUNT completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            NSLog(@"设置tag:%@",iAlias);
        } seq:1];
    }
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"注册通知失败: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings: (UIUserNotificationSettings *)notificationSettings {
    
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS6及以下系统，收到通知:%@", [self logDic:userInfo]);
//    [rootViewController addNotificationCount];
    NSString *orderId = [userInfo jk_stringForKey:@"orderId"];
    if (orderId) {
//        [self gotoOrderDetailVC:orderId];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
//        [rootViewController addNotificationCount];
        NSString *orderId = [userInfo jk_stringForKey:@"orderId"];
        if (orderId) {
//            [self gotoOrderDetailVC:orderId];
        }
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
//        [rootViewController addNotificationCount];
        NSString *orderId = [userInfo jk_stringForKey:@"orderId"];
        if (orderId) {
//            [self gotoOrderDetailVC:orderId];
        }
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
//        [rootViewController addNotificationCount];
        NSString *orderId = [userInfo jk_stringForKey:@"orderId"];
        if (orderId) {
            [self gotoOrderDetailVC:orderId];
        }
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


/**
 *  登录成功，设置别名，移除监听
 */
- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
    self.isLogin = TRUE;
    if ([AppUser share].SYSUSER_MOBILE && ![[AppUser share].SYSUSER_MOBILE isEqualToString:@""]) {
        [JPUSHService setAlias:[AppUser share].SYSUSER_ACCOUNT completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            NSLog(@"设置tag");
        } seq:1];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kJPFNetworkDidLoginNotification
                                                  object:nil];
    
    
    
}
@end
