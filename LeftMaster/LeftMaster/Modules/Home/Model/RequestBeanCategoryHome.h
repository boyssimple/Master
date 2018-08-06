//
//  RequestBeanCategoryHome.h
//  LeftMaster
//
//  Created by simple on 2018/4/11.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "AJRequestBeanBase.h"

@interface RequestBeanCategoryHome : AJRequestBeanBase

@property(nonatomic,strong)NSString* parent_id;
@property(nonatomic,assign)NSInteger page_current;
@property(nonatomic,assign)NSInteger page_size;
@property(nonatomic,strong)NSString *search_name;
@end

@interface ResponseBeanCategoryHome : AJResponseBeanBase
@property(nonatomic,assign)NSInteger success;
@property(nonatomic,strong)NSString *msg;
@property(nonatomic,strong)NSDictionary *data;
@end
