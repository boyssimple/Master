//
//  ViewPayWay.h
//  LeftMaster
//
//  Created by simple on 2018/8/12.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPayWay : UIView
@property(nonatomic,strong)UILabel *lbTitle;
@property(nonatomic,strong)UIButton *btnCheck;
@property(nonatomic,strong)UIView *vLine;
@property(nonatomic,strong)UILabel *lbDesc;
@property(nonatomic,strong)void(^clickBlock)(NSInteger index,BOOL selected);
- (void)updateData:(NSString*)title withDesc:(NSString*)desc;
@end
