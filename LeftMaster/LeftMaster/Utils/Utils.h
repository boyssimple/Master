//
//  Utils.h
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (void)saveUserInfo:(NSDictionary*)dic;

+ (NSData*)getUserInfo;

+ (void)removeUserInfo;


+(void)LabelAttributedString:(UILabel*)label firstW:(NSString *)oneW toSecondW:(NSString *)twoW color:(UIColor *)color size:(CGFloat)size;

+(void)showToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time;

+(void)showToast:(NSString*)text mode:(MBProgressHUDMode)mode with:(UIView*)view withTime:(CGFloat)time;

+(void)showSuccessToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time;

+(void)showSuccessToast:(NSString*)text with:(UIView*)view withTime:(CGFloat)time withBlock:(void(^)(void))callback;

//处理提示
+(void)showHanding:(NSString*)text with:(UIView*)view;
+(void)hiddenHanding:(UIView*)view withTime:(CGFloat)time;

/**
 * 把字典转成json串
 */
+(NSString *)dictToJsonStr:(NSDictionary *)dict;

+(NSString *)convertToJsonData:(NSDictionary *)dict;
@end
