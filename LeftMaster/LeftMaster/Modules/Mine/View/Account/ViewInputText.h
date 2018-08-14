//
//  ViewInputText.h
//  LeftMaster
//
//  Created by simple on 2018/8/13.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewInputText : UIView
@property(nonatomic,assign)NSInteger type;//1:无按钮 2:有按钮
@property(nonatomic,strong)UILabel *lbName;
@property(nonatomic,strong)UITextField *tfText;
@property(nonatomic,strong)UIButton *btnButton;
@property(nonatomic,strong)void(^clickBlock)(void);
@end
