//
//  LaunchAdsManager.h
//  LeftMaster
//
//  Created by simple on 2018/8/6.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaunchAdsManager : NSObject
+(LaunchAdsManager *)shareManager;
- (void)setupLaunchAd:(void(^)(void))calculateBlock;
- (void)existsUpdate;
@end
