//
//  RequestBeanBillList.h
//  LeftMaster
//
//  Created by simple on 2018/7/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestBeanBillList : AJRequestBeanBase
@property(nonatomic,strong)NSString *cus_id;     //cus_id
@property(nonatomic,strong)NSString *ym;     //cus_id
@property(nonatomic,assign)NSInteger bill_status; //0
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@end

@interface ResponseBeanBillList : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
