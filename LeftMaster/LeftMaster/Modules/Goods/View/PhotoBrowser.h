//
//  PhotoBrowser.h
//  LeftMaster
//
//  Created by simple on 2018/5/15.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol PhotoBrowserDelegate;
static UIWindow *photoWindow = nil;
@interface PhotoBrowser : UIWindow
@property(nonatomic,weak)id<PhotoBrowserDelegate> delegate;
- (id)init:(NSString*)url;
- (void)show;
- (void)dismiss;
@end

@protocol PhotoBrowserDelegate<NSObject>
- (void)selectReason:(NSString*)reason;
@end
