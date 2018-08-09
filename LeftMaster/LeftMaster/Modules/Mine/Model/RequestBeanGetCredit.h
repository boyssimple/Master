//
//  RequestBeanGetCredit.h
//  LeftMaster
//
//  Created by simple on 2018/8/9.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanGetCredit : AJRequestBeanBase
@property(nonatomic,strong)NSString *cus_id;
@end

@interface ResponseBeanGetCredit : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
