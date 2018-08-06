//
//  ViewISBill.h
//  LeftMaster
//
//  Created by simple on 2018/4/23.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Custom.h"

@interface ViewISBill : UIView
@property(nonatomic,weak)id<CommonDelegate> delegate;
- (void)updateData:(Custom*)cust;
@end
