//
//  UITypes+extension.h
//  School
//
//  Created by zhouMR on 2017/11/16.
//  Copyright © 2017年 luowei. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImage (extension)
+ (UIImage*)stretchImage:(NSString*)name;
+ (UIImage*)stretchAllImage:(NSString*)name;
@end

@interface NSString (extension)
- (NSString*)trim;
@end

@interface UIView (extension)
- (void)updateData;
+ (CGFloat)calHeight;
-(UINavigationController *) navigationController;
@end

@interface UIImageView (extension)
- (void)pt_setImage:(NSString*)url;
@end

@interface UITableViewCell (extension)
@end


