//
//  Utils.m
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (void)saveUserInfo:(NSDictionary*)dic{
    //存信息到沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    [defaults setObject:data forKey:USER_DEFAULTS];
    [defaults synchronize];
}


+ (NSData*)getUserInfo{
    //存信息到沙盒
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:USER_DEFAULTS];
}

+ (void)removeUserInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USER_DEFAULTS];
    [defaults synchronize];
}


/**
 改变label文字中某段文字的颜色，大小
 label 传入label（传入前要有文字）
 oneW  从第一个文字开始
 twoW  到最后一个文字结束
 color 颜色
 size 尺寸
 */
+(void)LabelAttributedString:(UILabel*)label firstW:(NSString *)oneW toSecondW:(NSString *)twoW color:(UIColor *)color size:(CGFloat)size{
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStr string] rangeOfString:oneW].location;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStr string] rangeOfString:twoW].location+1;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    // 改变颜色
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:range];
    // 改变字体大小及类型
    [noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:size] range:range];
    // 为label添加Attributed
    [label setAttributedText:noteStr];
}

+(void)showToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    [hud show:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    });
}


+(void)showToast:(NSString*)text mode:(MBProgressHUDMode)mode with:(UIView*)view withTime:(CGFloat)time{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = mode;
    hud.labelText = text;
    [hud show:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    });
}

+(void)showSuccessToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check-mark"]];
    img.frame = CGRectMake(5, 0, 20, 20);
    [v addSubview:img];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = v;
     hud.detailsLabelText = text;
    [hud show:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // Do something...
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    });
}

+(void)showSuccessToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time withBlock:(void(^)(void))callback{
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check-mark"]];
    img.frame = CGRectMake(5, 0, 20, 20);
    [v addSubview:img];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = v;
    hud.detailsLabelText = text;
    [hud show:YES];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(callback){
            callback();
        }
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    });
}

+(void)showHanding:(NSString*)text with:(UIView*)view{
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    [hud show:YES];
}

+(void)hiddenHanding:(UIView*)view withTime:(CGFloat)time{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, time * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideAllHUDsForView:view animated:YES];
    });
}


+(NSString *)dictToJsonStr:(NSDictionary *)dict{
    NSString *jsonString = nil;
    
    if([NSJSONSerialization isValidJSONObject:dict])
        
    {
        
        NSError *error;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        
        jsonString =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        //NSLog(@"json data:%@",jsonString);
        
        if(error) {
            
            NSLog(@"Error:%@", error);
            
        }
        
    }
    
    return jsonString;
}

+(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
    
}
@end
