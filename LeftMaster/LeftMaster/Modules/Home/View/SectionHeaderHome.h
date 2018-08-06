//
//  SectionHeaderHome.h
//  LeftMaster
//
//  Created by simple on 2018/4/2.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionHeaderHomeDelegate;

@interface SectionHeaderHome : UIView
@property (nonatomic, weak) id<SectionHeaderHomeDelegate> delegate;
@property (nonatomic, assign) NSInteger index;
- (void)setTitle:(NSString *)title witIcon:(NSString*)icon;
@end

@protocol SectionHeaderHomeDelegate<NSObject>
- (void)sectionClickShowAll:(NSInteger)index;
@end
