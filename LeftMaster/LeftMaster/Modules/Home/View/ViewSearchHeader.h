//
//  ViewSearchHeader.h
//  LeftMaster
//
//  Created by simple on 2018/6/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewSearchHeader : UIView
@property (nonatomic, assign) NSInteger count;
@property(nonatomic,strong)UITextField *tfText;
@property(nonatomic,strong)UILabel *lbCount;
@property(nonatomic,weak)id<CommonDelegate> delegate;
- (void)startAnimation;

@end
